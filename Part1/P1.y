%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	int yyerror ();
	int yylex(void);

	struct node{
		char *id;
		char **arg;
		char *val;
		int n_arg;
		struct node * next;
	};

	struct node *head ;
	struct node *current ;

	char* str_replace(char *orig, char *rep, char *with) 
	{   
	    int len_rep;  
	    int len_with; 
	    int len_front; 
	    int count;  
	    char *result; 
	    char *ins;   
	    char *tmp;   

	    if (!orig || !rep)
	        return NULL;
	    len_rep = strlen(rep);
	    if (len_rep == 0)
	        return NULL; 
	    if (!with)
	        with = "";
	    len_with = strlen(with);

	    ins = orig;
	    for (count = 0; tmp = strstr(ins, rep); ++count) {
	        ins = tmp + len_rep;
	    }

	    tmp = result = malloc((strlen(orig) + (len_with - len_rep) * count + 1)*sizeof(char));

	    if (!result)
	        return NULL;

	    while (count--) {
	        ins = strstr(orig, rep);
	        len_front = ins - orig;
	        tmp = strncpy(tmp, orig, len_front) + len_front;
	        tmp = strcpy(tmp, with) + len_with;
	        orig += len_front + len_rep; 
	    }
	    strcpy(tmp, orig);
	    return result;
	}

	void addEntry(char *name, char *args, char *str)
	{	
		struct node * temp = (struct node*)malloc(sizeof(struct node));

		temp->id = (char *) calloc(strlen(name) +1, sizeof(char));
		strcat(temp->id , name);

		temp->arg = malloc(1000*sizeof(char*));

		char *tok;
		tok = strtok(args, ",\n");
		int pos=0;

		while(tok != NULL)
		{
			temp->arg[pos] = tok;
			pos++;
			tok = strtok(NULL, ", \n\t\a\r");
		}

		temp->n_arg = pos; 
		temp->val = (char * )calloc(strlen(str)+1, sizeof(char));

		strcat(temp->val, str);
		temp-> next = NULL;

		if(head == NULL)
		{
			head = temp;
			current = temp;
		}
		else
		{
			current -> next = temp;
			current = current -> next;
		}
	}

	char* searchEntry(char *name, char *argz)
	{
		struct node *t = head;
		char *ans = NULL;

		while(t!=NULL)
		{
			if(strcmp(name, t->id)==0)
			{
				char ** myarg = malloc(1000*sizeof(char*));
				char *tok;
				tok = strtok(argz, ",\n");
				int pos=0;
				while(tok != NULL)
				{
					myarg[pos] = tok;
					pos++;
					tok = strtok(NULL, ", \n\t\a\r");
				}

				if(pos != t->n_arg)
				{
					t = t->next;
					continue;
				}
				else
				{
					ans = (char *) calloc(strlen(t->val) +1, sizeof(char));
					strcat(ans, t->val);
					for(int i=0; i<pos; i++)
					{
						ans = str_replace(ans, t->arg[i], myarg[i]);
					}
					return ans;
				}
			}
			t = t->next;
		}
		return ans;
	}	

	char* cat1(char *c1)
	{
		char *c0 = (char *) calloc(strlen(c1) + 1, sizeof(char));
		strcat(c0, c1);

		return c0;
	}
	char* cat2(char *c1, char *c2)
	{
		char *c0 = (char *) calloc(strlen(c1)+strlen(c2) + 2, sizeof(char));
		strcat(c0, c1);
		strcat(c0, c2);

		return c0;
	}	
	char* cat3(char *c1, char *c2, char *c3)
	{
		char *c0 = (char *) calloc(strlen(c1)+strlen(c2)+strlen(c3) + 3, sizeof(char));
		strcat(c0, c1);
		strcat(c0, c2);
		strcat(c0, c3);
		
		return c0;
	}
	char* cat4(char *c1, char *c2, char *c3, char *c4)
	{
		char *c0 = (char *) calloc(strlen(c1)+strlen(c2)+strlen(c3)+strlen(c4) +4, sizeof(char));
		strcat(c0, c1);
		strcat(c0, c2);
		strcat(c0, c3);
		strcat(c0, c4);

		return c0;
	}
	char* cat5(char *c1, char *c2, char *c3, char *c4, char *c5)
	{
		char *c0 = (char *) calloc(strlen(c1)+strlen(c2)+strlen(c3)+strlen(c4)+strlen(c5) + 5, sizeof(char));
		strcat(c0, c1);
		strcat(c0, c2);
		strcat(c0, c3);
		strcat(c0, c4);
		strcat(c0, c5);

		return c0;
	}
	char* cat6(char *c1, char *c2, char *c3, char *c4, char *c5, char* c6)
	{
		char *c0 = (char *) calloc(strlen(c1)+strlen(c2)+strlen(c3)+strlen(c4)+strlen(c5)+strlen(c6) + 6, sizeof(char));
		strcat(c0, c1);
		strcat(c0, c2);
		strcat(c0, c3);
		strcat(c0, c4);
		strcat(c0, c5);
		strcat(c0, c6);

		return c0;
	}
	char* cat7(char *c1, char *c2, char *c3, char *c4, char *c5, char* c6, char *c7)
	{
		char *c0 = (char *) calloc(strlen(c1)+strlen(c2)+strlen(c3)+strlen(c4)+strlen(c5)+strlen(c6)+strlen(c7) + 7, sizeof(char));
		strcat(c0, c1);
		strcat(c0, c2);
		strcat(c0, c3);
		strcat(c0, c4);
		strcat(c0, c5);
		strcat(c0, c6);
		strcat(c0, c7);
		return c0;
	}
%}

%union
{
    int integer;
	char * character; 
}
%start Goal;
%type <character> Identifier Integer Statement StatementStar IdStar IdStar2
		Expression ExpressionStar PExpression TYPE TypeDec TypeDecStar Expressions
		MetDec MetDecStar TypeIdStar TypeIdStar2 TypeIdStar3 MacroDefStar MacroDef
		MacroDefExp MAcroDefStmt  MainClass Program


%token 	Identifier Integer Plus Minus Mult Div End And Or 
		Not Less Equal Dot Coma Hash SqOpen SqClose CurlyOpen CurlyClose
		BracketOpen BracketClose IF ELSE WHILE LENGTH TRUEE FALSEE SOP INTIG BOOLN 
		RETURN PUBLIC EXTENDS CLASS STATIC VOId MAIN STRING DEFINE NEW THIS NOTEQ 

%%
 Goal : Program
{
	printf("%s\n", $1);
	
}
;

Program : MacroDefStar MainClass TypeDecStar
{
	$$ = cat2($2, $3);
}
;

MainClass : CLASS Identifier CurlyOpen PUBLIC STATIC VOId MAIN BracketOpen STRING SqOpen SqClose Identifier BracketClose CurlyOpen SOP BracketOpen Expression BracketClose End CurlyClose CurlyClose
{
	char *tmp =  cat4("class ", $2, "{ \npublic static void main ( String [] ", $12);
	$$ = cat4(tmp, ") { \nSystem.out.println (", $17, "); \n}\n}\n");

}
;

MacroDefStar : MacroDefStar MacroDef 
{
	//$$ = cat2($1, $2);
}
	|
{
	$$ = cat1("");
}
;

TypeDecStar : TypeDec TypeDecStar
{
	$$ = cat2($1, $2);
}
	| 
{
	$$ = cat1("");
}
;
MetDecStar : MetDec MetDecStar 
{
	$$ = cat2($1, $2);
}
	| 
{ 
	$$ = cat1("");
}
;
MacroDef : MacroDefExp
{
	$$ = cat1($1);
}
	| MAcroDefStmt
{
	$$ = cat1($1);
}
;

MAcroDefStmt : Hash DEFINE Identifier BracketOpen IdStar BracketClose CurlyOpen StatementStar CurlyClose
{
	// char *tmp = cat5("#define ", $3, "(", $5, ") {");
	// $$ = cat3(tmp, $8, "}");
	$$ = "";
	addEntry($3, $5, $8);

};
MacroDefExp : Hash DEFINE Identifier BracketOpen IdStar BracketClose BracketOpen Expression BracketClose
{
	// char * tmp = cat5("#define ", $3, "(", $5, ")");
	// $$ = cat4(tmp, " (", $8,") \n");
	$$ = "";
	addEntry($3, $5, $8);
}
;
 
IdStar :  Identifier IdStar2
{
	$$ = cat2($1, $2);
}
	| 
{
	$$ = cat1("");
}
;

IdStar2 : Coma Identifier IdStar2
{
	$$ = cat3(", ", $2, $3);
}
	|  
{
	$$ = cat1("");
}
;


TYPE : INTIG SqOpen SqClose
{
	$$ = cat1("int[] ");
} 
	| BOOLN
{
	$$ = cat1("boolean ");
}
	| INTIG
{
	$$ = cat1("int ");
}
	| Identifier
{
	$$ = cat2($1, " ");
}
;


TypeDec : CLASS Identifier CurlyOpen TypeIdStar MetDecStar CurlyClose
{
	$$ = cat6("class ", $2, " {\n", $4, $5, "}\n");
}	
	| CLASS Identifier EXTENDS Identifier CurlyOpen TypeIdStar MetDecStar  CurlyClose
{
	char *tmp = cat4("class " , $2, " extends ", $4);
	$$ = cat5(tmp, "{\n", $6, $7, "}\n");
}
;

TypeIdStar : TypeIdStar  TYPE Identifier End 
{
	$$ = cat4($1, $2, $3, ";\n");
}
	|
{
	$$ = cat1("");
}
;

MetDec : PUBLIC TYPE Identifier BracketOpen TypeIdStar2 BracketClose CurlyOpen TypeIdStar StatementStar RETURN Expression End CurlyClose
{
	char *tmp = cat7("public ", $2, $3, "(", $5, ") {\n", $8);
	$$ = cat5(tmp, $9, " return ", $11, ";\n}\n");
}
;

TypeIdStar2 :  TYPE Identifier TypeIdStar3
{
	$$ = cat4($1, " ", $2, $3);
}
	|  
{
	$$ = cat1("");
}
;

TypeIdStar3 :Coma TYPE Identifier  TypeIdStar3  
{
	$$ = cat4(",", $2, $3, $4);
}
	|  
{
	$$ = cat1("");
}
;

StatementStar :  Statement StatementStar
{
	$$ = cat2($1, $2);
}
	| 
{
	$$ = cat1("");
}
;

Statement : CurlyOpen StatementStar CurlyClose
{
	$$ = cat3("{\n", $2, "} \n");
}
	| Identifier Equal Expression End
{
	$$ = cat4($1, " = ", $3, ";\n");
}
	| SOP BracketOpen Expression BracketClose End
{
	$$ = cat3("System.out.println(", $3, ");");
}
	| Identifier SqOpen Expression SqClose Equal Expression End
{
	$$ = cat6($1, "[", $3, "]=", $6, ";\n");
}
 	| IF BracketOpen Expression BracketClose StatementStar
{
	$$ = cat4("if (", $3, ")\n", $5);
}
	| IF BracketOpen Expression BracketClose StatementStar ELSE StatementStar
{
	$$ = cat6("if (", $3, ")\n",$5, "else " , $7);
}
	| WHILE BracketOpen Expression BracketClose StatementStar
{
	$$ = cat4("while (", $3, ")" , $5);
}
	| Identifier BracketOpen Expressions BracketClose End
{
	char * ans = searchEntry($1, $3);
	if(ans == NULL)
	{	yyerror();
		exit(0);
	}	// $$ = cat4($1, "(", $3, ");\n");
	else
	{
		$$ = cat2(ans, "\n");
	}
}
	| Identifier BracketOpen BracketClose End
{
	char *ans = searchEntry($1, "");

	if(ans == NULL)
	{	yyerror();
		exit(0);
	}	
		// $$ = cat2($1, "(); \n");
	else
		$$ = cat2(ans, "(); \n");
}
;
Expressions : Expression ExpressionStar
{
	$$ = cat2($1, $2);
}
	|
{
	$$ = cat1("");
}
;
ExpressionStar :  Coma Expression  ExpressionStar
{
	$$ = cat3( ",", $2, $3);
}
	| 
{
	$$ = cat1("");
}
;

Expression : PExpression And PExpression
{
	$$ = cat3($1, " && ", $3);
}
	| PExpression Or PExpression
{
	$$ = cat3($1, " || ", $3);
}
	| PExpression NOTEQ PExpression
{
	$$ = cat3($1, " != ", $3);
}
	| PExpression Less PExpression
{
	$$ = cat3($1, " <= ", $3);
}
	| PExpression Plus PExpression
{	
	$$ = cat3($1, " + ", $3);
}
	| PExpression Minus PExpression
{
	$$ = cat3($1, " - ", $3);
}
	| PExpression Mult PExpression
{
	$$ = cat3($1, "*", $3);
}
	| PExpression Div PExpression
{
	$$ = cat3($1, "/", $3);
}
	| PExpression SqOpen PExpression SqClose
{
	$$ = cat4($1, "[", $3, "]");
}
	| PExpression Dot LENGTH
{
	$$ = cat2($1, ".length");
}
	| PExpression
{
	$$ = cat1($1);
}
	| Identifier BracketOpen Expressions BracketClose 
{
	char * ans = searchEntry($1, $3);

	if(ans==NULL)
	{
		yyerror();
		exit(0);
	}	// $$ = cat4($1, "(", $3, ")");
	else
		$$ = cat3("(", ans, ")");
}
	| Identifier BracketOpen BracketClose
{
	char* ans = searchEntry($1, "");
	if(ans==NULL)
	{ 	
		yyerror();
		exit(0);
	}	// $$ = cat2($1, "()");
	else
		$$ = cat3("(", ans, ")");
}	
	| PExpression Dot Identifier BracketOpen Expressions BracketClose 
{
	$$ = cat6($1, ".", $3, "(", $5, ")");
}	
	| PExpression Dot Identifier BracketOpen BracketClose
{
	$$ = cat4($1, ".", $3, "()");
}
;

PExpression : Integer
{
	$$ = cat1($1);
}
	| Identifier
{
	$$ = cat1($1);
}
	| TRUEE
{
	$$ = cat1("true");
}
	| FALSEE
{
	$$ = cat1("false");
}
	| NEW INTIG SqOpen  Expression SqClose
{
	$$ = cat3("new int [", $4, "] ");
}
	| THIS
{
	$$ = cat1("this");
}
	| NEW Identifier BracketOpen BracketClose
{
	$$ = cat3("new ", $2, "() ");
}
	| Not Expression
{
	$$ = cat2("!" ,$2);
}
	| BracketOpen Expression BracketClose
{
	$$ = cat3("(", $2, ")");
};
%%


int yyerror()
{
	printf ("// Failed to parse macrojava code.\n");
	return 0;
}

int main ()
{

	yyparse();
	return 0;
}

