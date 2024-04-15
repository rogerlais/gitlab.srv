#!/bin/bash

# Test if env var gitlab_service setted
if [ -z "$CNT_GITLAB" ]; then
  echo "Env var from Gitlab container not setted"
  exit 1
fi

# Solicitar a nova senha ao operador
echo "Redefinindo a senha do usuário root do GitLab..."
echo "Informe os dados solicitados abaixo. (root) é o usuário padrão/inicial."
read -s -p "Digite a nova senha: " nova_senha
echo

# Acessar o contêiner Docker do GitLab
docker exec -it "$CNT_GITLAB" /bin/bash << EOF

# Abrir o console Rails
gitlab-rake "gitlab:password:reset" ROOT_PASSWORD="$nova_senha"
exit

EOF

# Verificar se houve erro ao redefinir a senha
if [ $? -ne 0 ]; then
  echo "Erro ao redefinir a senha do usuário root do GitLab."
  exit 1
fi

echo "Senha alterada com sucesso."
