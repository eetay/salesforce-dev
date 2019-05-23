const fs = require('fs')
const SJC = require('../salesforce-jwt-client.js')
var jsforce = require('jsforce')

let tokenBody = {
	// The consumer key for a connected app
	iss: '3MVG9L8AofS.N0y59oQmO00au2GV6R_efUAPGU8z94LsE0zWPX6iWlqWVs1C8L_g0ZvixD9M6WcN8HMMnvfRZ', // Test6


	// aud is test.salesforce.com for sandbox or login.salesforce.com for production environments
	aud: 'https://login.salesforce.com',

	// A user that belongs to one of the pre-authorized profiles for your connected app.
	// Setup -> Create -> Apps
	// Connected apps are at the bottom of the page (at time of writing, API v41.0)
	// Go into your target connected app and click the "manage" button
	// Click "Manage Profiles" near the bottom of the page, and add/remove profiles as needed.
	sub: 'eetay-sso@harman.com',

	// Expiration time of the JWT token
	exp: Math.floor(Date.now()/1000) + 5*3600,
}

const privateKey = fs.readFileSync('./selfsignedcert_07feb2019_071005.key')

SJC.getToken(tokenBody, privateKey).then(json => {
	console.log('TOKEN:', json)
	return Promise.resolve(
		new jsforce.Connection({
			serverUrl : 'https://harmanx-dev-ed.my.salesforce.com',
			sessionId : json.access_token
		})
	)
}).then(conn=>{
	var records = [];
	conn.query("SELECT Id, Name FROM Account", function(err, result) {
	  if (err) throw err
	  console.log(result);
	})
	// execute anonymous Apex Code
	var apexBody = "System.debug('Hello, World');";
	conn.tooling.executeAnonymous(apexBody, function(err, res) {
	  if (err) throw err
	  console.log(res)
	});
}).then(response=>{
	console.log(response)
}).catch(err=>console.log(err))

