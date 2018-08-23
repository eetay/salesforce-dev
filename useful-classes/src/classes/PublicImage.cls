public class PublicImage {
  public static String addPublicImage(Blob imageData) {
    // Create a new document
    // ContentVersion existingVersion = [SELECT VersionData from ContentVersion where id = '06846000000LXUgAAO'].get(0);
    // Blob imageData = existingVersion.VersionData;

    Document imageDoc = new Document();
    imageDoc.Name = 'embedded4.png';
    imageDoc.ContentType = 'image/png';
    imageDoc.Body = imageData;
    imageDoc.Type = 'png';
    imageDoc.IsPublic = true;
    imageDoc.FolderId = '00546000000l9P2AAI';
    insert imageDoc;

    String urlPrefix = System.URL.getSalesforceBaseUrl().getHost().remove('-api' );
    String imageUrl = urlPrefix + '/servlet/servlet.ImageServer?id=' + imageDoc.Id + '&oid=' + UserInfo.getOrganizationId();
    return imageUrl;
  }
}
