# salesforce-dev
examples and utilities for salesforce developers

## setup deploy/retrieve credentials
create a 'credentials' file inside ./utils folder like so: (replace info with your own)
```bash
# utils/credentials
SF_USER="my-user@some-domain.com"
SF_PASS="my-password"
SF_TOKEN="my-security-token"
```

### Deployment of projects
```bash
$ ../utils/deploy.sh
```

## useful-classes

Classes:

### PublicImage
* create in the ORG a image that can be accessed without need for salesforce user/password and return its public URL as String that can be used in a HTML document (for example)

### EmailTemplateUtils
* render email template to string
* merge merge-fields into a 'template' contained in a string

## lighting-on-vfp
Use a lightning component to display a record on a Visualforce Page
Deploy: utils/deploy
Activate: https://c.gus.visual.force.com/apex/EetayShowRecord
