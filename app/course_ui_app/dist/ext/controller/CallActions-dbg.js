sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/Dialog",
    "sap/m/ComboBox",
    "sap/m/Label"
], function (MessageToast, Dialog, ComboBox, Label) {
    'use strict';

    return {
        /**
         * Generated event handler.
         *
         * @param oContext the context of the page on which the event was fired. `undefined` for list report page.
         * @param aSelectedContexts the selected contexts of the table rows.
         */
        updateStatusOfCourse: function (oContext, aSelectedContexts) {
            //MessageToast.show("Custom handler invoked.");
            let coursID = oContext.getObject().ID;
            let status_code = "";
            if (!this.oDialog) {
                this.loadFragment({
                    name: "com.course.app.courseuiapp.fragments.statusDialog",
                    contextPath: oContext.getPath()
                }).then(function (oDialog) {
                    this.oDialog = oDialog;
                    this.oDialog.open()
                }.bind(this));
            } else {
                this.oDialog.open();
            }


        },
        onSubmitData: function (oEvent) {
            let statusCode = sap.ui.getCore().byId('oStatusCombobox').getSelectedKey();
            let courseID = oEvent.getSource().getBindingContext().getObject().ID;
            let sAction = "updateCourseStatus";
            this.editFlow.invokeAction(sAction, {
                model: oEvent.getSource().getModel(),
                parameterValues: [
                    {
                        "name": "courseID",
                        "value": courseID
                    },
                    {
                        "name": "statusCode",
                        "value": statusCode
                    }
                ],
                skipParameterDialog: true
            }).then(function(oresponse) {
                this.oDialog.close();
                this._controller.getExtensionAPI().refresh();
                //MessageToast.show("Status Updated!");
            }.bind(this)).catch(function(error){
                this.oDialog.close();
                MessageToast.show("Failed to update Status");
            }.bind(this));
        },
        onCloseDialog: function(oEvent){
            oEvent.getSource().getParent().close();
        }
    };
});
