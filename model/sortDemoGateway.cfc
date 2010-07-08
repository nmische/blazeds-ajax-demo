<cfcomponent>

	<cffunction name="onIncomingMessage">
		<cfargument name="event" />
		
		<cfset var msg = {} />
		<cfset msg["destination"] = "ColdFusionGateway" />
		<cfset msg["body"]["msg"] = event.data.body.msg />
		<cfset msg["headers"]["username"] = event.data.headers.username />
		<cfset msg["headers"]["gatewayid"] = event.data.headers.gatewayid />
		
		<cfset sortItems(event.data.body.msg) />
						
		<cfreturn msg />
		
	</cffunction>

	<cffunction name="sortItems">
		<cfargument name="ids" />
		<cfset var elId = "" />
		<cfset var id = "" />
		<cfset var currentPosition = "" />
		<cfset var newPosition = "" />		
		<cflock scope="application" type="exclusive" timeout="10" throwontimeout="true">
			<cfloop from="1" to="#ArrayLen(arguments.ids)#" index="newPosition">				
				<cfset elId = arguments.ids[newPosition] />
				<cfset id = GetToken(elId,2,"_") />					
				<cfset currentPosition = findID(id) />
				<cfif currentPosition gt 0>
					<cfset ArraySwap(application.listItems,currentPosition,newPosition) />		
				</cfif>							
			</cfloop>				
		</cflock>		
	</cffunction>
	
	<cffunction name="findID">
		<cfargument name="id">
		<cfset var i = 1 />
		<cfloop from="1" to="#ArrayLen(application.listItems)#" index="i">
			<cfif application.listItems[i].id eq arguments.id>
				<cfreturn i />
			</cfif>
		</cfloop>		
		<cfreturn 0/>	
	</cffunction>
	

</cfcomponent>
