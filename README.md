# BlazeDS AJAX Demo

This demo shows how you can use the BlazeDS AJAX library to keep two lists in sync.

## Requirements

* [ColdFusion](http://www.adobe.com/products/coldfusion/) with [BlazeDS](http://opensource.adobe.com/wiki/display/blazeds/BlazeDS/)
    * ColdFusion 9 ships with BlazeDS
    * ColdFusion 8 requires that you manually install BlazeDS
* [FW/1 Framework](fw1.riaforge.org/)
    * This demo assumes that FW/1 is available at org.corfield.framework

## Setup
* Install the contents of this repo into a folder in your webroot (i.e. {webroot}/blazeds-ajax-demo)
* Create a new event gateway to handle messaging
    * In the ColdFusion administrator navigate to "Event Gateways" -> "Gateway Instances"
    * Under "Add / Edit ColdFusion Event Gateway Instances" enter the following
        * Gateway ID: sortDemoGateway
        * Gateway Type: DataServicesMessaging
        * CFC Path: {path to this demo}/model/sortDemoGateway.cfc
        * Configuration File: {leave blank}
        * Startup Mode: Automatic
        * Click "Add Gateway Instance"
    * Once the gateway is created be sure to start it under "Configured ColdFusion Event Gateway Instances"

## Running
* Open the application and log in with any username (i.e. "Tester1")
* Open the application in another browser and log in with a different username (i.e. "Tester2")
* Drag the list items to re-order.
* Observe that when the list is re-ordered in one browser, the list in the other browser is updated within a few seconds.