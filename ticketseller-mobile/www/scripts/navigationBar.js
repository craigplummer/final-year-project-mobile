var navigationButton = {};
navigationButton.SystemItemDone = 0;
navigationButton.SystemItemCancel = 1;
navigationButton.SystemItemEdit = 2;
navigationButton.SystemItemSave = 3;
navigationButton.SystemItemAdd = 4;
navigationButton.SystemItemFlexibleSpace = 5;
navigationButton.SystemItemFixedSpace = 6;
navigationButton.SystemItemCompose = 7;;
navigationButton.SystemItemReply = 8;
navigationButton.SystemItemAction = 9;
navigationButton.SystemItemOrganize = 10;
navigationButton.SystemItemBookmarks = 11;
navigationButton.SystemItemSearch = 12;
navigationButton.SystemItemRefresh = 13;
navigationButton.SystemItemStop = 14;
navigationButton.SystemItemCamera = 15;
navigationButton.SystemItemTrash = 16;
navigationButton.SystemItemPlay = 17;
navigationButton.SystemItemPause = 18;
navigationButton.SystemItemRewind = 19;
navigationButton.SystemItemFastForward = 20;
navigationButton.SystemItemUndo = 21;
navigationButton.SystemItemRedo = 22;
navigationButton.SystemItemPageCurl = 23;

var navigationBarCallbacks = new Array();

UIControls.prototype.hideNavigationBar = function() {
    PhoneGap.exec("UIControls.hideNavigationBar");
};

UIControls.prototype.createNavigationBar = function() {
    PhoneGap.exec("UIControls.createNavigationBar");
};

UIControls.prototype.setNavigationBarTitle = function(title) {
    PhoneGap.exec("UIControls.setNavigationBarTitle", title);
};

UIControls.prototype.setNavigationBarLeftButton = function(options) {
	if (options && options.onTap)
		navigationBarCallbacks[1] = options.onTap;	
    PhoneGap.exec("UIControls.setNavigationBarLeftButton", options);
};

UIControls.prototype.setNavigationBarRightButton = function(options) {
	if (options && options.onTap)
		navigationBarCallbacks[2] = options.onTap;
    PhoneGap.exec("UIControls.setNavigationBarRightButton", options);
};

UIControls.prototype.removeNavigationBarRightButton = function(options) {
	PhoneGap.exec("UIControls.removeNavigationBarRightButton", options);
}

UIControls.prototype.removeNavigationBarLeftButton = function(options) {
	PhoneGap.exec("UIControls.removeNavigationBarLeftButton", options);
}

UIControls.prototype.navigationBarButtonClicked = function(tag) {
	if (navigationBarCallbacks[tag] && typeof(navigationBarCallbacks[tag]) == 'function')
		navigationBarCallbacks[tag]();
};

function UIControls() { 
} 

PhoneGap.addConstructor(function() { 
						if(!window.plugins) { 
						window.plugins = {}; 
						} 
						window.plugins.uicontrols = new UIControls(); 
						}); 