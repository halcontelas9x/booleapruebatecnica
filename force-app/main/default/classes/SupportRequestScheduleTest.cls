@isTest
private class SupportRequestScheduleTest {
    @isTest
    static void testSchedulerRunsBatch() {
        Test.startTest();
        String cron = '0 0 0 * * ?'; // mismo cron que en producción
        String jobName = 'TestScheduledBatch';

        System.schedule(jobName, cron, new SupportRequestSchedule());
        Test.stopTest();

        // Verificamos que el job fue programado
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered
                          FROM CronTrigger
                          WHERE CronJobDetail.Name = :jobName];

        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered); // aún no se ha ejecutado
    }
}
