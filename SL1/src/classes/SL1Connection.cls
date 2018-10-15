public without sharing class SL1Connection {
  final String username;
  final String password;
  final String origin;
  public SL1Connection(String origin, String username, String password) {
    this.username = username;
    this.password = password;
    this.origin = origin;
  }

  public void jsonCallout(SL1Request request) {
    request.handler.handle((Map<String, Object>)JSON.deserializeUntyped(basicAuthCallout(request).getBody()), this, request);
  }

  public HTTPResponse basicAuthCallout(SL1Request request) {
    HttpRequest req = new HttpRequest();
    final String url = this.origin + request.pathWithQuery();
    System.debug(url);
    req.setEndpoint(url);
    req.setMethod('GET');

    // Specify the required user name and password to access the endpoint
    // As well as the header and header information

    Blob headerValue = Blob.valueOf(this.username + ':' + this.password);
    String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
    req.setHeader('Authorization', authorizationHeader);
    req.setHeader('Accept', 'application/json');
    req.setHeader('Content-Type', 'application/json');

    // Create a new http object to send the request object
    // A response object is generated as a result of the request

    Http http = new Http();
    final HTTPResponse res = http.send(req);
    return res;
  }
}
