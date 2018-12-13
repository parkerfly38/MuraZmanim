<cfcomponent persistent="true">

	<cfproperty name="id" fieldtype="id" ormtype="int" generator="increment" />
	<cfproperty name="link" />
	<cfproperty name="date" ormtype="date" />
	<cfproperty name="subcat" />
	<cfproperty name="memo" />
	<cfproperty name="category" />
	<cfproperty name="hebrew" type="string" sqltype="nvarchar(255)" />
	<cfproperty name="title" sqltype="nvarchar(255)" />
	<cfproperty name="Leyning" cfc="HebCalLeyning" fieldtype="one-to-one" fkcolumn="LeyningId" />

</cfcomponent>