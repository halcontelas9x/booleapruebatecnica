@isTest
private class SupportRequestBatchTest {
    @isTest
    static void testBatchExecution() {
        // Datos de prueba
        List<SupportRequest__c> datos = new List<SupportRequest__c>();
        datos.add(new SupportRequest__c(
            Priority__c = SupportRequestService.PRIORITY_HIGH,
            ExpectedResolutionDate__c = System.Date.today().addDays(10),
            Status__c = SupportRequestService.STATUS_PENDING_INTERNAL
        ));
        insert datos;

        Test.startTest();
        SupportRequestBatch batch = new SupportRequestBatch();
        Database.executeBatch(batch, 1); // puedes ajustar el tamaño
        Test.stopTest();

        // Aquí podrías verificar efectos si el batch modifica datos
        System.assertEquals(1, [SELECT COUNT() FROM SupportRequest__c]);
    }
}
