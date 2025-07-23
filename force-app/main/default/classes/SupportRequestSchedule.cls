public class SupportRequestSchedule implements Schedulable {
    public void execute(SchedulableContext sc) {
        SupportRequestBatch requestBatch = new SupportRequestBatch();
        Database.executeBatch(requestBatch);
    }
}
