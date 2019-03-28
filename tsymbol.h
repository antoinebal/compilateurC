#include <stdio.h>

typedef struct ligne ligne;
struct ligne {
  int *type;
  char *id;// = malloc (sizeof(*id)*20);
  int valeurConstante;
  int profondeur;
  int adresseMemoire;
};

void ajouterLigne(char* type, char* id, int valConst, int prof);
int ajouterLigneTmp();
int getAdresse(int i);
int getIndex(char *idVar);
