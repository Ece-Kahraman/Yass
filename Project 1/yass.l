%option main
digit [0-9]
letter [a-z]
cap_letter [A-Z]
white_space [ \t]
symbols  [\.\/\?\*\\\%\=\!\-\|\_\$\+\^\#\(\)\{\}\[\]\é\&\<\>\:\;\,\'\@\£\\æ\ß]
string ({digit}|{letter}|{cap_letter}|{white_space}|{symbols})*
%%

set printf("SET_KEYWORD ");
function printf("FUNCTION_KEYWORD ");
element printf("ELEMENT_KEYWORD ");
string printf("STRING_KEYWORD ");
int printf("INT_KEYWORD ");
\;  printf("SC ");
\= printf("ASSIGN_OP ");
\( printf("LP ");
\) printf("RP ");
and printf("INTERSECTION_OP ");
or printf("UNION_OP ");
sub printf("SET_DIFFERENCE_OP ");
\* printf("MULTIPLICATION_OP ");
\/ printf("DIVISION_OP ");
\+ printf("ADDITION_OP ");
\- printf("SUBTRACTION_OP ");
\{ printf("LB ");
\} printf("RB ");
\, printf("COMMA ");
if printf("IF ");
else printf("ELSE ");
elif printf("ELSE_IF ");
while printf("WHILE ");
do printf("DO ");
return printf("RETURN ");
\/\/{string}\n printf("COMMENT_SB STRING NL ");
del printf("DEL ");
\<\< printf("SUBSET_OF ");
\>\> printf("SUPERSET_OF ");
\< printf("LESS_THAN ");
\> printf("GREATER_THAN ");
\<\= printf("LESS_OR_EQUAL ");
\>\= printf("GREATER_OR_EQUAL ");
\=\= printf("IS_EQUAL ");
\!\= printf("NOT_EQUAL ");
true printf("TRUE ");
false printf("FALSE ");
\_add printf("ADD_FUNC ");
\_remove printf("REMOVE_FUNC ");
\_print printf("PRINT_FUNC ");
\_printFile printf("PRINT_FILE_FUNC ");
\_read printf("READ_FUNC ");
\_readFile printf("READ_FILE_FUNC ");
\_isEmpty printf("ISEMPTY_FUNC ");
\_getSize printf("GETSIZE_FUNC ");
\_contains printf("CONTAINS_FUNC ");
\_pop printf("POP_FUNC ");
\_{letter}({letter}|{digit})* printf("FUNC_IDENT ");
\"{string}(\n)*\" printf("STRING ");
\'{string}\' printf("ELEMENT ");
(-)?{digit}+ printf("NUMBER ");
{cap_letter}({letter}|{digit})*  printf("SET_IDENT ");
{letter}({cap_letter}|{letter}|{digit})* printf("VARIABLE_IDENT ");
YASS printf(":) ");
{white_space} ;
. printf("UNRECOGNIZED ");
%%


