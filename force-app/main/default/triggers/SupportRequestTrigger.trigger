trigger SupportRequestTrigger on SupportRequest__c (before insert, before update) {
    
    new SupportRequestTriggerHandler().run();

}