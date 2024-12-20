#!/bin/bash

# Configurações do Twilio
ACCOUNT_SID="ACba4f5d095117f8ba685f9ec3b5ee1c97"
AUTH_TOKEN="d93ae52e52c336071b76166677aa56e5"
TO_PHONE_NUMBER="+351962601852"
FROM_PHONE_NUMBER="+12184838824"
MESSAGE_BODY="Olha a Conta da"

# Enviar SMS usando curl
RESPONSE=$(curl -s -X POST "https://api.twilio.com/2010-04-01/Accounts/$ACCOUNT_SID/Messages.json" \
--data-urlencode "To=$TO_PHONE_NUMBER" \
--data-urlencode "From=$FROM_PHONE_NUMBER" \
--data-urlencode "Body=$MESSAGE_BODY" \
-u "$ACCOUNT_SID:$AUTH_TOKEN")

# Extrair SID da resposta
MESSAGE_SID=$(echo $RESPONSE | grep -oP '"sid":\s*"\K[^"]+')

echo "Mensagem enviada com SID: $MESSAGE_SID"