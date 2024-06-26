#!/bin/sh

#* Ref = https://docs.gitlab.com/ee/security/reset_user_password.html#how-to-reset-user-password
#* General = https://docs.gitlab.com/ee/security/reset_user_password.html

# Test if env var gitlab_service setted
if [ -z "$CNT_GITLAB" ]; then
  echo "Env var from Gitlab container not setted"
  exit 1
fi

# Solicitar a nova senha ao operador
echo "Redefinindo a senha do usuário root do GitLab..."
echo "Informe os dados solicitados abaixo. (root) é o usuário padrão/inicial(carga lenta a depender do servidor)."
echo

# Acessar o contêiner Docker do GitLab
docker exec -t "${CNT_GITLAB}" gitlab-rake "gitlab:password:reset"

# Verificar se houve erro ao redefinir a senha
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
  echo "Erro ao redefinir a senha do usuário root do GitLab."
  exit 1
fi

echo "Senha alterada com sucesso."
