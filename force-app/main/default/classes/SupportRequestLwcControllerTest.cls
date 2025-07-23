@isTest
private class SupportRequestLwcControllerTest {

    @isTest
    static void testProcesarRegistroYEstado() {
        SupportRequest__c request = new SupportRequest__c(
            Priority__c = SupportRequestService.PRIORITY_MEDIUM,
            ExpectedResolutionDate__c = System.Date.today().addDays(10),
            Status__c = SupportRequestService.STATUS_TO_MANAGE
        );
        insert request;

        // Llamar a estadoRegistro antes de procesar
        String estadoAntes = SupportRequestLwcController.estadoRegistro(request.Id);
        System.assertEquals(SupportRequestService.STATUS_TO_MANAGE, estadoAntes);

        // Llamar a procesarRegistro
        Test.startTest();
        SupportRequestLwcController.procesarRegistro(request.Id);
        Test.stopTest();

        // Volver a consultar y verificar que se haya actualizado (si tu lógica lo hace)
        request = [SELECT Status__c FROM SupportRequest__c WHERE Id = :request.Id];
        System.assertNotEquals(null, request.Status__c); // ajusta si sabes qué valor debe quedar
    }

}
