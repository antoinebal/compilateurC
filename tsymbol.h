#include <stdio.h>

typedef struct ligne ligne;
struct ligne {
  int *type;
  char *id;// = malloc (sizeof(*id)*20);
  int valeurConstante;
  int profondeur;
  int adresseMemoire;
};
void ajouterLigne(char* type, char* id, int valConst);
int ajouterLigneTmp();
int getAdresse(int i);
int getIndex(char *idVar);
void pop();
void imprimerLigne(ligne l);
void imprimerTS();
int getIndexCourant();
void monter();
void descendre();

