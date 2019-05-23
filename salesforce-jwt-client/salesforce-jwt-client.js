const JWT = require('jsonwebtoken')
const fetch = require('node-fetch')

const getToken = (tokenBody, privateKey) => {
	let token = JWT.sign( tokenBody, privateKey, { algorithm: 'RS256' })
	console.log(token)
	let grantType = 'urn:ietf:params:oauth:grant-type:jwt-bearer'
	let body = 'grant_type=' + encodeURIComponent(grantType) + '&assertion=' + encodeURIComponent(token)

	return fetch('https://harmanx-dev-ed.my.salesforce.com/services/oauth2/token', {
		method: 'post',
		body,
		headers: { 
			'Content-Type': 'application/x-www-form-urlencoded'
		},
	}).then(
		/*
		If everything goes well, res.getBody() should contain JSON with "access_token"
		For the REST API, use an HTTP authorization header with the following format: Authorization: Bearer Access_Token.
		For the SOAP API, the access token is placed in the SessionHeader SOAP authentication header.
		For the identity URL, use either an HTTP authorization header (as with the REST API) or an HTTP parameter oauth_token.
		*/
		res => res.json()
	).then(json => {
		if (json.error) throw json
		return Promise.resolve(json)
	})
}

module.exports = {
	getToken
}
