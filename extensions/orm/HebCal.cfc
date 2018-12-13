<cfcomponent persistent="true">

	<cfproperty name="id" ormtype="int" fieldtype="id" generator="increment" />
	<cfproperty name="title" />
	<cfproperty name="longitude" ormtype="float" />
	<cfproperty name="latitude" ormtype="float" />
	<cfproperty name="date" ormtype="date" />
	<cfproperty name="link" />
	<cfproperty name="Location" cfc="HebCalLocation" fieldtype="one-to-one" fkcolumn="LocationId" />
	<cfproperty name="Items" type="array" cfc="HebCalItem" fieldtype="one-to-many" fkcolumn="ItemId" />

</cfcomponent>