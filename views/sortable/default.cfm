<cfsavecontent variable="htmlHead">
	<script type="text/javascript" src="assets/js/FABridge.js"></script>
	<script type="text/javascript" src="assets/js/FDMSLib.js"></script>
	<script language="JavaScript">
	var BlazeDSDemo = function () {

		var channelSet;
		var producer;
		var consumer;

		function messageHandler(event){
			var body = event.getMessage().getBody();
			//console.log(body);
			$("#sortable").sortable("fromArray",body.msg);
		}

		return {
			fdmsLibraryReady: function () {

				//console.log("FDMS Library Ready");

				// set up channel set
				channelSet = new ChannelSet();
				channelSet.addChannel( new AMFChannel("cf-polling-amf",
					"http://<cfoutput>#cgi.server_name#<cfif cgi.server_port neq 80>:#cgi.server_port#</cfif></cfoutput>/flex2gateway/cfamfpolling"));

				// set up producer
				producer = new Producer();
				producer.setDestination("ColdFusionGateway");
				producer.setChannelSet(channelSet);

				// set up consumer
				consumer = new Consumer();
				consumer.setDestination("ColdFusionGateway");
				consumer.addEventListener("message", messageHandler);
				//consumer.setSelector("username <> '<cfoutput>#session.username#</cfoutput>'")
				consumer.setChannelSet(channelSet);
				consumer.subscribe();
			},

			sendMessage: function(message) {
				var body = {
					msg: message
				};
				var headers = {
					gatewayid: "sortDemoGateway",
					username: "<cfoutput>#session.username#</cfoutput>"
				};
				var asyncMsg = new AsyncMessage();
				asyncMsg.setBody(body);
				asyncMsg.setHeaders(headers);

				//console.log(asyncMsg);

				producer.send(asyncMsg);
			}

		}

	}();

	$(function() {
		$.ui.sortable.prototype.fromArray = function( newOrder ) {
			$.each(newOrder,function( intIndex, objValue ){
				var selector = "#" + objValue;
				$(selector).fadeOut(600,function(){
					$(this).parent().append(this);
					$(this).fadeIn(600);
				});
			})
		}

		$("#sortable").sortable({
			stop: function (event, ui) {
				var arrayOrder = $("#sortable").sortable("toArray");
				BlazeDSDemo.sendMessage(arrayOrder);
			}
		});

		$("#sortable").disableSelection();

		$("#logoutBtn").button();
	});
	</script>
	<style type="text/css">
		/*demo page css*/
		#sortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
		#sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; }
		#sortable li span { position: absolute; margin-left: -1.3em; }
	</style>
</cfsavecontent>
<cfhtmlhead text="#htmlHead#" />

<cfoutput>
<h1>Sortable List Demo</h1>

<div class="demo">

<ul id="sortable">
	<cfloop array="#rc.listItems#" index="item">
		<li class="ui-state-default" id="item_#item.id#"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>#item.label#</li>
	</cfloop>
</ul>

<div class="formButtons">
	<a href="#buildURL("main.logout")#" id="logoutBtn">Logout</a>
</div>

</div>
</cfoutput>

<script language="JavaScript">
FDMSLibrary.load("assets/swf/FDMSBridge.swf", BlazeDSDemo.fdmsLibraryReady);
</script>
