# Redmine Omniauth AzureAD

Este é um fork de https://github.com/kimjyb/redmine_omniauth_azure.

O repositorio a seguir tambem foi utilizado como referência [ibboost/redmine_omniauth_azure](https://github.com/ibboost/redmine_omniauth_azure).

## Instalação

* Certifique-se de executar esses comandos como o `usuário` que roda o `redmine` para que as permissões estejam corretas.
* `cd /caminho/para/redmine/plugins`
* `git clone git@github.com:ugleiton/redmine_omniauth_azure.git`
* `cd /caminho/para/redmine`
* `bundle install`
* `bundle exec rake redmine:plugins:migrate RAILS_ENV=production`
* Reinicie o Redmine

## Registro

É necessário um registro de Aplicativo no Azure para habilitar este plugin.

* Acesse o Portal do Azure > Azure Active Directory > Registros de Aplicativos > Novo Registro
```
Nome: redmine-app
Tipos de conta compatíveis: Locatário único
URI de redirecionamento: https://${seu_url_redmine}/oauth2callback_azure
```
* `Registrar`
* No aplicativo recém-criado `redmine-app`, vá para `Certificados e segredos`
* Na guia `Segredos do cliente`, clique em `Novo segredo do cliente`
```
Descrição: redmine-app-secret
Expiração: 730 dias (24 meses)
```

* Anote o `Valor` do segredo gerado, pois essa será a única vez que ele será exibido. Este é o `Client Secret`.
* Vá para `Permissões de API`
* `Adicionar uma permissão`
```
Microsoft Graph - Permissões de Aplicativo - Group.Read.All
```
* Clique em `Conceder consentimento de administrador para Diretório Padrão` e confirme
* Vá para `Autenticação` e confirme que o campo `Web - URIs de Redirecionamento` tem uma entrada:
```
https://${seu_url_redmine}/oauth2callback_azure
```

* Obtenha as três informações abaixo para autenticar o plugin no Redmine:
  * ID do Locatário: `ID do Diretório (locatário)` na aba `Visão Geral` do aplicativo
  * ID do Cliente: `ID do Aplicativo (cliente)` na aba `Visão Geral` do aplicativo
  * Segredo do Cliente: `Client Secret` gerado anteriormente

## Configuração

Faça login como Administrador do Redmine

* Selecione a aba `Administração` no menu superior.
* Aba `Plugins`
* `Configurar` no plugin `Redmine Omniauth Azure`
* Insira os detalhes obtidos anteriormente:
  * ID do Cliente
  * Segredo do Cliente
  * ID do Locatário
* Opcionalmente, adicione domínios permitidos, um por linha.
* Marque `Ativar autenticação OAuth` e clique em `Aplicar` para ativar logins com AzureAD.
* Opcionalmente, permita o `Autologin` em `Administração > Configurações > Autenticação > Autologin`.

## Processo de Login

Quando um usuário acessa a página de login e clica em `Nicrosoft Login`, o plugin o redireciona para a página de login do Azure, onde ele deve se autenticar. Após o login bem-sucedido, o usuário será redirecionado de volta para o Redmine.

Caso o registro automático não esteja ativado, um administrador deverá criar uma conta para novos usuários.
