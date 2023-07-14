#!/bin/bash

# Salesforce OAuth credentials
CLIENT_ID="YOUR-CLIENT-ID"
CLIENT_SECRET="YOUR-CLIENT-SECRET"
REDIRECT_URI="REDIRECT-URI"
USERNAME="YOUR-USERNAME"
PASSWORD="YOUR-PASSWORD"

# Salesforce Metadata API endpoint
METADATA_ENDPOINT="ENDPOINT"

# Salesforce OAuth authentication
auth_endpoint="https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI"
echo "Open the following URL in your browser and authorize the application:"
echo "$auth_endpoint"
read -p "After authorization, copy the URL you were redirected to: " redirect_url

# Extract authorization code from the redirect URL
auth_code=$(echo "$redirect_url" | grep -oE "code=([^&]+)" | cut -d= -f2)

# Exchange authorization code for access token
token_endpoint="https://login.salesforce.com/services/oauth2/token"
response=$(curl --request POST --url "$token_endpoint" --data "grant_type=authorization_code&client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&redirect_uri=$REDIRECT_URI&code=$auth_code" --silent)
access_token=$(echo "$response" | jq -r '.access_token')

# Salesforce Metadata API request
metadata_response=$(curl --request GET --url "$METADATA_ENDPOINT" --header "Authorization: Bearer $access_token" --header "Content-Type: application/json")

# Process the metadata response as needed
echo "$access_token"
