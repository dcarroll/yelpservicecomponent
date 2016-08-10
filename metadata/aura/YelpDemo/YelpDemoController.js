 ({
 	renderYelpData: function(component, event, helper) {
 		helper.doLayout(component, event.getParams());
 	},

	doInit: function(component, event, helper) {
		helper.initializeLayout(component, event, helper);
    },

    getBrowserLocation: function(component, event, helper) {
    	navigator.geolocation.getCurrentPosition(function(e) {
            component.set("v.latlon", e.coords.latitude + ',' + e.coords.longitude);
            helper.getYelpData(component);
        },
        function() {
            component.set("v.errorMessage", "Could not get your current geolocation.");
            var warning = component.find('warning');
            $A.util.removeClass(warning, 'slds-hide');
        });
    },

    updateSearch: function(component, event, helper) {
    	helper.getRecordLocation(component);
    },

    backButton: function(component, event, helper) {
    	helper.handleBackButton(component);
    },

    mapLoaded: function(component) {
    	debugger;
        component.rerender();
    },

    showDetails: function(component, event, helper) {
        component.rerender();
        debugger;
        var panel = component.find('panelDetails');
        $A.util.removeClass(panel, 'slds-hide');
        var selectedItem = event.currentTarget;
        var recID = selectedItem.dataset.record;
        var data = component.get('v.restaurantList');
        var map = component.get("v.map");
        var markers = component.get('v.markers');
        var recordLoc = component.get("v.staticLocation");
        if (markers) {
            markers.clearLayers();
        }
        var orgLoc = L.marker([recordLoc.latitude, recordLoc.longitude]);
        var bizLoc = L.marker([data[recID].location.latitude, data[recID].location.longitude]);
        bizLoc.bindPopup("<b>" + data[recID].name + "</b>").openPopup();
        markers.addLayer(orgLoc);
        markers.addLayer(bizLoc);
        map.addLayer(markers);
        helper.updateMap(map, data[recID].location.latitude, data[recID].location.longitude);

        var panelList = component.find("panelList");
        var panelDetails = component.find("panelDetails");
        $A.util.removeClass(panelList, 'panel--visible');
        $A.util.addClass(panelList, 'panel--stageLeft');
        $A.util.removeClass(panelDetails, 'panel--stageRight');
        $A.util.addClass(panelDetails, 'panel--visible');
        component.set("v.itemName", data[recID].name);
        component.set("v.address", data[recID].address);
        component.set("v.city", data[recID].city);
        component.set("v.state", data[recID].state);
        component.set("v.phone", data[recID].phone);
        component.set("v.image", data[recID].image);
        component.set("v.review", data[recID].review);
    },

})
