---

# Analisador de Expressões Aritméticas com Bison

Este projeto implementa um analisador sintático básico para expressões aritméticas utilizando o Bison. Ele pode interpretar e calcular expressões que incluem operações de adição, subtração, multiplicação, divisão e o uso de parênteses para indicar precedência.

## Estrutura do Código

### Cabeçalhos e Funções Auxiliares

```c
%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}
```

- **Inclusões de Biblioteca:** O código inclui as bibliotecas padrão `stdio.h` e `stdlib.h` para entrada e saída, e manipulação de funções básicas.
- **Funções Declaradas:**
  - `yyerror(const char *s)`: Função usada para exibir mensagens de erro durante a análise.
  - `yylex(void)`: Função responsável pela análise léxica, gerada pelo Flex ou outro analisador léxico.

### Declaração de Tokens

```c
%token NUMBER
```

- **NUMBER:** Token utilizado para identificar números inteiros na entrada.

### Regras de Produção

```c
%%

input:
    expr { printf("Resultado: %d\n", $1); }
    ;

expr:
    expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $1 / $3; }
    | '(' expr ')' { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;

%%
```

- **Regra `input:`**
  - Define que a entrada deve consistir em uma expressão (`expr`).
  - Após avaliar a expressão, o resultado é impresso.

- **Regra `expr:`**
  - Define as operações aritméticas básicas:
    - `+` para adição.
    - `-` para subtração.
    - `*` para multiplicação.
    - `/` para divisão.
  - Suporte para expressões entre parênteses.
  - Uso do token `NUMBER` para representar números inteiros.

### Tratamento de Erros

```c
void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}
```

- **`yyerror`:** Função que imprime mensagens de erro quando a análise sintática falha.

### Função Principal

```c
int main(void) {
    return yyparse();
}
```

- **`main`:** Inicia o processo de análise sintática chamando `yyparse`, a função gerada pelo Bison.

## Como Executar
 - bison -d calc.y
 - flex calc.l
 - gcc calc.tab.c lex.yy.c -o calc -lfl
 - ./calc
## Exemplo de Uso

```
Entrada: (3 + 2) * 5 - 8 / 2
Saída: Resultado: 23
```
