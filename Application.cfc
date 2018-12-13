/**
*
* This file is part of MuraZmanim
*
* Copyright 2013-2018 Brian Kresge, MBA, MCSD
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true output=false {

	property name='$';

	this.pluginPath = GetDirectoryFromPath(GetCurrentTemplatePath());
	this.muraroot = Left(this.pluginPath, Find('plugins', this.pluginPath) - 1);
	this.depth = ListLen(RemoveChars(this.pluginPath,1, Len(this.muraroot)), '\/');  
	this.includeroot = RepeatString('../', this.depth);

	if ( DirectoryExists(this.muraroot & 'core') ) {
		// Using 7.1
		this.muraAppConfigPath = this.includeroot & 'core/';
		include this.muraAppConfigPath & 'appcfc/applicationSettings.cfm';
	} else {
		// Pre 7.1
		this.muraAppConfigPath = this.includeroot & 'config';
		include this.includeroot & 'config/applicationSettings.cfm';

		try {
			include this.includeroot & 'config/mappings.cfm';
			include this.includeroot & 'plugins/mappings.cfm';
		} catch(any e) {}
	}



	// ----------------------------------------------------------------------
	// HELPERS

	private struct function get$() {
		if ( !StructKeyExists(arguments, '$') ) {
			var siteid = StructKeyExists(session, 'siteid') ? session.siteid : 'default';

			arguments.$ = StructKeyExists(request, 'murascope')
				? request.murascope
				: StructKeyExists(application, 'serviceFactory')
					? application.serviceFactory.getBean('$').init(siteid)
					: {};
		}

		return arguments.$;
	}

	public any function secureRequest() {
		var $ = get$();
		return !inPluginDirectory() || $.currentUser().isSuperUser()
			? true
			: ( inPluginDirectory() && !StructKeyExists(session, 'siteid') )
				|| ( inPluginDirectory() && !$.getBean('permUtility').getModulePerm($.getPlugin(variables.settings.pluginName).getModuleID(),session.siteid) )
				? goToLogin()
				: true;
	}

	public boolean function inPluginDirectory() {
		var uri = getPageContext().getRequest().getRequestURI();
		return ListFindNoCase(uri, 'plugins', '/') && ListFindNoCase(uri, variables.settings.package,'/');
	}

	private void function goToLogin() {
		var $ = get$();
		location(url='#$.globalConfig('context')#/admin/index.cfm?muraAction=clogin.main&returnURL=#$.globalConfig('context')#/plugins/#$.getPlugin(variables.settings.pluginName).getPackage()#/', addtoken=false);
	}

	private boolean function isSessionExpired() {
		var p = variables.settings.package;
		return !StructKeyExists(session, p)
				|| DateCompare(now(), session[p].expires, 's') == 1
				|| DateCompare(application.appInitializedTime, session[p].created, 's') == 1;
	}

	private void function setupSession() {
		var p = variables.settings.package;
		StructDelete(session, p);
		// Expires - s:seconds, n:minutes, h:hours, d:days
		session[p] = {
			created = Now()
			, expires = DateAdd('d', 1, Now())
			, sessionid = Hash(CreateUUID())
		};
	}

}
