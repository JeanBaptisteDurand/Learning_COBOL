** LISIBILITE **

ENVIRONMENT DIVISION / CONFIGURATION SECTION / SPECIAL-NAMES / DECIMAL-POINT IS COMMA
Nom de var W working str / L linkage / C constante (88 ou value fix) / P programme
BINARY > COMP
PACKED-DECIMAL > COMP-3

--------------
Les constantes (variables avec une clause VALUE) doivent être définies en niveau 01 en début de WORKING STORAGE SECTION.

Ensuite doivent être définies toutes les variables de travail du programme en niveau 02 ou plus, regroupées dans une seule structure appelée 01 W-WORKING. De la sorte il est possible d’initialiser toutes les variables de travail en début de PROCEDURE DIVISION en codant une seule instruction INITIALIZE W-WORKING.

Enfin doivent être codées les autres structures en niveau 01 qui peuvent être initialisées ou pas, entre autres :
-	Les définitions de fichier séquentiels 
-	Les définitions de zones de communication utilisées pour appeler d’autres programmes Cobol
-	Les variables servant à remplir des lignes d’édition ou des dates, utilisant en général des clauses VALUE et qui de ce fait ne doivent pas être initialisées.   
--------------

END for IF PERFROM EVALUATE et les avoir alignes , pas de END WRITE de preference (pas une boucle)

IF max 3 imbrication pour le reste 5 (par paragraphe)
simple IF EVALUATE condition
WHEN OTHER obligatoire dans EVALUATE

Pour EVALUATE mettre des niveaux 88, pas de condition en brut, le code doit se lire de lui meme

Ratio commentaire/code de 10%
interdit de commenter du code COBOL

Pas du COPY dans une COPY, imbrication max est de 2, derogation pour la couche acces au donnee (copy module de retour, copy table, copy les zones de communication des modules)
PAS de copy en procedure division, les declarer en data division, sinon le dev peut pas voir le code, sauf en couche Pilotage de Processus Interne (ALMA) et aux programmes COBOL Metaware, justement pour que le dev ne voit pas le code



** PROCEDURE DIVISION **

THRU interdit
GO TO interdit
NEXT SENTENCE interdit (car GO TO deguiser)
ALTER interdit (remplacement de code non maitriser par le dev)
REPLACE limiter (Cette instruction permettant de remplacer des variables symboliques par une valeur donnée ne doit être utilisée que pour traiter le nombre de postes d’un tableau )
COPY REPLACING limiter (Cette instruction permettant de remplacer des variables symboliques par une valeur donnée dans une COPY ne doit être utilisée en DATA DIVISION que pour préfixer les données d’une structure, et surtout pas pour traiter le nombre de postes d’un tableau)


etiquette intermediaire interdit (etiquette au milieu dun paragraphe)
Le paragraphe suivant l’étiquette de fin ne devra comporter qu’une seule instruction : EXIT.
Un paragraphe doit toujours être codé dans le programme après son appel par un PERFORM.
Les paragraphe sont ecrit dans lordre dexecution, si plusieurs para appelle un autre, celui appeler sera ecrit apres tout les appelant
Les etiquettes doivent commencer par un nb a 4 chiffre puis une courte description a linfinitif, 9999 ou 999 est pour la fin, 9xxx est pour la gestion des erreurs fonctionnel et technique
?? a verif - Il faut un '.' a la fin de letiquette
UN SEUL POINT PAR PARAGRAPHE + un point apres chaque END-xxxx
Pour des programmes de la couche de Pilotage du Processus (PPI), etiquette sont ?A100, ? etant C pour para de controle des donnees en entree du service, T pour para de traitement
un programme fait 3000 lignes max, 3300 pour vieux programme
paragrpahe fait 250 lignes max
PERFORM UNTIL fait 20 lignes max

/ Special /
Complexite cyclomatique McCabe calcul le nombre de chemin fonctionnel des composant (complexite de maintenance) (via loutil Mia) et cette valeur ne doit pas depasser 200 ou 220 pour de vieux programme
Limiter les call vers les autres programmes dans un composant pour simplifier maintenant
Mutualiser les composants, un programme doit avoir entre 10% et 15% de code fortement mutualiser

