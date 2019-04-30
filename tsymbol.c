#include <stdio.h>
#include <string.h>
#include "tsymbol.h"

ligne ts[1024]; 

int idx=0;

int adresseMemCourante= 400;

int profondeur=0;

void descendre() {
	profondeur++;
}

void monter() {
	//on descend l'index tant que l'entrée correspond à la prof actuelle
	while(ts[idx].profondeur==profondeur) {
		idx--;
	}	

	//on màj la profondeur
	profondeur--;
}


void ajouterLigneTS(char* type, char* id, int valConst) {
	//AJOUTER LES TESTS
  	ts[idx].type= type;
	ts[idx].id= id;
 	ts[idx].valeurConstante=valConst;
  	ts[idx].profondeur=profondeur;
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
int ajouterLigneTmpTS() {
	//AJOUTER LES TESTS
	ts[idx].adresseMemoire=adresseMemCourante;
	idx++;
	adresseMemCourante++;
	return idx-1;	
}


int getAdresseTS(int i) {
	return ts[i].adresseMemoire;
}

int getIndexCourantTS() {
	return idx;
}

int getIndexTS(char *idVar) {
	int i=0;
	while (i < idx) {
		if (strcmp(ts[i].id, idVar) == 0) {
			return i;
		}
		i++;
	}
	printf("L'id %s est inconnu \n", idVar);
	return-1;
}


void popTS() {
	idx--;
}


void imprimerLigne(ligne l) {
	printf("TYPE : %s \n", l.type);
	printf("ID : %s \n", l.id);
	printf("VC? : %d \n", l.valeurConstante);
	printf("PROF : %d \n", l.profondeur);
	printf("@Mem : %d \n", l.adresseMemoire);
}

void imprimerTS() {
	for(int k = 0 ; k < idx ; k++) {
		imprimerLigne(ts[k]);
		printf("\n");
	}

}

/*
void main() {
	ajouterLigne("int", "tchazos", 1);
	
	ajouterLigne("int", "tchazos", 1);
	ajouterLigne("int", "tchazos", 1);
	ajouterLigne("int", "tchazos", 1);
	ajouterLigneTmp();
	imprimerTS();

	

}
*/
