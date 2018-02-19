({
    handleRecordUpdated: function(component, event, helper) {
        console.log("handleRecordUpdated.", event);
        var eventParams = event.getParams();
        if(eventParams.changeType === "LOADED") {
           // record is loaded (render other component which needs record data value)
            console.log("Record is loaded successfully.");
            var record = component.get("v.simpleRecord");
            console.log(JSON.stringify(record));
        	var container = component.find("container");
        	$A.createComponent(
                "force:recordView",
                {type: "FULL", record: record},
                function(cmp) {
                    container.set("v.body", [cmp]);
                }
           	);
        } else if(eventParams.changeType === "CHANGED") {
            // record is changed
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving, or deleting the record
        }
    }
})