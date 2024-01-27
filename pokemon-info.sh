#!/bin/bash

#INSTALACION DEPENDENCIAS LINUX
# sudo apt-get update
# sudo apt-get install jq

#INSTALACION DEPENDENCIAS MAC
#brew install jq

# Verifica que se haya pasado un parametro
if [ $# -eq 0 ]; then
    echo "El nombre del pokemon es un parametro obligatorio."
    exit 1
fi

name=$1
url="https://pokeapi.co/api/v2/pokemon/$name/"
response=$(curl -s $url)

# `#?` es el código de salida de la última ejecución, en este caso, la respuesta del GET que hicimos con curl
if [ $? -ne 0 ]; then
    echo "Error al realizar la petición a la API, intenta de nuevo."
    exit 1
fi

# jq es una dependencia para parsear JSON
id=$(echo $response | jq -r '.id')
name=$(echo $response | jq -r '.name' | awk '{print toupper(substr($0, 1, 1)) tolower(substr($0, 2))}')
weight=$(echo $response | jq -r '.weight')
height=$(echo $response | jq -r '.height')

echo "$name (No. $id)"
echo "Id = $id"
echo "Weight = $weight"
echo "Height = $height"
