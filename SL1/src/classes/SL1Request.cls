public class SL1Request {
    public interface Handler {
       void handle(Map<String,Object> json, SL1Connection connection);
    }
    final public Map<String,Object> params;
    final public String path;
    final public Handler handler;
    public SL1Request(String path, Handler handler) {
        this.path = path;
        this.handler = handler;
        this.params = new Map<String,Object>();
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
