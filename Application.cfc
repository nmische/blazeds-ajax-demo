<cfcomponent extends="org.corfield.framework">
<cfscript>

	this.name="sortabledemo";
	this.sessionManagement="true";	

	function setupApplication() {	
		application.users = {};
		application.listItems = [
				{id=1,label="Item 1"},
				{id=2,label="Item 2"},
				{id=3,label="Item 3"},
				{id=4,label="Item 4"},
				{id=5,label="Item 5"} 
			];	
	}
	
	function onSessionEnd(SessionScope,ApplicationScope) {
		StructDelete(arguments.ApplicationScope.users,arguments.SessionScope.username);		
	}

</cfscript>
</cfcomponent>
