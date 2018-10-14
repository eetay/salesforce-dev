public class SL1GetAssetHandler implements SL1Request.Handler  {
    public static Map<String, String> fieldMap = new Map<String, String>{
        'ip' => 'ip',
        'name' => 'name'
    };
    final public SL1Job__c job;
    public SL1GetAssetHandler(SL1Job__c job) {
        this.job = job;
    }
    public void handle(Map<String, Object> json1) {
        this.job.Result__c = (String)json1.get('ip');
    }
}
