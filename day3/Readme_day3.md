# 1 - Anotações da aula do day3
Conseguindo ajuda, basta acessar a página oficial do terraform
O menu lateral da documentação, está organizado de modo bem claro e organizado por assunto.
Outra forma é usar o help do própria CLI de comandos, usando -help.

## 1.1 - Shell Tab-completion

Basta executar:
```bash
terraform -install-autocomplete
```

# 2 - Dependência entre recursos
É um recurso muito importante, intermediário. No uso mais comum e simples, isso talvez não seja necessário.

A ideia é que um dado recurso, quando executamos um apply, saiba o que rodar primeiro, o que rodar em paralelo, etc. Isso se deve ao fato de que alguns recursos dependem de outros.

Pra esse tema, vamos usar a documentação getting started. Link:
https://learn.hashicorp.com/terraform/getting-started/dependencies.html

Existem dois tipos de dependências: Implícitas e Explícitas.

# 3 - Troubleshooting (Debugging)
É possível aumentar a verbose dos comandos do terraform.
Link da documentação:
https://terraform.io/docs/internals/debugging.html

Para alterar o verbose:
```bash
TF_LOG=DEBUG terraform plan --out plano.plan
```
Foi ilustrado com o plan, mas pode ser usado com qualquer um.
Existem vários níveis de LOG, o TRACE é o mais completo.

# 4 - Comandos state, taint e untaint

## 4.1 - Comando state
Link pra documentação:
https://terraform.io/docs/command/state/index.html

O state é usado para ler o state.

```bash
terraform state list
```
No exemplo acia, listamos os recursos que estão no state atualmente.

## 4.2 - Comando taint
Link para documentação:

Serve para marcar um determinado recurso para ser destruído e recriado após um plan e apply.

```bash
terraform taint aws_instance.foo
```

## 4.3 - Comando untaint
Consiste no inverso do taint.

# 5 - Comando graph
Link para documentação:
https://terraform.io/docs/commands/graph.html

È um comando que gera uma visualização da configuração de um plan, em um formato dot file.

O formato dor file pode ser usado pelo GraphoViz, para exibir.

Para executar o graph:
```bash
terraform graph
```
Na forma acima, ele vai gerar uma saída em modo texto.
É possível utilizar o GraphViz, mas para isso é preciso ter instalado. Na imagem do terraform, que é baseada no alpine, basta executar:
```bash
apk -U add graphviz
```
Com o pacote instalado, é possível agora ler o arquivo dot e gerar de forma visual com:
```bash
terraform graph | dot -Tsvg > graph.svg
```
O arquivo graph.svg exibe o grafo dos recursos.

# 6 - Comando fmt
Comando utilizado para formatar os arquivos de definição do terraform.
Link da documentação:
https://terraform.io/docs/commands/fmt.html

Esse comando reescreve os arquivos para colocar na formatação correta. Para executar:
```bash
terraform fmt
```
Há várias opções na doc.

# 7 - Comando validate
É um comando muito importante quando se usa, principalmente, quando se está utilizando um pipeline.
Link da documentação:
https://terraform.io/docs/commands/validade.html

```bash
terraform validate [options] [dir]
```
Q