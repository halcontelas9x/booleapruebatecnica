@isTest
public without sharing class SupportRequestServiceTest {

    @TestSetup
    public static void recordsSetup(){
        SupportRequest__c request1 = new SupportRequest__c(
            Priority__c = SupportRequestService.PRIORITY_HIGH,
            ExpectedResolutionDate__c = System.Date.today().addDays(10),
            Status__c = SupportRequestService.STATUS_TO_MANAGE
        );
        insert request1;

        SupportRequest__c request2 = new SupportRequest__c(
            Priority__c = SupportRequestService.PRIORITY_MEDIUM,
            ExpectedResolutionDate__c = System.Date.today().addDays(10),
            Status__c = SupportRequestService.STATUS_TO_MANAGE
        );
        insert request2;

        SupportRequest__c request3 = new SupportRequest__c(
            Priority__c = SupportRequestService.PRIORITY_LOW,
            ExpectedResolutionDate__c = System.Date.today().addDays(100),
            Status__c = 'InProcess'
        );
        insert request3;
        
    }


    @isTest
    static void testSumarDiasHabiles() {
        // Caso de prueba: sumar 5 días hábiles a una fecha inicial
        Date fechaInicial = Date.newInstance(2025, 07, 21); // Lunes
        Integer diasHabiles = 5;
        Date fechaEsperada = Date.newInstance(2025, 07, 28); // Lunes siguiente

        Date resultado = SupportRequestService.sumarDiasHabiles(fechaInicial, diasHabiles);
        
        System.assertEquals(fechaEsperada, resultado, 'La fecha resultante es la esperada');
    }

    @isTest
    static void testSumarDiasHabilesFinDeSemana() {
        // Caso de prueba: sumar días hábiles cruzando un fin de semana
        Date fechaInicial = Date.newInstance(2025, 07, 18); // Viernes
        Integer diasHabiles = 3;
        Date fechaEsperada = Date.newInstance(2025, 07, 23); // Miércoles

        Date resultado = SupportRequestService.sumarDiasHabiles(fechaInicial, diasHabiles);
        
        System.assertEquals(fechaEsperada, resultado, 'La fecha resultante es la esperada al cruzar el fin de semana');
    }

    @isTest
    static void testAniadirSupportRequestHigh() {
        
        SupportRequest__c sRequest = [SELECT Id, Status__c, Priority__c, ExpectedResolutionDate__c
                                            FROM SupportRequest__c WHERE Priority__c = 'High' LIMIT 1];
        
        System.assertEquals(Date.today().addDays(1), sRequest.ExpectedResolutionDate__c, 'La fecha resultante es la esperada');
    }

    @isTest
    static void testAniadirSupportRequestMedium() {
        
        SupportRequest__c sRequest = [SELECT Id, Status__c, Priority__c, ExpectedResolutionDate__c
                                            FROM SupportRequest__c WHERE Priority__c = 'Medium' LIMIT 1];
        
        System.assertEquals(Date.today().addDays(3), sRequest.ExpectedResolutionDate__c, 'La fecha resultante es la esperada');
    }

    @isTest
    static void testAniadirSupportRequestLow() {
        
        SupportRequest__c sRequest = [SELECT Id, Status__c, Priority__c, ExpectedResolutionDate__c
                                            FROM SupportRequest__c WHERE Priority__c = 'Low' LIMIT 1];

        Date esperada = SupportRequestService.sumarDiasHabiles(Date.today(), 5);
        
        System.assertEquals(esperada, sRequest.ExpectedResolutionDate__c, 'La fecha resultante es la esperada');
    }

    @isTest
    static void testActualizarSupportRequest() {
        
        SupportRequest__c sRequest = [SELECT Id, Status__c, Priority__c, ExpectedResolutionDate__c
                                            FROM SupportRequest__c WHERE Priority__c = 'Low' LIMIT 1];

        Map<Id, SupportRequest__c> oldMap = new Map<Id, SupportRequest__c>{
            sRequest.Id => sRequest
        };

        sRequest.Status__c = SupportRequestService.STATUS_TO_MANAGE;
        update sRequest;

        Date resultado = SupportRequestService.sumarDiasHabiles(Date.today(), 5);

        SupportRequest__c sRequestUpdated = [SELECT Id, Status__c, Priority__c, ExpectedResolutionDate__c
                                            FROM SupportRequest__c WHERE Priority__c = 'Low' LIMIT 1];

        System.assertEquals(resultado, sRequestUpdated.ExpectedResolutionDate__c, 'La fecha resultante es la esperada');

    }
}