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

	param name='objectparams.sidebarcal' default='';	
	hebcals = EntityLoad("HebCal");
	selectedHebCal = EntityLoad("MuraZmanimSettings");
</cfscript>
<cfif isDefined("form.hebcal")>
	<cfset currentHebCal = EntityLoadByPK("MuraZmanimSettings", 1) />
	<cfif isnull(currentHebCal) or arrayisEmpty(currentHebCal)>
		<cfset currentHebCal = EntityNew("MuraZmanimSettings") />
	</cfif>
	<cfset currentHebCal.setHebCalId(form.hebcal) />
	<cfset EntitySave(currentHebCal) />
</cfif>	
<form action="index.cfm" method="post">
		<div class="form-group">
			<cfif !isnull(selectedHebCal) AND !ArrayIsEmpty(selectedHebCal)>
				<cfset selectedCal = selectedHebCal[0].getHebCalId() />
			<cfelse>
				<cfset selectedCal = 1 />
			</cfif>
			<label>Select a Hebrew Calendar Location to Display</label>
			<select name="hebcal" id="hebcal">
				<cfloop array="#hebcals#" index="cal">
					<option value="#cal.getId()#" <cfif selectedCal eq cal.getId()>selected</cfif>>#cal.getTitle()#</option>
				</cfloop>
			</select>
			<input type="submit" value="Set Site Zmanim Location" class="btn btn-default" />
		</div>
	</form>
<!--- The cf_objectconfigurator tags add some default form fiels such as alignment, etc. --->
<!--- <cf_objectconfigurator> --->
    <!---<cfoutput>
        <div class="mura-control-group">
            <label class="mura-control-label">Message</label>
            <input  type="text"
                    name="sidebarcal"
                    class="objectParam"
                    value="#esapiEncode('html_attr', objectparams.sidebarcal)#">
        </div>
    </cfoutput>--->
<!--- </cf_objectconfigurator> --->
