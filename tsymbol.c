#include <stdio.h>
#include <string.h>

typedef struct ligne ligne;
struct ligne {
  char *type;
  char *id;// = malloc (sizeof(*id)*20);
  int valeurConstante;
  int profondeur;
  int adresseMemoire;
};
  

ligne ts[1024]; 


int idx=0;

int adresseMemCourante= 400;

int profondeur=0;

void descendre() {
	prodondeur++;
}

void monter() {
	//on descend l'index tant que l'entrée correspond à la prof actuelle
	while(ts[idx].profondeur==profondeur) {
		idx--;
	}	

	//on màj la profondeur
	profondeur--;
}


void ajouterLigne(char* type, char* id, int valConst) {
	//AJOUTER LES TESTS
  	ts[idx].type= type;
	ts[idx].id= id;
 	ts[idx].valeurConstante=valConst;
  	ts[idx].profondeur=prof;
  	ts[idx].adresseMemoire=adresseMemCourante;

  idx++;

	adresseMemCourante++;

	//il faut incrémenter l'adresse mémoire en fonction du type
  /*if (*type == "char") {
		//un char pèse 1 octet
		adresseMemCourante++;
	} else if (*type == "int") {
		//un int pèse 2 octets
		adresseMemCourante+=2;
	}*/
}

//peut être rajouter type + tard en argument
int ajouterLigneTmp() {
	//AJOUTER LES TESTS
	ts[idx].adresseMemoire=adresseMemCourante;
	idx++;
	adresseMemCourante++;
	return idx-1;	
}


int getAdresse(int i) {
	return ts[i].adresseMemoire;
}

int getIndexCourant() {
	return idx;
}

int getIndex(char *idVar) {
	int i=0;
	while (i < idx) {
		if (strcmp(ts[i].id, idVar) == 0) {
			return i;
		}
		i++;
	}
	return-1;
}


void pop() {
	idx--;
}



void imprimerLigne(ligne l) {
	printf("TYPE : %s \n", l.type);
	printf("ID : %s \n", l.id);
	printf("VC? : %d \n", l.valeurConstante);
	printf("PROF : %d \n", l.profondeur);
	printf("@Mem : %d \n", l.adresseMemoire);
}

int imprimerTS() {
	for(int k = 0 ; k < idx ; k++) {
		imprimerLigne(ts[k]);
		printf("\n");
	}

}



void main() {
	ajouterLigne("int", "tchazos", 1);
	
	ajouterLigne("int", "tchazos", 1);
	ajouterLigne("int", "tchazos", 1);
	ajouterLigne("int", "tchazos", 1);
	ajouterLigneTmp();
	imprimerTS();

	

}
