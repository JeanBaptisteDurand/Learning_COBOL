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
REPLACE limiter (Cette instruction permettant de remplacer des variables symboliques par une valeur donnée ne doit être utilisée que pour traiter le nombre de postes d’un tableau ), il ne faut en utiliser que UNE car une deuxieme supprime la premiere, cela comprend aussi les COPY, un seul REPLACE dans TOUT le programme
COPY REPLACING limiter (Cette instruction permettant de remplacer des variables symboliques par une valeur donnée dans une COPY ne doit être utilisée en DATA DIVISION que pour préfixer les données d’une structure, et surtout pas pour traiter le nombre de postes d’un tableau)
EXTERNAL interdit (permet de share une var entre programmes sans quelle soit def dans les 2)


etiquette intermediaire interdit (etiquette au milieu dun paragraphe)
Le paragraphe suivant l’étiquette de fin ne devra comporter qu’une seule instruction : EXIT.
Un paragraphe doit toujours être codé dans le programme après son appel par un PERFORM.
Les paragraphe sont ecrit dans lordre dexecution, si plusieurs para appelle un autre, celui appeler sera ecrit apres tout les appelant
Les etiquettes doivent commencer par un nb a 4 chiffre puis une courte description a linfinitif, 9999 ou 999 est pour la fin, 9xxx est pour la gestion des erreurs fonctionnel et technique
Il faut un '.' a la fin de letiquette
UN SEUL POINT PAR PARAGRAPHE (cela force les les END-xxxx)
Pour des programmes de la couche de Pilotage du Processus (PPI), etiquette sont ?A100, ? etant C pour para de controle des donnees en entree du service, T pour para de traitement
un programme fait 3000 lignes max, 3300 pour vieux programme
paragrpahe fait 250 lignes max
PERFORM UNTIL fait 20 lignes max

/ Special /
Complexite cyclomatique McCabe calcul le nombre de chemin fonctionnel des composant (complexite de maintenance) (via loutil Mia) et cette valeur ne doit pas depasser 200 ou 220 pour de vieux programme
Limiter les call vers les autres programmes dans un composant pour simplifier maintenance (max 15 mais variable)
Mutualiser les composants, un programme doit avoir entre 10% et 15% de code fortement mutualiser
WITH DEBUGGING MODE coder dans ENVIRONMENT DIVISION doit etre commenter avant mise en prod



** Performance et fiabiliter **
PROGRAM-ID doit etre indentique au nom du programme (dans IDENTIFICATION DIVISION)
DISPLAY dans les TP interdit sauf avec un D ligne 7, en batch DISPLAY est autoriser pour le traitement des erreurs grace et aux comptes rendu de fin de traitement
SORT est interdit car consomme trop, le tri se fait via jcl dans un step reserver
SEARCH permet de chercher rapidement dans un tableau via un incide, il faut que le tableau soit def par INDEXED BY

Les indices pour les tableaux ou boucle doivent etre : PIC S9(4) BINARY
Les var intermediaire pour les calculs doivent etre en PACKED-DECIMAL
Valeur max dun indice, pour CHAQUE tableau, creer une var qui commence par C-MAX-(array name) et sera utiliser pour bloquer literation au dela du tableau

Pour les dates : Les opérations sur les dates devront systématiquement passer par les modules de calcul standardisés propre à l’application (exemple : RGNDATE).

les appel CALL doivent toujours etre en dynamique et non inclus dans lexecutable au moment du LINKEDIT
CALL doit etre utiliser avec une var obligatoirement, declarer en WORKING STORAGE SECTION en PIC X(8) VALUE 'program name'
exemple : 01  P-RAVCHOSE   PIC X(8) VALUE 'RAVCHOSE'.
            CALL P-RAVCHOSE USING ... 
Le nom du programme doit etre en clair grace a value, jamais le resultat dun calcul ou de la lecture dune table de parametrage
(voir 4.11) Après chaque appel à un module externe, le code retour du module doit non seulement être testé, mais remonté au module de niveau supérieur en cas d’anomalie grave. Faire les test via EVALUATE

 Definir un file statut pour chaque fichier sequentiel 'dsname-STATUS' ou dsname est le nom du fichier sous JCL et doit etre def en WSS en PIC X(2), apres chaque read write open close, il doit etre tester
si FILE STATUS different de 0 et 10, msg danomalie avec arret immediat du traitement

Obligation dutiliser INITIALIZE plutot que de loop sur un tableau pour linitialiser, beaucoup plus performant (na pas toujours etait le cas)


** Norme DB2 **

Hosts Variables en WORKING STORAGE SECTION, interdit en LINKAGE SECTION
Check SQLCODE apres chaque ordres SQL tel quil soit (meme commit et rollback)
Interdiction de coder un INSERT à l’intérieur d’une boucle FETCH 
Le SELECT * est interdit : les colonnes utiles à la sélection doivent être citées dans l’ordre SQL.  
Le SELECT FOR UPDATE est proscrit car il verrouille les données, ce qui est incompatible avec un fonctionnement en 24/7.
Les doublons sont automatiquement supprimés avec l’ordre UNION ALL, cette option peut être couteuse en CPU. 


** Facilité de maintenance et assistance au débogage  **


Ajout de FILLER de repères en DATA DIVISION pour faciliter de retrouver la DATA DIVISION dans le dump, a faire surtout pour les batch
```
DATA DIVISION. 
WORKING-STORAGE SECTION.  

01  FILLER   PIC X(15) VALUE '*** DEB WSS ***'.   

... 

01  FILLER   PIC X(8) VALUE 'POL-NO ='. 

01  W-POL-NO PIC S9(15) PACKED-DECIMAL. 

... 

01  FILLER   PIC X(15) VALUE '*** FIN WSS ***'.   

LINKAGE SECTION.   

...  
```

Pour les batch, faire regulierement un affichage du niveau davancement du traitement comme DISPLAY le numéro du dernier contrat traité (debug en cas de crash plus simple)
En Batch su fin anormale, DISPLAY Nom du programme / Nom du paragraphe dans le programme / Informations techniques (code SQL, table, STATUS des fichiers séquentiels) / Numéro du dernier contrat traité  / Compteurs des enregistrements traités 

Preparation du DEBUGGING MODE :
- Chaque début de paragraphe doit être tracé par un DISPLAY avec D (column 7) avec obligatoirement le nom du programme et le nom du paragraphe en cours d’exécution

```
*---------------------------------------------------------------  

* Pour le mode debugging : affichage du nom du programme          

* et du paragraphe (DEBUG-NAME)                                 

*---------------------------------------------------------------  

D DECLARATIVES.                                                   

D TRACE-COB SECTION.                                             

D     USE FOR DEBUGGING ON ALL PROCEDURES.                        

D TRACE-COB-NAME.                                                

AutoShape 24, FormeD     DISPLAY C-xxxxxxxx ' : ' DEBUG-NAME                         

Zone de texte 2, Zone de texteD END DECLARATIVES. 
```
Ce code évite d’avoir à répéter à chaque début de paragraphe le DISPLAY suivant équivalent (exemple) : 
```
 TB105-RECUPERER-INFOS-CONTRAT.               

D    DISPLAY 'RAVPIC00 - TB105-RECUPERER-INFOS-CONTRAT'
```

Précision : en TP, ces DISPLAY apparaissent dans la SYSOUT CEEMSG du CICS. En batch, pour que les DISPLAY générés par la TRACE-COB SECTION apparaissent, il faut rajouter en PARMS « /DEBUG » : 
```
//SYSTSIN DD *                                          

   DSN SYSTEM(DBD3)                                     

   RUN PROGRAM(BAVCSF09) PLAN(PBDE0) -                  

       PARMS('/DEBUG')    
```






** Cobol Metaware (bonus) **
Les variables travail doivent être définies dans le niveau 01 adéquat (si non respect, le contenu de la variable de travail est susceptible d’être perdu)
Ne pas utiliser les variables techniques du Framework comme PRIOR--PGM-NAME
Les appels de programmes Cobol non-Metaware doivent respecter une syntaxe très particulière sinon tout casse:
A savoir (modèle d’appel pour le RAVW276) :  
```
CALL SP--N2CCALL USING SP--RVSNATTP P-RAVW276  

                K--SERVICE OF R--AVW276L  

                NB-GAR OF R--AVW276Z           

                AVI002-NB-POSTES OF R--LAVI002                          

                K--CODE OF R--LAVI001 OMITTED 
```

