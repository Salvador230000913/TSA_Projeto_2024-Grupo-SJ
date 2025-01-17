#!/bin/bash

# Configurações do Twilio
ACCOUNT_SID=""
AUTH_TOKEN=""
TO_PHONE_NUMBER=""
FROM_PHONE_NUMBER=""
MESSAGE_BODY="Teste Token"

# Enviar SMS usando curl
RESPONSE=$(curl -s -X POST "https://api.twilio.com/2010-04-01/Accounts/$ACCOUNT_SID/Messages.json" \
--data-urlencode "To=$TO_PHONE_NUMBER" \
--data-urlencode "From=$FROM_PHONE_NUMBER" \
--data-urlencode "Body=$MESSAGE_BODY" \
-u "$ACCOUNT_SID:$AUTH_TOKEN")

# Extrair SID da resposta
MESSAGE_SID=$(echo $RESPONSE | grep -oP '"sid":\s*"\K[^"]+')

echo "Mensagem enviada com SID: $MESSAGE_SID"
