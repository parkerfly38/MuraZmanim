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
if ( !IsDefined('$') ) {
	$ = application.serviceFactory.getBean('$');
	if ( StructKeyExists(session, 'siteid') ) {
		$.init(session.siteid);
	} else {
		$.init('default');
	};
};
</cfscript>
<cfprocessingdirective pageencoding="utf-8" />
<cfif IsDefined("form.zipcode")>
	<cfhttp method="GET" result="hebCalResult" url="http://www.hebcal.com/hebcal/?v=1&cfg=json&maj=on&min=on&mod=on&nx=on&year=now&ss=on&mf=on&c=on&geo=zip&zip=#form.zipcode#&m=50&s=on&lg=sh" />
<cfset json = DeserializeJSON(hebCalResult.filecontent) />
<cfset hebCal = EntityNew("HebCal") />
<cfset hebCalLocation = EntityNew("HebCalLocation" ) />
<cfscript>
	ormreload();
	hebCalLocation.setGeo(json.location.geo);
	hebCalLocation.setLatitude(json.location.latitude);
	hebCalLocation.setLongitude(json.location.longitude);
	hebCalLocation.setTzid(json.location.tzid);
	hebCalLocation.setTitle(json.location.title);
	EntitySave(hebCalLocation);
	ormflush();
	hebCal.setTitle(json.title);
	hebCal.setLongitude(json.longitude);
	hebCal.setLatitude(json.latitude);
	hebCal.setDate(json.date);
	hebCal.setLink(json.link);
	hebCal.setLocation(hebCalLocation);
			
	//now iterate items
	for (item in json.items)
	{
		hebCalItem = "";
		hebCalItem = EntityNew("HebCalItem");
		if (isDefined("item.link")) { hebCalItem.setLink(item.link); }
		hebCalItem.setDate(item.date);
		if (isDefined("item.subcat")) hebCalItem.setSubcat(item.subcat);
		if (isDefined("item.memo")) hebCalItem.setMemo(item.memo);
		hebCalItem.setCategory(item.category);
		hebCalItem.setHebrew(item.hebrew);
		hebCalItem.setTitle(item.title);
		
		if (item.category == "parashat")
		{
			hebCalTriennial = EntityNew("HebCalTriennial");
			hebCalTriennial.setAliyahOne(item.leyning.triennial["1"]);
			hebCalTriennial.setAliyahTwo(item.leyning.triennial["2"]);
			hebCalTriennial.setAliyahThree(item.leyning.triennial["3"]);
			hebCalTriennial.setAliyahFour(item.leyning.triennial["4"]);
			hebCalTriennial.setAliyahFive(item.leyning.triennial["5"]);
			hebCalTriennial.setAliyahSix(item.leyning.triennial["6"]);
			hebCalTriennial.setAliyahSeven(item.leyning.triennial["7"]);
			hebCalTriennial.setMaftir(item.leyning.triennial.maftir);
			entitySave(hebCalTriennial);
			ormflush();
			hebCalLeyning = EntityNew("HebCalLeyning");
			hebCalLeyning.setAliyahOne(item.leyning["1"]);
			hebCalLeyning.setAliyahTwo(item.leyning["2"]);
			hebCalLeyning.setAliyahThree(item.leyning["3"]);
			hebCalLeyning.setAliyahFour(item.leyning["4"]);
			hebCalLeyning.setAliyahFive(item.leyning["5"]);
			hebCalLeyning.setAliyahSix(item.leyning["6"]);
			hebCalLeyning.setAliyahSeven(item.leyning["7"]);
			hebCalLeyning.setHaftarah(item.leyning.haftarah);
			hebCalLeyning.setMaftir(item.leyning.maftir);
			hebCalLeyning.settorah(item.leyning.torah);
			hebCalLeyning.setTriennial(hebCalTriennial);
			entitySave(hebCalLeyning);
			ormflush();
			hebCalItem.setLeyning(hebCalLeyning);
		}
		
		EntitySave(hebCalItem);
		ormflush();
		hebCal.addItems(hebCalItem);
	}
	try {
		EntitySave(hebCal);
		ormflush();
	}
	catch (any e)
	{
		writeDump(e);
	}
</cfscript>
	
</cfif>
<cfscript>
	hebcals = EntityLoad("HebCal");
</cfscript>
<style type="text/css">
	#bodyWrap h3{padding-top:1em;}
	#bodyWrap ul{padding:0 0.75em;margin:0 0.75em;}
</style>
<cfsavecontent variable="body"><cfoutput>
<div id="bodyWrap">
	<h1>MuraZmanim</h1>
	<p>This is a plugin that displays Zmanim data, retrieving Hebrew calendar data from HebCal.org</p>

	<h3>Tested With</h3>
	<ul>
		<li><a href="http://www.getmura.com">Mura CMS</a> Core Version <strong>7.1+</strong></li>
		<li><a href="http://www.adobe.com/coldfusion">Adobe ColdFusion</a> <strong>2016.0.02.299200</strong></li>
		<li><a href="http://lucee.org">Lucee</a> <strong>5.0.0.254</strong></li>
	</ul>
	
	<form action="index.cfm" method="post">
		<div class="form-group"><label>Enter a zip code to add Zmanim for:</label>
		<input type="text" class="form-control" name="zipcode" id="zipcode" />
		<input type="submit" value="Save" class="btn btn-default" />
		</div>
	</form>
	
	
	<form action="index.cfm" method="post">
		<div class="form-group">
			<label>Select a Hebrew Calendar Location to Display</label>
			<select name="hebcal" id="hebcal">
				<cfloop array="#hebcals#" index="cal">
					<option value="#cal.getId()#">#cal.getTitle()#</option>
				</cfloop>
			</select>
	</form>
	<h3>Need help?</h3>
	<p>If you're running into an issue, please let me know at <a href="https://github.com/parkerfly38/MuraZmanim/issues">https://github.com/parkerfly38/muraZmanim/issues</a> and I'll try to address it as soon as I can.</p>

	<h3>!שלום<br />
	<a href="http://www.covebrookcode.com">?Brian Kresge, MBA, MCSD</a></h3>
</div>
</cfoutput></cfsavecontent>
<cfoutput>
	#$.getBean('pluginManager').renderAdminTemplate(body=body, pagetitle='MuraZmanim')#
</cfoutput>
