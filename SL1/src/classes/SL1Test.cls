public without sharing class SL1Test {
  public static String generateGUID() {
    Blob b = Crypto.GenerateAESKey(128);
    String h = EncodingUtil.ConvertTohex(b);
    String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
    return guid;
  }

  public static void refreshDevices(String username, String password, String since) {
    SL1Connection sl1 = new SL1Connection('https://sl1.samanage.com', username, password);
    String batchId = generateGUID();
    SL1Request r = new SL1Request(new SL1Job__c(Path__c = '/api/device', BatchId__c = batchId), new SL1ListResourceHandler());
    r.params.put('limit', 1000);
    if (since != null) r.params.put('filter.last_poll.min', since);
    sl1.jsonCallout(r);
    Database.executeBatch(new SL1JobBatcher(batchId, sl1), 5);
  }
}
