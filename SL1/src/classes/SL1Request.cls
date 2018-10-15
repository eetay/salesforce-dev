public class SL1Request {
    public interface Handler {
       void handle(Map<String,Object> json, SL1Connection connection, SL1Request request);
    }
    final public Map<String,Object> params;
    final public String path;
    final public Handler handler;
    final public SL1Job__c job;

    public SL1Request(SL1Job__c job, Handler handler) {
        this.path = job.Path__c;
        this.handler = handler;
        this.params = new Map<String,Object>();
        this.job = job;
    }
    public String pathWithQuery() {
        String query = '';
        String append = '';
        for (String key : params.keySet()) {
            query += append + EncodingUtil.urlEncode(key, 'UTF-8') + '=' + EncodingUtil.urlEncode(String.valueOf(this.params.get(key)), 'UTF-8');
            append = '&';
        }
        return this.path + '?' + query;
    }
}
