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
<cfquery name="hebCalForRender">
	SELECT TOP 5 * FROM HebCalItem WHERE ItemID = #hebCalId# AND date >= #Now()#
	ORDER BY date asc
</cfquery>
<cfoutput>
	<h3>Zmanim</h3>
  	<ul>
  		<cfloop query="#hebCalForRender#">
  		<li><strong>#title#</strong><br />#UrlDecode(hebrew,'utf-8')#<br />#DateFormat(date)#
  		<cfif Len(link) gt 0><br /><a href="#link#" target="_blank">Details</a></cfif></li>
  		</cfloop>
  	</ul>
	

	<!---
	<script>
	  // If you wish to add CSS or JS ...
	  Mura(function(m) { 
			var pluginpath = '#pluginpath#';

	    m.loader() 
	      .loadcss(pluginpath + '/display_objects/sayhello/my.css') 
	      .loadjs(
	        pluginpath + '/display_objects/sayhello/my.js',
	        pluginpath + '/display_objects/sayhello/other.js',
	        function() {
	          // Do something with the loaded JS
	        }
	      ); 
	  });
	</script>
	--->
</cfoutput>
