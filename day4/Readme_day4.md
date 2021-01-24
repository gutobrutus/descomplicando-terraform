# 1 - Condições
Condições permitem adicionar lógica no código utilizado pelo Terraform.

## 1.1 - Operadores aritméticos e lógicos

Link da documentação:
https://www.terraform.io/docs/language/expressions/operators.html

Quando múltiplos operadores são usados, há uma ordem de precedencia a ser observada, conforme a documentação esclarece.

## 1.2 - Expressões condicionais

Sintaxe de um if:
```yaml
condition ? true_val : false_val
```

# 2 - Type Constraints

Link da documentação:
https://terraform.io/docs/configuration/types.html#collection-types

## 2.1 - Tipos primitivos
- String
- Number
- Boolean (bool)

## 2.2 - Tipos complexos
### 2.2.1 - Coleções
- list(string ou number ou any) -> quando utilizado any, a lista será conforme o primeiro elemento, se for um number o primeiro elemento, todos os outros deverão ser number.
- map() -> uma coleção de chave, valor.
- set() -> uma coleção de valores únicos, sem identificadores.
### 2.2.2 - Estruturais
- object() -> aceita tipos diferentes
- tupla()
Exemplos:
- object
```yaml
object({name=string, age=number})
```
- tuple
```yaml
tuple([string, number, bool])
```
# 3 - For each

É uma forma de realizar um loop

Exemplo de sintaxe:
Conforme doc: https://www.terraform.io/docs/language/meta-arguments/for_each.html
