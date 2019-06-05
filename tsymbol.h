#include <stdio.h>

//élément constituant la table
typedef struct ligne ligne;
struct ligne {
  char *type;
  char *id;
  int valeurConstante;
  int profondeur;
  int adresseMemoire;
};

//appelée lors d'une déclaration de variable
void ajouterLigneTS(char* type, char* id, int valConst);

//ajouter une ligne temporaire
int ajouterLigneTmpTS();

//récupérer l'adresse à l'index i de la table
int getAdresseTS(int i);

//récupérer l'index de la variable d'id idVar dans la table
int getIndexTS(char *idVar);

//supprimer la dernière entrée de la table
void popTS();

void imprimerLigne(ligne l);

void imprimerTS();

int getIndexCourantTS();

int getIndexDerniereEntreeTS();

//appelée quand on monte dans la hiérarchie des scopes
void monter();

//appelée quand on descend dans la hiérarchie des scopes
void descendre();

