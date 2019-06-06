## example use

```javascript
const tokenBody = {
	iss: '3MVG9sLbBxQYwWqtx806dXaDiK9_LLSyiFr_ivNPTOORELN0wDZnEkH5A5CBDxeE8g97AFaEBNfkeImun9nHV',
	aud: 'https://test.salesforce.com',
	sub: 'eetay.natan@harman.com.idpdev',
	exp: Math.floor(Date.now()/1000) + 5*3600,
}
const serverUrl = 'https://instance.salesforce.com' // replace with your salesforce instance name
const privateKey = fs.readFileSync('./your-private.key') // private key

getToken(tokenBody, privateKey).then(json => {
 	console.log('your access token:', json.access_token)
	/*
          For the REST API, use an HTTP authorization header with the following format: Authorization: Bearer Access_Token.
          For the SOAP API, the access token is placed in the SessionHeader SOAP authentication header.
          For the identity URL, use either an HTTP authorization header (as with the REST API) or an HTTP parameter oauth_token.
	*/
}

```


