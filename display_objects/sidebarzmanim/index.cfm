<cfscript>
/**
*
* This file is part of MuraZmanim
*
* Copyright 2013-2018 Brian Kresge, MBA, MCSD.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
	zmanimSettings = entityLoad("MuraZmanimSettings");
	if (isnull(znaminSettings) || arrayIsEmpty(zmanimSettings))
	{
		hebCalId = 1;
	} else {
		hebCalId = zmanimSettings[0].getHebCalId();
	}
	
</cfscript>
<cfquery name="hebCal">
	SELECT * from HebCal WHERE id = #hebcalId#
</cfquery>
<cfquery name="hebCalForRender">
	SELECT TOP 5 * FROM HebCalItem WHERE ItemID = #hebCalId# AND date >= #Now()#
	ORDER BY date asc
</cfquery>
<cfoutput>
	<h3>Zmanim for #ReplaceNoCase(hebCal.title[1],"HebCal 2018 ","")#</h3>
  	<ul>
  		<cfloop query="#hebCalForRender#">
  		<li><strong>#title#</strong><br />#UrlDecode(hebrew,'utf-8')#<br />#DateFormat(date)#
  		<cfif Len(link) gt 0><br /><a href="#link#" target="_blank">Details</a></cfif></li>
  		</cfloop>
  	</ul>
</cfoutput>