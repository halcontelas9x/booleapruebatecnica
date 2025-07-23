public without sharing class SupportRequestBatch implements Database.Batchable<SObject>, Database.Stateful{
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String pendingInternal = SupportRequestService.STATUS_PENDING_INTERNAL;
        String pendingCustomer = SupportRequestService.STATUS_PENDING_CUSTOMER;
        String query = 'SELECT Id, Status__c, Priority__c, ExpectedResolutionDate__c  FROM SupportRequest__c WHERE Status__c IN (:pendingInternal, :pendingCustomer)';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext batchContext, List<SupportRequest__c> scope){
        SupportRequestService.actualizarFechaSupportRequests(scope);
        update scope;
    }

    public void finish(Database.BatchableContext batchContext){
        System.debug('*** SupportRequestBatch END OF BATCH ***');
    }
}