public class PublicImage {
  public static String example() {
    Blob myProfileImageData = EncodingUtil.base64Decode('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');
    String myDocumentsFolder = 'PublicImages'; // assuming this folder exists
    return addPublicImage(myProfileImageData, myDocumentsFolder);
  }

  public static String addPublicImage(Blob imageData, String folderName) {
    // Create a new document
    Document imageDoc = new Document();
    imageDoc.Name = 'embedded4.png';
    imageDoc.ContentType = 'image/png';
    imageDoc.Body = imageData;
    imageDoc.Type = 'png';
    imageDoc.IsPublic = true;
    imageDoc.FolderId = [SELECT Id from Folder where Name=:folderName LIMIT 1].id;
    insert imageDoc;

    String urlPrefix = System.URL.getSalesforceBaseUrl().getHost().remove('-api' );
    String imageUrl = urlPrefix + '/servlet/servlet.ImageServer?id=' + imageDoc.Id + '&oid=' + UserInfo.getOrganizationId();
    return imageUrl;
  }
}