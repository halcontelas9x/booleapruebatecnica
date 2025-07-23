public without sharing class SupportRequestLwcControllerDAO{
  
    public static SupportRequest__c getSupportRequest(Id recordId){
        return [SELECT Id, Priority__c, Status__c, ExpectedResolutionDate__c FROM SupportRequest__c WHERE Id = :recordId];
    }
}