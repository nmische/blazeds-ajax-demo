<cfcomponent>

	<cffunction name="init">
		<cfargument name="fw">
		<cfscript>
  		variables.fw = fw;
		</cfscript>
	</cffunction>

	<cffunction name="before">
		<cfargument name="rc">
		<cfscript>
		if (not StructKeyExists(session,"username")) {
			variables.fw.redirect("main.default");
		}
		</cfscript>
	</cffunction>

	<cffunction name="default">
		<cfargument name="rc">
		<cfscript>
			rc.listItems = application.listItems;
		</cfscript>
	</cffunction>
	
</cfcomponent>
