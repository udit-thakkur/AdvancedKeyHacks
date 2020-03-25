#!/bin/bash
echo ""
echo "                        Made with <3 by team                       "
echo " _   _      _       ____   _  __   ____   _   _   ____       _     "
echo "| | | |    / \     / ___| | |/ /  / ___| | | | | |  _ \     / \    "
echo "| |_| |   / _ \   | |     | ' /  | |     | | | | | |_) |   / _ \   "
echo "|  _  |  / ___ \  | |___  | . \  | |___  | |_| | |  _ <   / ___ \  "
echo "|_| |_| /_/   \_\  \____| |_|\_\  \____|  \___/  |_| \_\ /_/   \_\ "
echo ""
echo "Creator: udit_thakkur   (https://twitter.com/udit_thakkur)  "
echo "         Harshit Sengar (https://twitter.com/sengarharshit1)"

echo ""
echo	" 1.  Slack API Token                   2.  Saucelabs Username and Access Key       3.  Firebase Custom Token and API key				"	
echo	" 4.  Github Username & Token/key       5.  Github Client ID and Secret             6.  Google Cloud Messaging Key						"
echo	" 7.  Twilio Account_SID & Secret Key   8.  Twitter API key & Secret                9.  Twitter Bearer/Auth Token						"
echo	" 10. Hubspot API key                   11. Deviant Art Client ID & Secret key      12. Validation of Deviant Art Token					"
echo	" 13. Pendo Integration Key             14. SendGrid API Token                      15. Square Auth Token								"
echo	" 16. Square ClientID, Secret & Token   17. Dropbox API Bearer/Auth Token           18. MailGun Private Key								"
echo	" 19. Jumpcloud API key                 20. Heroku API key/Bearer Token             21. Microsoft Azure Client ID, secret & Tenant ID	"
echo	" 22. Mapbox API key                    23. Salesforce API Key/Bearer Token         24. Zapier Webhook URL & Username					"
echo	" 25. FreshDesk Domain & API key        26. PagerDuty API Token                     27. Browser Stack Access Key and Username			"
echo	" 28. Google MAPS API key               29. Brach.io Key & secret                   30. bit.ly Access Token								"
echo	" 31. Buildkite Access Token            32. Asana Access Token/Bearer Token         33. Zendesk helpdesl domain & Access Token			"
echo	" 34. Mailchimp Acesskey and Username   35. WPEngine API key & Account Name         36. DataDog API Key & Application Key				"
echo	" 37. Travis CI API Token               38. WakaTime API Key                        39. Spotify Access Token/Bearer Token				"
echo	" 40. Instagram Access Token            41. Gitlab Personal/Private Token           42. Stripe Live Token								"
echo	" 43. CicrcleCI Access Token            44. Razorpay API Key ID & Secret Key        45. Paypal ClientID & Secret						"
echo ""
echo -n "Enter the respective number from list that you want to exploit: "
read number
echo ""

case $number in
	1)
		echo -n "Enter Slack API Token: "
		read slack
		curl -sX POST "https://slack.com/api/auth.test?token=xoxp-$slack&pretty=1"
		;;

	2)
		echo -n "Enter SauceLabs Username: "
		read Username
		echo -n "Enter the SauceLabs Access Key: "
		read key
		curl -u $Username:$key https://saucelabs.com/rest/v1/users/$Username
		;;	

	3)
		echo -n "Enter Firebase Custom Token: "
		read token
		echo -n "Enter the Firebase API key: "
		read key
		Id_token=$(curl -s -XPOST -H 'content-type: application/json' -d '{"token":":$token","returnSecureToken":True}' 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=:$key' | grep idToken | grep id | cut -f 1 | tr -d "," )
		curl -s -XPOST -H 'content-type: application/json' -d '{$Id_token}' 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken?key=:$key'
		;;

	4)
		echo -n "Enter Github Username: "
		read user
		echo -n "Enter Github Token/Key: "
		read key
		curl -s -u "$user:$key" https://api.github.com/user
		curl -s -H "Authorization: token $key" "https://api.github.com/users/$user/orgs"
		curl -s "https://api.github.com/rate_limit" -i -u "$user:$key" | grep "X-OAuth-Scopes:"
		;;

	5)
		echo -n "Enter Github Client ID: "
		read id
		echo -n "Enter Github Client Secret: "
		read secret
		curl 'https://api.github.com/users/whatever?client_id=$id&client_secret=$secret'
		;;

	6)
		echo -n "Enter Google Cloud Messaging key: "
		read key
		curl -s -X POST --header "Authorization: key=$key" --header "Content-Type:application/json" 'https://gcm-http.googleapis.com/gcm/send' -d '{"registration_ids":["1"]}'
		echo ""
		;;

	7)
		echo -n "Enter Twilio Account_SID: "
		read sid
		echo -n "Enter Twilio Auth Token: "
		read token
		curl -s -X GET 'https://api.twilio.com/2010-04-01/Accounts.json' -u $sid:$token | jq .
		;;

	8)
		echo -n "Enter Twitter API Key: "
		read key
		echo -n "Enter Twitter API Secret Key: "
		read secret
		bearer=$(curl -s -u '$key:$secret' --data 'grant_type=client_credentials' 'https://api.twitter.com/oauth2/token' | cut -d '"' -f 8 )
		curl -s --request GET --url https://api.twitter.com/1.1/account_activity/all/subscriptions/count.json --header 'authorization: Bearer $bearer' | jq .
		;;

	9)
		echo -n "Enter the Twitter bearer token: "
		read token
		curl -s --request GET --url https://api.twitter.com/1.1/account_activity/all/subscriptions/count.json --header 'authorization: Bearer $bearer' | jq .
		;;

	10)
		echo -n "Enter Hubspot API Key: "
		read key
		curl -s https://api.hubapi.com/owners/v2/owners?hapikey=$key | jq .
		curl -s https://api.hubapi.com/contacts/v1/lists/all/contacts/all?hapikey=$key | jq .
		;;

	11)
		echo -n "Enter Deviant Art Client ID (Numeric): "
		read id
		echo -n "Enter Deviant Art Secret Key: "
		read key
		curl -s https://www.deviantart.com/oauth2/token -d grant_type=client_credentials -d client_id=$id -d client_secret=$key | jq .
		;;
	
	12)
		echo -n "Enter Deviant Art Access Token to check whether it is valid or not: "
		read token
		curl -s https://www.deviantart.com/api/v1/oauth2/placebo -d access_token=$token | jq .
		;;

	13)
		echo -n "Enter Pendo Integration Key: "
		read key
		curl -X GET https://app.pendo.io/api/v1/feature -H 'content-type: application/json' -H 'x-pendo-integration-key:$key'
		curl -X GET https://app.pendo.io/api/v1/metadata/schema/account -H 'content-type: application/json' -H 'x-pendo-integration-key:$key'
		;;

	14)
		echo -n "Enter SendGrid API Token: "
		read token
		curl -s -X "GET" "https://api.sendgrid.com/v3/scopes" -H "Authorization: Bearer $token" -H "Content-Type: application/json" | jq .
		;;		

	15)
		echo -n "Enter Square Auth Token: "
		read auth
		curl -s https://connect.squareup.com/v2/locations -H "Authorization: Bearer $auth" | jq .
		;;

	16)
		echo -n "Enter Square App ID/Client ID {starts with sq0}: "
		read id
		echo -n "Enter Square Client Secret {starts with EAAA}: "
		read secret
		echo -n "Enter Square Access Token (Some Random String if none e.g. sefjkjrefvgidsrbjnklcedh): "
		read token
		curl "https://squareup.com/oauth2/revoke" -d '{"access_token":"$token","client_id":"$id"}'  -H "Content-Type: application/json" -H "Authorization: Client $secret"
		;;

	17)
		echo -n "Enter DropBox API Bearer Token: "
		read token
		curl -X POST https://api.dropboxapi.com/2/users/get_current_account --header "Authorization: Bearer $token"
		echo ""
		;;

	18)
		echo -n "Enter MailGun Private Key: "
		read private
		curl -s --user 'api:$private' "https://api.mailgun.net/v3/domains" | jq .
		;;

	19)	
		echo -n "Enter JumpCloud Api Key: "
		read key
		curl -H "x-api-key: $key" "https://console.jumpcloud.com/api/systems"
		echo ""
		;;

	21)	
		echo -n "Enter Microsoft Azure Client ID: "
		read id
		echo -n "Enter Microsoft Azure Client Secret: "
		read secret
		echo -n "Enter Microsoft Azure Tenant ID: "
		read tenant
		curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" -d 'client_id=$id&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&client_secret=$secret&grant_type=client_credentials' 'https://login.microsoftonline.com/$tenant/oauth2/v2.0/token' | jq .
		;;

	20)
		echo -n "Enter Heroku API key/ Bearer Token: "
		read token
		curl -X POST https://api.heroku.com/apps -H "Accept: application/vnd.heroku+json; version=3" -H "Authorization: Bearer $token"
		;;

	22)
		echo -n "Enter Mapbox API key: "
		read key
		curl -s "https://api.mapbox.com/geocoding/v5/mapbox.places/Los%20Angeles.json?access_token=$key" | jq .
		;;

	23)
		echo -n "Enter Salesforce API key / Bearer Token: "
		read key
		echo -n "Enter Salesforce URL (e.g. https://test.salesforce.com): "
		read url
		curl $url/services/data/v20.0/ -H 'Authorization: Bearer $key'
		;;

	24)
		echo -n "Enter Zapier Webhook URL: "
		read url
		echo -n "Enter UserName/Name: "
		read name
		curl -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"name":"$name"}' "$url"
		;;

	25)
		echo -n "Enter FreshDesk Domain name (Helpdesk) e.g. https://test.freshdesk.com: "
		read domain
		echo -n "Enter FreshDesk API key: "
		read key
		curl -v -u $key:X -H "Content-Type: application/json" '$domain/api/v2/tickets' 
		;;

	26)	
		echo -n "Enter Pagerduty API token: "
		read token
		curl -H "Accept: application/vnd.pagerduty+json;version=2"  -H "Authorization: Token token=$token" -X GET  "https://api.pagerduty.com/schedules"
		echo ""
		;;

	27)
		echo -n "Enter Browser Stack Access key: "
		read key
		echo -n "Enter Browser Stack Username: "
		read username
		curl -u "$username:$key" https://api.browserstack.com/automate/plan.json
		;;

	28)
		echo -n "Enter Google Map API key: "
		read key
		curl -H "referer: http://example.com" "https://maps.googleapis.com/maps/api/directions/json?origin=Stockholm&destination=Kalmar&key=$key"
		;;

	29)
		echo -n "Enter Branch.io key: "
		read key
		echo -n "Enter Branch.io Secret: "
		read secret
		curl -s https://api2.branch.io/v1/app/$key?branch_secret=$secret | jq .
		;;

	30)
		echo -n "Enter bit.ly Access Token: "
		read token
		curl -s https://api-ssl.bitly.com/v3/shorten?access_token=$token | jq .
		;;

	31)
		echo -n "Enter Buildkite Access Token: "
		read token
		curl -H "Authorization: Bearer $token" https://api.buildkite.com/v2/user
		;;

	32)
		echo -n "Enter Asana Access Token/Bearer Token: "
		read token
		curl -s -H "Authorization: Bearer $token" https://app.asana.com/api/1.0/users/me | jq .
		;;

	33)
		echo -n "Enter Zendesk domain name (Helpdesk Of company e.g. https://companyname.zendesk.com): "
		read url
		echo -n "Enter Zendesk Access Token/ Bearer Token: "
		read token
		curl $url/api/v2/tickets.json -H "Authorization: Bearer $token"
		;;

	34)
		echo -n "Enter the MailChimp Access Key: "
		read key
		dc=$(echo $key | rev | cut -c1-3 | rev)
		echo -n "Enter MailChimp username (If found none, then give any random string): "
		read username
		curl --request GET --url 'https://'$dc'.api.mailchimp.com/3.0/' --user '$username:$key' --include
		;;

	35)
		echo -n "Enter WPEngine API key: "
		read key
		echo -n "Enter WPEngine Account Name: "
		read name
		curl -s "https://api.wpengine.com/1.2/?method=site&account_name=$name&wpe_apikey=$key" | jq .
		;;

	36)
		echo -n "Enter DataDog API Key: "
		read key
		echo -n "Enter DataDog Application Key: "
		read app
		curl -s "https://api.datadoghq.com/api/v1/dashboard?api_key=$key&application_key=$app" | jq .
		;;

	37)
		echo -n "Enter Travis CI API Token: "
		read token
		curl -H "Travis-API-Version: 3" -H "Authorization: token $token" https://api.travis-ci.com/user
		echo ""
		;;

	38)
		echo -n "Enter WakaTime API key: "
		read key
		curl -s "https://wakatime.com/api/v1/users/current/projects/?api_key=$key" | jq .
		;;

	39)
		echo -n "Enter Spotify Access Token/ Bearer Token: "
		read token
		curl -H "Authorization: Bearer $token" https://api.spotify.com/v1/me
		echo ""
		;;

	40)
		echo -n "Enter Instagram Access Token: "
		read token
		curl -s https://api.instagram.com/v1/users/self/?access_token=$token | jq .
		;;

	41)
		echo -n "Enter Gitlab Personal/Private Access Token: "
		read token
		echo -n "Enter Gitlab Company URL (e.g. https://companyname.gitlab.com): "
		read url
		curl "$url/api/v4/projects?private_token=$token"
		;;

	42)
		echo -n "Enter Stripe Live Token: "
		read token
		curl -s https://api.stripe.com/v1/charges -u $token: | jq .
		;;

	43)
		echo -n "Enter CircleCI Access Token: "
		read token
		curl -s https://circleci.com/api/v1.1/me?circle-token=$token | jq .
		;;

	44)
		echo -n "Razorpay API key ID: "
		read key
		echo -n "Razorpay Secret key: "
		read secret
		curl -s -u $key:$secret https://api.razorpay.com/v1/payments | jq .
		;;

	45)
		echo -n "Enter Paypal Client Id: "
		read client
		echo -n "Enter Paypal Secret: "
		read secret
		curl -s -v https://api.sandbox.paypal.com/v1/oauth2/token -H "Accept: application/json" -H "Accept-Language: en_US" -u "$client:$secret" -d "grant_type=client_credentials"
		bearer=$(curl -s -v https://api.sandbox.paypal.com/v1/oauth2/token -H "Accept: application/json" -H "Accept-Language: en_US" -u "$client:$secret" -d "grant_type=client_credentials")
		curl -s -v -X GET "https://api.sandbox.paypal.com/v1/identity/oauth2/userinfo?schema=paypalv1.1" -H "Content-Type: application/json" -H "Authorization: Bearer $bearer"
		echo ""
		;;

	*)
		echo "Please give valid choice!!!"
		;;

esac