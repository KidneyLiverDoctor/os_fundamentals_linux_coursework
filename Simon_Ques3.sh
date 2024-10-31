#!/bin/bash

generate_password() {
    local length=$1

    local upper_case="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local lower_case="abcdefghijklmnopqrstuvwxyz"
    local numbers="0123456789"
    local special_chars="!@#$%^&*_-+=[]{}|:<>?/"

    password="${upper_case:RANDOM%${#upper_case}:1}"
    password+="${lower_case:RANDOM%${#lower_case}:1}"
    password+="${numbers:RANDOM%${#numbers}:1}"
    password+="${special_chars:RANDOM%${#special_chars}:1}"

    all_chars="${upper_case}${lower_case}${numbers}${special_chars}"
    for ((i=${#password}; i<length; i++)); do
        password+="${all_chars:RANDOM%${#all_chars}:1}"
    done

    password=$(echo "$password" | fold -w1 | shuf | tr -d '\n')
    echo "$password"
}

read -p "Enter the desired password length (12-32): " length

if ! [[ "$length" =~ ^[0-9]+$ ]] || ((length < 12 || length > 32)); then
    echo "Invalid length. Please enter a number between 12 and 32."
    exit 1
fi

password=$(generate_password "$length")
echo "Generated Password: $password"
echo "Password Length: ${#password}"
