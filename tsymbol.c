#include <stdio.h>
#include <string.h>
#include "tsymbol.h"

ligne ts[1024]; 

int idx=0;

int adresseMemCourante= 0;

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
	printf("On ajoute la ligne de %s \n", id); 
  	ts[idx].type= type;
	ts[idx].id= id;
 	ts[idx].valeurConstante=valConst;
  	ts[idx].profondeur=profondeur;
  	ts[idx].adresseMemoire=adresseMemCourante;
  	
	idx++;

	adresseMemCourante++;
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

int getIndexDerniereEntreeTS() {
	return idx-1;
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
	adresseMemCourante--;
}


void imprimerLigne(ligne l) {
	printf("TYPE : %s \n", l.type);
	printf("ID : %s \n", l.id);
	printf("VC? : %d \n", l.valeurConstante);
	printf("PROF : %d \n", l.profondeur);
	printf("@Mem : %d \n", l.adresseMemoire);
}

void imprimerTS() {
	printf("**TS**\n");
	for(int k = 0 ; k < idx ; k++) {
		imprimerLigne(ts[k]);
		printf("\n");
	}

}

/*
void main() {
	
	
}
*/
