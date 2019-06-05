#include <stdio.h>
#include <string.h>
#include "tinstr.h"


instruction ti[1024];


//en fait c'est la mémoire d'instruction t'as vu ;)
int idx2 = 0;

void ajouterFlag(char* flag) {
	ti[idx2].instr=flag;
	idx2++;
}

void ajouterInstr1(char* instr, int arg) {
	ti[idx2].instr=instr;
	ti[idx2].arg[0]=arg;
	idx2++;
}

void ajouterInstr2(char* instr, int arg1, int arg2) {
	ti[idx2].instr=instr;
	ti[idx2].arg[0]=arg1;
	ti[idx2].arg[1]=arg2;
	idx2++;
}

void ajouterInstr3(char* instr, int arg1, int arg2, int arg3) {
	ti[idx2].instr=instr;
	ti[idx2].arg[0]=arg1;
	ti[idx2].arg[1]=arg2;
	ti[idx2].arg[2]=arg3;
	idx2++;
}



int getMemInstruction() {
	return idx2;
}

instruction getInstrAtIdx(int index) {
	return ti[index];
}


void modifierInstrAtIdx(int index, int numeroArg, int newValue) {
	ti[index].arg[numeroArg]=newValue;
}

void printInstr(instruction instr) {
	if (strcmp(instr.instr, "add")==0) {
	printf("%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "mul")==0) {
	printf("%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "sou")==0) {
	printf("%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "div")==0) {
	printf("%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "cop")==0) {
	printf("%s r%d r%d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else if (strcmp(instr.instr, "afc")==0) {
	printf("%s r%d %d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else if (strcmp(instr.instr, "load")==0) {
	printf("%s r%d %d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else if (strcmp(instr.instr, "store")==0) {
	printf("%s %d r%d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else if (strcmp(instr.instr, "equ")==0) {
	printf("%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "inf")==0) {
	printf("%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "infe")==0) {
	printf("%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "sup")==0) {
	printf("%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "supe")==0) {
	printf("%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "jmp")==0) {
	printf("%s %d", instr.instr, instr.arg[0]);
	}
	else if (strcmp(instr.instr, "jmpc")==0) {
	printf("%s %d r%d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else {
	printf("Instruction %s inconnue", instr.instr);
	}
}




void printT_Instr() {
	printf("\n**TI**\n");
	for(int k = 0 ; k < idx2 ; k++) {
		printInstr(ti[k]);
		printf("\n");
	}

}



void ecritInstr(instruction instr, FILE *file) {
	if (strcmp(instr.instr, "add")==0) {
	fprintf(file, "%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "mul")==0) {
	fprintf(file, "%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "sou")==0) {
	fprintf(file, "%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "div")==0) {
	fprintf(file, "%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "cop")==0) {
	fprintf(file, "%s r%d r%d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else if (strcmp(instr.instr, "afc")==0) {
	fprintf(file, "%s r%d %d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else if (strcmp(instr.instr, "load")==0) {
	fprintf(file, "%s r%d %d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else if (strcmp(instr.instr, "store")==0) {
	fprintf(file, "%s %d r%d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else if (strcmp(instr.instr, "equ")==0) {
	fprintf(file, "%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "inf")==0) {
	fprintf(file, "%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "infe")==0) {
	fprintf(file, "%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "sup")==0) {
	fprintf(file, "%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "supe")==0) {
	fprintf(file, "%s r%d r%d r%d", instr.instr, instr.arg[0], instr.arg[1],instr.arg[2]);
	}
	else if (strcmp(instr.instr, "jmp")==0) {
	fprintf(file, "%s %d", instr.instr, instr.arg[0]);
	}
	else if (strcmp(instr.instr, "jmpc")==0) {
	fprintf(file, "%s %d r%d", instr.instr, instr.arg[0], instr.arg[1]);
	}
	else {
	printf("???? (Instruction %s inconnue)", instr.instr);
	}

	
}

void ecritT_Instr() {
	FILE *file = fopen("assembleur.s","w+");
	for(int k = 0; k < idx2; k++){															
		ecritInstr(ti[k], file);
		fprintf(file, "\n");
	}
	fclose(file);
}


/*
void main() {
	

}
*/
