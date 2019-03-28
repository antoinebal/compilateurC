#include <stdio.h>

typedef struct ligne ligne;
struct ligne {
  int *type;
  char *id;// = malloc (sizeof(*id)*20);
  int valeurConstante;
  int profondeur;
  int adresseMemoire;
};
  

ligne ts[1024]; 

int index=0;

int adresseMemCourante= 400;

void ajouterLigne(char* type, char* id, int valConst, int prof) {
	//AJOUTER LES TESTS
  strcopy(ts[index].type, type);
  strcopy(ts[index].id, id);
  ts[index].valeurConstante=valConst;
  ts[index].profondeur=prof;
  ts[index].adresseMemoire=adresseMemCourante;

  index++;

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
	ts[index].adresseMemoire=adresseMemCourante;
	index++;
	adresseMemCourante++;
	return index-1;	
}


int getAdresse(int i) {
	return ts[i].adresseMemoire;
}

int getIndex(char *idVar) {
	int i=0;
	while (i < index) {
		if (strcmp(ts[i].id, idVar) == 0) {
			return i;
		}
		i++;
	}
	return -1;
}
