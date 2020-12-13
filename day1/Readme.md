# Anotações da aula - day 01

## 1 - Introdução
O Terraform guarda estado, assim ao executar o binário para ler um arquivo .tf, o binário consulta o estado para saber o que já existe ou não, criando ou modificando o que realmente é preciso.

## 2 - Infraestrurura Mutável e Imutável

### 2.1 - Mutável
É a infraestrutura mais comum na maioria das empresas, em que temos os servidores com seus nomes, etc.

Em um momento 0, por exemplo, um servidor é provisionadao com o nome de thor contendo o apache + mod para php

Em um momento 1, o mesmo servidor thor, por uma necessidade, tem o apache retirado e começa a utilizar o Nginx em seu lugar.

Concluindo, a infraestrutura mutável é a mesma infra sofrendo modificações ao passar do tempo.

####Qual é o problema nisso?
Com o passar do tempo, muitas modificações são feitas, sejam manuais ou automatizadas com ansible, puppet, etc, e ai a tendência é perder um pouco do controle, virando o que normalmente se denomina de snowflakes (servidor floco de neve), que é a ideia do servidor perder o controle, tantas modificações com o passar do tempo, que fica difícil garantir que o que está realmente sendo executado no servidor é o que deveria.

### 2.2 - Imutável
É a infraestrutura em que os servidores são destruidos e criados conforme a necessidade, com as mudanças necessárias. Não se tem apego aos servidores.

Nesse cenário, um novo servidor é criado com a nova configuração, mantendo-se o antigo para rollback no curto espaço de tempo.

Em resumo, no exemplo dado, não se retiraria o apache e instalaria o Nginx. Se criaria um novo servidor com Nginx.

## 3 - Entendendo o HCL

Existem alguns elementos dentro de um arquivo HCL utilizado pelo Terraform

### 3.1 - Blocos (blocks)
É um conjunto de código dentro de um arquivo .tf, iniciando com uma chave e terminando com outra chave. Existem vários tipos de blocos, como por exemplo, resource.

Os blocos tem tipo e nome.

### 3.2 - Argumentos
É tudo que se configura dentro de um bloco, por exemplo, ami = "abc123". É uma chave-valor. Esses argumentos (chave) já existem e são de acordo com os recursos que estão sendo codificados.

### 3.3 - Identificadores (identifiers)
É nome do tipo do bloco ou do argumento. São nomes. Há regras de nomeclaturas, como por exemplo, não pode iniciar com um número.

### 3.4 - Comentários (comments)
Pode-se utilizar #, // ou /* */, assim como em algumas linguagens de programção.

## 4 - Comandos básicos do Terraform

Quando usamos o Terraform ele quarda o estado localmente. O ideal é colocar o arquivo de estado em um lugar seguro remoto, pois o local pode ser perdido.

Como exemplo, pode-se guardar em um serviço de armazenamento em cloud, como o S3 da AWS.

### 4.1 - Utilizando o Terraform através de um container
Essa é uma estratégia interessante, pois não precisa ter o Terraform instalado, basta executar o container que já é disponibilizado com um ambiente contendo o terraform.
####Rodando o container:

```bash
docker run -it -v $PWD:/app -w /app --entrypoint "" hashicorp/terraform:light sh
```
Com o comando assim, estamos executando um container e acessível já com bind volume para o local onde estão os arquivos .tf. Por isso, o comando de execução do container deve ser rodado onde estão os arquivos .tf.

### 4.2 - Rodando o primeiro comando terraform
```bash
terraform init
```
Os nomes de arquivos pouco importam para o Terraform. Ele vai ler todos os arquivos .tf no diretório corrente.
O *terraform init* vai inicializar tudo, faz as configurações e cria o arquivo de estados. Na primeira execução, será apresentado um erro, pois necessitamos de um key e secret do provider AWS, pois aqui está sendo o usado o backend para o arquivo de estado ser armazenado em um bucket S3 da AWS.

Há várias formas de passar a key e a secret para o terraform. Uma opção é através de variáveis de ambiente. No terminal do container, basta executar:
```bash
export AWS_ACCESS_KEY_ID="SEU ACCESS KEY AQUI"
export AWS_SECRET_ACCESS_KEY"SUA SECRET ACCESS AQUI"
```
Agora ao executar o terraform init, terá sucesso. Após executar o init, será criada a pasta .terraform. Nessa pasta está tudo que o terraform precisa para funcionar.

### 4.3 - Plan
```bash
terraform plan
```
O plan verifica o arquivo de estado e a infra que já existe e mostra o que será modificado, mas sem ainda fazer nenhuma modificação.

### 4.4 - Apply
```bash
terraform apply
```
Após executar o plan, com o apply serão aplicadas as modificações.

### 4.5 - Destroy
```bash
terraform destroy
```
Esse comando vai "tirar" tudo que está definido nos arquivos hcl, os arquivos .tf. É o inverso do comando apply.
Ao executar o terraform destroy, é apresentado um plan de tudo que ele vai destruir. Você tem que confirmar.
Alternativamente, pode-se utilizar o plan também para mostrar o que vai ser destruído:
```bash
terraform plan -destroy
```

### 4.6 - Opções adicionais ao init
```bash
terraform init -upgrade
```
Com o *-upgrade*, o terraform vai atualizar os plugins

### 4.7 - Opções adicionais ao plan
```bash
terraform plan -out=nome_do_plan
```
Ele vai gerar um arquivo do plan. Isso é boa prática.

Agora ao executar o apply, basta informar o nome do arquivo que foi gerado no plan.
```bash
terraform apply nome_do_arquivo_plan_gerado_no_plan
```

## 5 - Expression e Console

Expressions é tudo aquilo que no arquivo hcl é expressado em valor.  Podem ser valores literais como "hello" ou um simples número 3. 
Os expressions são valores e possuem tipos: string, number, bool, list (ou tuple), map (ou object).
Exemplo de list:
["us-east-1", "us-west-1"]

Exemplo de map:
{name = "Mabel", age = 52}

Existe o null que é forma de expressar que um parametro é null. Em uma condicional, é muito usado para definir que algo será omitido dentro de um recurso.

### 5.1 - References Named
* Recurso: É uma forma de refenciar recursos. Por exemplo:
aws_instance.web.public_ip
* Variáveis: É uma forma de referenciar variávies
* Local
* Module
* Data: É um tipo de valor especial que busca informações no provider.

### 5.3 - Console
Para abrir a console:
```bash
terraform console
```
Através do console é possível interagir com o estado (state).

## 6 - Providers
É um tipo de bloc especial que especifica em qual provedor o terraform vai conectar. Cada provider tem seus próprios argumentos.

Dentro do bloco tem dois meta-argumentos: alias e o version.
Com o alias é possível trabalhar com multiplos providers.