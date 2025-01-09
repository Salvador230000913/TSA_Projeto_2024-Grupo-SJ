#!/bin/bash

ACCOUNT_SID="ACba4f5d095117f8ba685f9ec3b5ee1c97"
AUTH_TOKEN="8b9c9bd1231c8ac032a1570929c84df8"
FROM_NUMBER="+12184838824"
TO_NUMBER="+351962601852"
MESSAGE="Tens de Pagar a conta da Agua do Mês de Janeiro, valor 26,90€"

RESPONSE=$(curl -s -X POST "https://api.twilio.com/2010-04-01/Accounts/$ACCOUNT_SID/Messages.json" \
    --user "$ACCOUNT_SID:$AUTH_TOKEN" \
    --data-urlencode "From=$FROM_NUMBER" \
    --data-urlencode "To=$TO_NUMBER" \
    --data-urlencode "Body=$MESSAGE")

MESSAGE_SID=$(echo "$RESPONSE" | grep -o '"sid": "[^"]*' | awk -F': "' '{print $2}')
echo "Mensagem enviada com SID: $MESSAGE_SID"
