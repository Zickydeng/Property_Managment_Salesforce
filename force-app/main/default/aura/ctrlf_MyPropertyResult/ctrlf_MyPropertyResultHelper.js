({

fetchAllPropertyHelper : function(component, event, helper) {

var action = component.get('c.getLatestProperty');

        action.setCallback(this,function(response){

        var responseValues= response.getReturnValue();

            component.set('v.propertyList',responseValues);

            component.set('v.propertiesFound',true);

        });

        $A.enqueueAction(action,false);

}

})