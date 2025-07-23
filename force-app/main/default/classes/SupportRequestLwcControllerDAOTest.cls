@isTest
private class SupportRequestLwcControllerDAOTest {

    @isTest
    static void testGetSupportRequest() {
        SupportRequest__c request = new SupportRequest__c(
            Priority__c = SupportRequestService.PRIORITY_MEDIUM,
            ExpectedResolutionDate__c = System.Date.today().addDays(10),
            Status__c = SupportRequestService.STATUS_TO_MANAGE
        );
        insert request;

        Test.startTest();
        SupportRequest__c resultado = SupportRequestLwcControllerDAO.getSupportRequest(request.Id);
        Test.stopTest();

        // Validaciones
        System.assertNotEquals(null, resultado);
        System.assertEquals(request.Id, resultado.Id);
        System.assertEquals(SupportRequestService.PRIORITY_MEDIUM, resultado.Priority__c);
        System.assertEquals(SupportRequestService.STATUS_TO_MANAGE, resultado.Status__c);
    }
}
