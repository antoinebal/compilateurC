#include <stdio.h>
#include <string.h>

struct instruction {
	char* instr; //load, store, etc.
	argument arg[3]; //numéro de registre ou adresse
};
typedef struct argument argument;
struct argument {
	int numeroRegistre;
	int adresseMemoire;
}
void ajouterFlag(char* flag);
void ajouterInstr(char* instr, argument arg);
void ajouterInstr(char* instr, argument arg1, argument arg2);
void ajouterInstr(char* instr, argument arg1, argument arg2, argument arg3);
