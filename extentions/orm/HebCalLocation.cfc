<cfcomponent persistent="true">
	
	<cfproperty name="id" fieldtype="id" ormtype="int" generator="increment" />
	<cfproperty name="geo" />
	<cfproperty name="latitude" ormtype="float" />
	<cfproperty name="longitude" ormtype="float" />
	<cfproperty name="tzid" />
	<cfproperty name="title" />

</cfcomponent>