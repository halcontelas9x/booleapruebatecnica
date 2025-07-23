public with sharing class SupportRequestLwcController {
    
    @AuraEnabled
    public static void procesarRegistro(Id recordId) {
        SupportRequest__c request = SupportRequestLwcControllerDAO.getSupportRequest(recordId);
        if (request != null) {
            SupportRequestService.actualizarFechaSupportRequests(new List<SupportRequest__c>{request});
            update request;
        }
    }

    @AuraEnabled
    public static String estadoRegistro(Id recordId) {
        try {
            SupportRequest__c request = SupportRequestLwcControllerDAO.getSupportRequest(recordId);
            if (request != null) {
                return request.Status__c;
            }
        } catch (Exception e) {
            return '[SupportRequestLwcController] Error estadoRegistro: ' + e.getMessage();
        }
        return null;
    }
}
