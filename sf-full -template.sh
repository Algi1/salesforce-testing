#!/bin/bash

# First script to get the access token
url="https://mydomain.my.salesforce.com/services/oauth2/token"

client_id="YOUR_CLIENT_ID"
grant_type="client_credentials"
client_secret="YOUR_CLIENT_SECRET"

payload="client_id=${client_id}&grant_type=${grant_type}&client_secret=${client_secret}"
headers="Cookie: BrowserId=ti-y-SKIEe6IcZmcDiM_pw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1"

response=$(curl -s -X POST -H "${headers}" -d "${payload}" "${url}")
access_token=$(echo "${response}" | jq -r '.access_token')

# Second script to make the request with the access token
url="https://mydomain.my.salesforce.com/services/data/v58.0/sobjects/Account/{id}"

headers=(
  "Authorization: Bearer ${access_token}"
  "Cookie: BrowserId=ti-y-SKIEe6IcZmcDiM_pw; CookieConsentPolicy=0:1; LSKey-c\$CookieConsentPolicy=0:1"
)

response=$(curl -s -X GET -H "${headers[@]}" "${url}")

echo "$response"
