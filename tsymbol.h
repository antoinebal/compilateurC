#include <stdio.h>

typedef struct ligne ligne;
struct ligne {
  int *type;
  char *id;
  int valeurConstante;
  int profondeur;
  int adresseMemoire;
};
void ajouterLigneTS(char* type, char* id, int valConst);
int ajouterLigneTmpTS();
int getAdresseTS(int i);
int getIndexTS(char *idVar);
void popTS();
void imprimerLigne(ligne l);
void imprimerTS();
int getIndexCourantTS();
void monter();
void descendre();

