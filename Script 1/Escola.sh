#!/bin/bash

ALUNOS_FILE="alunos.txt"
DISCIPLINAS_FILE="disciplinas.txt"
NOTAS_FILE="notas.txt"

>> "$ALUNOS_FILE"
>> "$DISCIPLINAS_FILE"
>> "$NOTAS_FILE"

clear_screen() {
    clear
}

adicionar_alunos() {
    clear_screen
    echo "Digite o nome dos alunos (um por linha). Pressione Enter sem digitar nada para sair."
    while true; do
        read -p "Nome do aluno: " nome
        if [[ -z "$nome" ]]; then
            break
        fi
        echo "$nome" >> "$ALUNOS_FILE"
    done
    clear_screen
    echo "Alunos adicionados com sucesso!"
}

adicionar_disciplinas() {
    clear_screen
    echo "Digite o nome das disciplinas (uma por linha). Pressione Enter sem digitar nada para sair."
    while true; do
        read -p "Nome da disciplina: " disciplina
        if [[ -z "$disciplina" ]]; then
            break
        fi
        echo "$disciplina" >> "$DISCIPLINAS_FILE"
    done
    clear_screen
    echo "Disciplinas adicionadas com sucesso!"
}

listar_alunos() {
    clear_screen
    if [[ ! -s "$ALUNOS_FILE" ]]; then
        echo "Nenhum aluno cadastrado."
    else
        echo "Lista de alunos:"
        awk '{print NR " - " $0}' "$ALUNOS_FILE"
    fi
}

listar_disciplinas() {
    clear_screen
    if [[ ! -s "$DISCIPLINAS_FILE" ]]; then
        echo "Nenhuma disciplina cadastrada."
    else
        echo "Lista de disciplinas:"
        awk '{print NR " - " $0}' "$DISCIPLINAS_FILE"
    fi
}

adicionar_notas() {
    clear_screen
    listar_alunos
    read -p "Selecione o número do aluno: " aluno_index
    aluno=$(awk "NR==$aluno_index" "$ALUNOS_FILE")

    listar_disciplinas
    read -p "Selecione o número da disciplina: " disciplina_index
    disciplina=$(awk "NR==$disciplina_index" "$DISCIPLINAS_FILE")

    read -p "Digite a nota (0-20): " nota
    while [[ $nota -lt 0 || $nota -gt 20 ]]; do
        echo "Nota inválida. Insira um valor entre 0 e 20."
        read -p "Digite a nota (0-20): " nota
    done

    echo "$aluno|$disciplina|$nota" >> "$NOTAS_FILE"
    clear_screen
    echo "Nota adicionada com sucesso!"
}

listar_notas() {
    clear_screen
    if [[ ! -s "$NOTAS_FILE" ]]; then
        echo "Nenhuma nota cadastrada."
    else
        echo "Lista de notas:"
        awk -F'|' '{printf "Aluno: %s\tDisciplina: %s\tNota: %d\n", $1, $2, $3}' "$NOTAS_FILE"
    fi
}

while true; do
    clear_screen
    echo "Sistema de Gestão Acadêmica"
    echo "1 - Adicionar alunos"
    echo "2 - Adicionar disciplinas"
    echo "3 - Adicionar notas"
    echo "4 - Listar alunos"
    echo "5 - Listar disciplinas"
    echo "6 - Listar notas"
    echo "0 - Sair"
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1) adicionar_alunos ;;
        2) adicionar_disciplinas ;;
        3) adicionar_notas ;;
        4) listar_alunos ;;
        5) listar_disciplinas ;;
        6) listar_notas ;;
        0) break ;;
        *) echo "Opção inválida. Tente novamente." ;;
    esac
    read -p "Pressione Enter para continuar..."
done

clear_screen
echo "Programa encerrado."