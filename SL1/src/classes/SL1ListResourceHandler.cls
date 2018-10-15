public class SL1ListResourceHandler implements SL1Request.Handler {
    public void handle(Map<String,Object> json, SL1Connection connection, SL1Request request) {
        final String batchId = request.job.BatchId__c;
        List<SL1Job__c> jobList = new List<SL1Job__c>();
        for (Object o: (List<Object>)json.get('result_set')) {
            String uri = (String)(((Map<String, Object>)o).get('URI'));
            SL1Job__c j = new SL1Job__c();
            j.Path__c = uri;
            j.State__c = 'Pending';
            j.BatchId__c = batchId;
            jobList.add(j);
        }
        insert(jobList);
    }
}
