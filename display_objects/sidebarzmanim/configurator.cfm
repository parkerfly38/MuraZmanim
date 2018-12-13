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

</cfscript>

<!--- The cf_objectconfigurator tags add some default form fiels such as alignment, etc. --->
<!--- <cf_objectconfigurator> --->
    <cfoutput>
        <div class="mura-control-group">
            <label class="mura-control-label">Message</label>
            <input  type="text"
                    name="sidebarcal"
                    class="objectParam"
                    value="#esapiEncode('html_attr', objectparams.sidebarcal)#">
        </div>
    </cfoutput>
<!--- </cf_objectconfigurator> --->
