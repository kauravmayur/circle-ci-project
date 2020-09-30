({

	updateModelSelection: function (component, event) {
		var incoming = event.getParam("models");
		var dataType = event.getParam("type");
		console.log('incoming : '+incoming);
        console.log('dataType : '+dataType);
        
		var models = component.get("v.modelsByType." + dataType) || [];
        console.log('models : '+models);
		for (var i = 0; i < incoming.length; i++) {
			if (incoming[i].progress == 1 && incoming[i].status === 'SUCCEEDED') { //that is, it's done training and worked
				models.push({ id: incoming[i].modelId, label: incoming[i].name || incoming[i].datasetId + " - " + incoming[i].modelId });
			}
		}

		component.set("v.modelsByType." + dataType, models);
	}
});