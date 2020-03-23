%{
	#include <stdio.h>
	#include <string.h>
	#include "P1.tab.h"
%}

digit 		[0-9]
integer 	(0|([1-9]{digit}*))
space 		"\t"|"\n"|"\r"|"\f"|" "
identifier	[_a-zA-Z]([_a-zA-Z]|{digit})*
	
%%
"//".* {;}
{space} {;}
"+" {return Plus;}
"-" {return Minus;}
";" {return End;}
"*" {return Mult;}
"/" {return Div;}
"<=" {return Less;}
"=" {return Equal;}
"." {return Dot;}
"," {return Coma;}
"[" {return SqOpen;}
"]" {return SqClose;}
"{" {return CurlyOpen;}
"}" {return CurlyClose;}
"(" {return BracketOpen;}
")" {return BracketClose;}
"&&" {return And;}
"||" {return Or;}
"!" {return Not;}
"!=" {return NOTEQ;}
"#" {return Hash;}
"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}
"length" {return LENGTH;}
"true" {return TRUEE;}
"false" {return FALSEE;}
"System.out.println" {return SOP;}
"int" {return INTIG;}
"boolean" {return BOOLN;}
"return" {return RETURN;}
"class" {return CLASS;}
"public" {return PUBLIC;}
"static" {return STATIC;}
"extends" {return EXTENDS;}
"void" {return VOId;}
"main" {return MAIN;}
"String" {return STRING;}
"define" {return DEFINE;}
"new" {return NEW;}
"this" {return THIS;}
{integer} {yylval.character=strdup(yytext); return Integer ;}
{identifier} {yylval.character = strdup(yytext); return Identifier;}
%%
