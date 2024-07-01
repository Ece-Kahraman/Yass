%{
#include <stdio.h>
#include "y.tab.h"
%}

digit [0-9]
letter [a-z]
cap_letter [A-Z]
white_space [ \t]
symbols  [\.\/\?\*\\\%\=\!\-\|\_\$\+\^\#\(\)\[\]\é\&\<\>\:\,\'\@\£\\æ\ß]
string ({digit}|{letter}|{cap_letter}|{white_space}|{symbols})*
%option yylineno
%%

start return (START );
end return (END );
set return (SET_KEYWORD );
function return (FUNC_KEYWORD );
element return (ELEMENT_KEYWORD);
string return (STRING_KEYWORD );
int return (INT_KEYWORD );
bool return (BOOL_KEYWORD );
\;  return (SC );
\= return (ASSIGN_OP );
\( return (LP );
\) return (RP );
and return (INTERSECTION_OP);
or return (UNION_OP );
sub return (SET_DIFFERENCE_OP);
\* return (MULTIPLICATION_OP);
\/ return (DIVISION_OP);
\+ return (ADDITION_OP);
\- return (SUBTRACTION_OP);
\{ return (LB);
\} return (RB);
\, return (COMMA);
if return (IF );
else return (ELSE );
elif return (ELSE_IF );
while return (WHILE );
do return (DO );
return return (RETURN );
\/\/{string}\n return (COMMENT );
del return (DEL );
\<\< return (SUBSET_OF );
\>\> return (SUPERSET_OF );
\< return (LESS_THAN );
\> return (GREATER_THAN );
\<\= return (LESS_OR_EQUAL );
\>\= return (GREATER_OR_EQUAL );
\=\= return (IS_EQUAL );
\!\= return (NOT_EQUAL );
true return (TRUE );
false return (FALSE );
\_add return (ADD_FUNC );
\_remove return (REMOVE_FUNC );
\_print return (PRINT_FUNC );
\_printFile return (PRINT_FILE_FUNC );
\_read return (READ_FUNC );
\_readFile return (READ_FILE_FUNC );
\_isEmpty return (ISEMPTY_FUNC );
\_getSize return (GETSIZE_FUNC );
\_contains return (CONTAINS_FUNC );
\_pop return (POP_FUNC );
\_main return (MAIN_FUNC );
\_{letter}({letter}|{digit})* return (FUNC_IDENT );
\"{string}(\n)*\" return (STRING );
\'{string}\' return (ELEMENT );
(-)?{digit}+ return (INT );
{cap_letter}({letter}|{digit})*  return (SET_IDENT );
{letter}({cap_letter}|{letter}|{digit})* return (VAR_IDENT );
{white_space} ;
\n    {extern int lineno; lineno++;};
%%

int yywrap(void) { return 1;}
