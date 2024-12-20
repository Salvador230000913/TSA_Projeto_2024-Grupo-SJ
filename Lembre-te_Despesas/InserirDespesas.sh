#!/bin/bash

# Função para exibir o menu
exibir_menu() {
    echo "===== Menu ====="
    echo "1) Despesas"
    echo "2) Valor das Despesas"
    echo "3) Data Limite de Pagamento"
    echo "4) Settings"
    echo "5) Sair"
    echo "================"
}

# Loop principal do menu
while true; do
    exibir_menu
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1)
            echo "Você selecionou: Despesas"
            # Coloque aqui o código relacionado às despesas
            ;;
        2)
            echo "Você selecionou: Valor das Despesas"
            # Coloque aqui o código relacionado ao valor das despesas
            ;;
        3)
            echo "Você selecionou: Data Limite de Pagamento"
            # Coloque aqui o código relacionado à data limite
            ;;
        4)
            echo "Você selecionou: Settings"
            # Coloque aqui o código relacionado às configurações
            ;;
        5)
            echo "A sair..."
            break
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            ;;
    esac
done