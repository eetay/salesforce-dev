public class SL1ListResourceHandler implements SL1Request.Handler {
    public String generateGUID() {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        return guid;
    }

    public void handle(Map<String,Object> json, SL1Connection connection, SL1Request request) {
        final String batchId = generateGUID();
        List<SL1Job__c> jobList = new List<SL1Job__c>();
        for (Object o: (List<Object>)json.get('result_set')) {
            String uri = (String)(((Map<String, Object>)o).get('URI'));
            SL1Job__c j = new SL1Job__c();
            j.Path__c = uri;
            j.BatchId__c = batchId;
            jobList.add(j);
        }
        insert(jobList);
        Database.executeBatch(new SL1JobBatcher(batchId, connection), 5);
    }
}