<cfcomponent persistent="true">
	
	<cfproperty name="id" fieldtype="id" ormtype="int" generator="increment" />
	<cfproperty name="AliyahOne" />
	<cfproperty name="AliyahTwo" />
	<cfproperty name="AliyahThree" />
	<cfproperty name="AliyahFour" />
	<cfproperty name="AliyahFive" />
	<cfproperty name="AliyahSix" />
	<cfproperty name="AliyahSeven" />
	<cfproperty name="haftarah" />
	<cfproperty name="maftir" />
	<cfproperty name="torah" />
	<cfproperty name="Triennial" cfc="HebCalTriennial" fieldtype="one-to-one" fkcolumn="TriennialId" />
	
</cfcomponent>