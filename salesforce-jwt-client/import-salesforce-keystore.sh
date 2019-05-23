CERTNAME=selfsignedcert_07feb2019_071005
# use password you put when exporting jks from salesforce
keytool -v -importkeystore -alias $CERTNAME -srckeystore 00D4I000001Dj40.jks -destkeystore $CERTNAME.p12 -deststoretype PKCS12
openssl pkcs12 -in $CERTNAME.p12  -nodes -nocerts -out $CERNAME.key

