#!/bin/bash

DESPESAS_FILE="despesas.txt"

# Configurações do Twilio
ACCOUNT_SID="ACba4f5d095117f8ba685f9ec3b5ee1c97"
AUTH_TOKEN="1a5e66d735aa489c3de4c98c727398e7" #Verificar se o token ainda está valido, ou se é necessarido dar update
TO_PHONE_NUMBER="+351962601852"
FROM_PHONE_NUMBER="+12184838824"


enviar_sms() {
    local mensagem="$1"

    RESPONSE=$(curl -s -X POST "https://api.twilio.com/2010-04-01/Accounts/$ACCOUNT_SID/Messages.json" \
    --data-urlencode "To=$TO_PHONE_NUMBER" \
    --data-urlencode "From=$FROM_PHONE_NUMBER" \
    --data-urlencode "Body=$mensagem" \
    -u "$ACCOUNT_SID:$AUTH_TOKEN")

    MESSAGE_SID=$(echo $RESPONSE | grep -oP '"sid":\s*"\K[^"]+')
    echo "Mensagem enviada com SID: $MESSAGE_SID"
}


exibir_menu() {
    echo "===== Menu ====="
    echo "1) Criar nova despesa"
    echo "2) Listar despesas"
    echo "3) Agendar envio de lembrete"
    echo "4) Sair"
    echo "================"
}

criar_despesa() {
    read -p "Digite o nome da despesa: " nome
    read -p "Digite o valor (exemplo: 35€): " valor
    read -p "Digite a data limite de pagamento (exemplo: 11/01/2025): " data

    
    echo "$nome, $valor, pagar até $data" >> $DESPESAS_FILE
    echo "Despesa adicionada com sucesso!"
}


listar_despesas() {
    if [[ -f $DESPESAS_FILE ]]; then
        echo "===== Despesas ====="
        cat $DESPESAS_FILE
        echo "===================="
    else
        echo "Nenhuma despesa cadastrada."
    fi
}


agendar_lembrete() {
    listar_despesas

    read -p "Selecione o número da despesa para agendar o lembrete: " numero

    
    despesa=$(sed -n "${numero}p" $DESPESAS_FILE)
    if [[ -z $despesa ]]; then
        echo "Número inválido."
        return
    fi

    
    read -p "Digite a data e hora do lembrete (formato: 'minuto hora dia mês'): " agendamento

    
    cron_cmd="echo \"$despesa\" | $PWD/contas.sh enviar_sms"
    echo "$agendamento root bash -c '$cron_cmd'" >> /etc/crontab

    echo "Lembrete agendado com sucesso!"
}


if [[ "$1" == "enviar_sms" ]]; then
    
    while IFS= read -r linha; do
        enviar_sms "$linha"
    done
    exit 0
fi


while true; do
    exibir_menu
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1)
            criar_despesa
            ;;
        2)
            listar_despesas
            ;;
        3)
            agendar_lembrete
            ;;
        4)
            echo "A sair..."
            break
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            ;;
    esac
done
