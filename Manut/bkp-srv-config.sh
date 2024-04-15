#!/bin/sh

# Verifica se o número de argumentos é válido
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <pasta_a_compactar> <caminho_do_backup>"   exit 1
fi

# Verifica se a pasta de origem existe
if [ ! -d "$1" ]; then
    echo "Erro: Pasta '$1' não existe."
    exit 1
fi

# Verifica se o diretório de destino existe; se não, cria-o
if [ ! -d "$2" ]; then
    echo "Criando o diretório de destino '$2'..."
    mkdir -p "$2"
fi

# Compacta a pasta para o caminho especificado
echo "Compactando pasta '$1' para '$2'..."
tar -czf "$2/backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz" "$1"

echo "Backup concluído em '$2'."