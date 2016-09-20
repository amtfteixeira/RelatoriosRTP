sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/m/MessageToast"
], function (Controller, MessageToast) {
	"use strict";

	return Controller.extend("sap.ui.demo.wt.controller.HelloPanel", {

		onShowHello : function () {
			// read msg from i18n model
			var oBundle = this.getView().getModel("i18n").getResourceBundle();
			var sRecipient = this.getView().getModel().getProperty("/recipient/name");
			var sMsg = oBundle.getText([sRecipient]);

			// show message
			MessageToast.show(sMsg);
			
			
			$.ajax({
			     url :"resources/marksGraph.jsp",
			     contentType : "application/json",
			     data: sMsg,
			     type :"POST",
			     success :function(json) {
			    	 					
			                              window.open("resources/marksGraph.jsp?var=" + sMsg, "_self");    
			                              newWindow.document.write(sMsg);
			                             },
			     error :function(xhr, status) {
			                              alert("Não gerou!");
			                            }
			    
			 
			      });
			
			
			
			
			
		},

		onOpenDialog : function () {
			//this.getOwnerComponent().helloDialog.open(this.getView());
			
			$.ajax({
			     url :"resources/mark1.jsp",
			     contentType : "application/json",
			     type :"GET",
			     success :function(json) {
			    	
			    	 window.open("resources/mark1.jsp", "_self");        
			                             },
			     error :function(xhr, status) {
			                              alert("Não gerou!");
			                            }
			    
			 
			      });
				
			
		}
	});

});
