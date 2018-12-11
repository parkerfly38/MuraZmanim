<cfscript>
/**
*
* This file is part of MuraZmanim
*
* Copyright 2013-2018 Brian Kresge, MBA, MCSD
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
</cfscript>
<style type="text/css">
	#bodyWrap h3{padding-top:1em;}
	#bodyWrap ul{padding:0 0.75em;margin:0 0.75em;}
</style>
<cfsavecontent variable="body"><cfoutput>
<div id="bodyWrap">
	<h1>#HTMLEditFormat(pluginConfig.getName())#</h1>
	<p>This is a plugin that displays Zmanim data</p>

	<h3>Tested With</h3>
	<ul>
		<li><a href="http://www.getmura.com">Mura CMS</a> Core Version <strong>7.1+</strong></li>
		<li><a href="http://www.adobe.com/coldfusion">Adobe ColdFusion</a> <strong>2016.0.02.299200</strong></li>
		<li><a href="http://lucee.org">Lucee</a> <strong>5.0.0.254</strong></li>
	</ul>

	<h3>Need help?</h3>
	<p>If you're running into an issue, please let me know at <a href="https://github.com/parkerfly38/#HTMLEditFormat(pluginConfig.getPackage())#/issues">https://github.com/parkerfly38/#HTMLEditFormat(pluginConfig.getPackage())#/issues</a> and I'll try to address it as soon as I can.</p>

	<h3>!שלום<br />
	<a href="http://www.covebrookcode.com">ּBrian Kresge, MBA, MCSD</a></h3>
</div>
</cfoutput></cfsavecontent>
<cfoutput>
	#$.getBean('pluginManager').renderAdminTemplate(body=body, pagetitle=pluginConfig.getName())#
</cfoutput>
