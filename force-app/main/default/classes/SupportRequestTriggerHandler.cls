public without sharing class SupportRequestTriggerHandler  extends TriggerHandler{
    List<SupportRequest__c> newList;
    List<SupportRequest__c> oldList;
    Map<Id, SupportRequest__c> newMap;
    Map<Id, SupportRequest__c> oldMap;

    public SupportRequestTriggerHandler(){
        newList = (List<SupportRequest__c>)Trigger.new;
        oldList = (List<SupportRequest__c>)Trigger.old;
        newMap = (Map<Id, SupportRequest__c>)Trigger.newMap;
        oldMap = (Map<Id, SupportRequest__c>)Trigger.oldMap;
    }

    public override void beforeInsert(){
        SupportRequestService.actualizarFechaSupportRequests(newList);
    }

    public override void beforeUpdate() {
        SupportRequestService.actualizarProcesarSupportRequests(newMap, oldMap);
    }


}