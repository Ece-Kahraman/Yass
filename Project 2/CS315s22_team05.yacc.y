/* yass.y */
%{
#include <stdio.h>
%}

%token START
%token END
%token SET_KEYWORD
%token FUNC_KEYWORD
%token ELEMENT_KEYWORD
%token STRING_KEYWORD
%token INT_KEYWORD
%token BOOL_KEYWORD
%token SC
%token LP
%token RP
%token ASSIGN_OP
%token INTERSECTION_OP
%token UNION_OP
%token SET_DIFFERENCE_OP
%token MULTIPLICATION_OP
%token DIVISION_OP
%token ADDITION_OP
%token SUBTRACTION_OP
%token LB
%token RB
%token COMMA
%token IF
%token ELSE
%token ELSE_IF
%token WHILE
%token DO
%token RETURN
%token COMMENT
%token DEL
%token SUBSET_OF
%token SUPERSET_OF
%token LESS_THAN
%token GREATER_THAN
%token LESS_OR_EQUAL
%token GREATER_OR_EQUAL
%token IS_EQUAL
%token NOT_EQUAL
%token TRUE
%token FALSE
%token ADD_FUNC
%token REMOVE_FUNC
%token PRINT_FUNC
%token PRINT_FILE_FUNC
%token READ_FUNC
%token READ_FILE_FUNC
%token ISEMPTY_FUNC
%token GETSIZE_FUNC
%token CONTAINS_FUNC
%token POP_FUNC
%token MAIN_FUNC
%token FUNC_IDENT
%token STRING
%token ELEMENT
%token INT
%token SET_IDENT
%token VAR_IDENT

%start program
%right ASSIGN_OP

%%

program: START code END
;

code: 
statement_list | main
| statement_list main
| main statement_list
| statement_list main statement_list  
;

statement_list:
statement | statement statement_list
;

main:
MAIN_FUNC LP RP block
;

statement:
conditional_statement 
| assignment_statement SC
| comment_statement
| del_statement SC
| loop_statement
| declaration_statement SC
| return_statement SC
| func_call_statement SC
;

conditional_statement:
if_block ELSE block
| if_block
| if_block elif else
		  ;

if_block:
IF LP inside_if RP block
;

elif:
elif_block
| elif_block elif
;

elif_block:
ELSE_IF LP inside_if RP block
;

else:
   ELSE block | empty
     ;

inside_if:
rel_expression
| func_call
| VAR_IDENT
;

assignment_statement:
SET_IDENT ASSIGN_OP set_expression
| VAR_IDENT ASSIGN_OP initial
| VAR_IDENT ASSIGN_OP int_expression_one
| SET_IDENT ASSIGN_OP func_call
| VAR_IDENT ASSIGN_OP func_call
;
initial:
ELEMENT | STRING | bool
;
comment_statement:
COMMENT
;
del_statement:
DEL SET_IDENT
;
loop_statement:
  WHILE LP rel_expression RP block
| WHILE LP bool RP block
| WHILE LP func_call RP block
| DO block WHILE LP rel_expression RP
| DO block WHILE LP bool RP
| DO block WHILE LP func_call RP
;
declaration_statement:
  set_declaration
| func_declaration
| element_declaration
| string_declaration
| int_declaration
| bool_declaration
;
return_statement:
RETURN return_type
;
return_type:
type_ident
| type_init
;
func_call_statement:
func_call
;
block:
LB RB
| LB statement_list RB
;
empty:
;

set_declaration:
SET_KEYWORD SET_IDENT ASSIGN_OP set_expression 
| SET_KEYWORD SET_IDENT ASSIGN_OP set_init
| SET_KEYWORD SET_IDENT ASSIGN_OP func_call
| SET_KEYWORD SET_IDENT
;

func_declaration:
FUNC_KEYWORD FUNC_IDENT LP typed_argument_list RP block
;
element_declaration:
ELEMENT_KEYWORD VAR_IDENT
| ELEMENT_KEYWORD VAR_IDENT ASSIGN_OP ELEMENT
| ELEMENT_KEYWORD VAR_IDENT ASSIGN_OP func_call
;
string_declaration:
STRING_KEYWORD VAR_IDENT
| STRING_KEYWORD VAR_IDENT ASSIGN_OP STRING
| STRING_KEYWORD VAR_IDENT ASSIGN_OP func_call
;

bool_declaration:
BOOL_KEYWORD VAR_IDENT
| BOOL_KEYWORD VAR_IDENT ASSIGN_OP bool
| BOOL_KEYWORD VAR_IDENT ASSIGN_OP func_call
;

int_declaration:
INT_KEYWORD VAR_IDENT
| INT_KEYWORD VAR_IDENT ASSIGN_OP int_expression_one
| INT_KEYWORD VAR_IDENT ASSIGN_OP func_call
;

int_expression_one:
int_expression_one low_precedence_op int_expression_two
| int_expression_two
;
int_expression_two:
VAR_IDENT | INT
| int_expression_two high_precedence_op VAR_IDENT
| int_expression_two high_precedence_op INT
;
set_expression:
SET_IDENT | set_expression set_operator SET_IDENT
;
rel_expression:
SET_IDENT set_rel_operator SET_IDENT
| VAR_IDENT int_rel_operator VAR_IDENT
| VAR_IDENT int_rel_operator INT
| INT int_rel_operator VAR_IDENT
| VAR_IDENT bool_rel_operator bool
;
argument_list:
empty
| type_init | type_ident
| type_init COMMA argument_list
| type_ident COMMA argument_list
;
typed_argument_list:
 empty
| type_keyword type_ident
| type_keyword type_ident COMMA typed_argument_list
 ;
element_list:
  ELEMENT
| ELEMENT COMMA element_list
  ;
set_init:
 LB RB
| LB element_list RB
 ;
primitive_func:
add | remove | print | printFile | read | readFile | isEmpty | getSize | contains | pop
;
add:
ADD_FUNC LP SET_IDENT COMMA ELEMENT RP
| ADD_FUNC LP SET_IDENT COMMA VAR_IDENT RP
;
remove:
REMOVE_FUNC LP SET_IDENT COMMA ELEMENT RP
| REMOVE_FUNC LP SET_IDENT COMMA VAR_IDENT RP
;
print:
PRINT_FUNC LP STRING RP
| PRINT_FUNC LP VAR_IDENT RP
| PRINT_FUNC LP SET_IDENT RP
;
printFile:
PRINT_FILE_FUNC LP STRING COMMA SET_IDENT RP
|PRINT_FILE_FUNC LP STRING COMMA VAR_IDENT  RP 
;
read:
READ_FUNC LP everything RP
;
everything:
type_ident | STRING | INT | ELEMENT
;
readFile:
READ_FILE_FUNC LP STRING RP
;
isEmpty:
ISEMPTY_FUNC LP SET_IDENT RP
;
contains:
CONTAINS_FUNC LP SET_IDENT COMMA ELEMENT RP
| CONTAINS_FUNC LP SET_IDENT COMMA VAR_IDENT RP
;
getSize:
GETSIZE_FUNC LP SET_IDENT RP
;
pop:
POP_FUNC LP SET_IDENT RP
;

func_call:
FUNC_IDENT LP argument_list RP
| FUNC_IDENT LP rel_expression RP
| FUNC_IDENT LP func_call RP
| primitive_func
;
set_rel_operator:
SUBSET_OF
| SUPERSET_OF
| IS_EQUAL
| NOT_EQUAL
;
int_rel_operator:
LESS_THAN
| GREATER_THAN
| LESS_OR_EQUAL
| GREATER_OR_EQUAL
| IS_EQUAL
| NOT_EQUAL
;
bool_rel_operator:
IS_EQUAL
| NOT_EQUAL
;
set_operator:
 UNION_OP | INTERSECTION_OP | SET_DIFFERENCE_OP
 ;
low_precedence_op:
ADDITION_OP
| SUBTRACTION_OP
;
high_precedence_op:
MULTIPLICATION_OP
| DIVISION_OP
;
type_ident:
VAR_IDENT
| SET_IDENT
;
type_init:
set_init
| ELEMENT
| STRING
| INT
| bool
;
type_keyword:
SET_KEYWORD
| ELEMENT_KEYWORD
| STRING_KEYWORD
| INT_KEYWORD
;
bool:
TRUE
| FALSE
;

%%
#include "lex.yy.c"
int lineno = 1;
int yyerror(char *s) {
  fprintf(stderr, "%s in line: %d \n",s, lineno);
}
 main(){
 return  yyparse();
 
}

