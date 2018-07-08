# salesforce-dev
examples and utilities for salesforce developers

## setup deploy/retrieve credentials
create a 'credentials' file inside ./utils folder like so: (replace info with your own)
```bassh
SF_USER="my-user@some-domain.com"
SF_PASS="my-password"
SF_TOKEN="my-security-token"
```

## useful-classes
### EmailTemplateUtils
* render email template to string
* merge merge-fields into a 'template' contained in a string

## lighting-on-vfp
Use a lightning component to display a record on a Visualforce Page
Deploy: utils/deploy
Activate: https://c.gus.visual.force.com/apex/EetayShowRecord
