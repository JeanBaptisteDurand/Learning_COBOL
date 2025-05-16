       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXEMPLE-VARIABLES.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      * Groupe (numero hierarchique max 49 sauf 66(useless) et 88).
       01  WS-USERS.
           05 WS-INFOS.
              10 WS-NAME        PIC A(20).
              10 WS-NICKNAME    PIC A(20).
           05 WS-DATE.
              10 WS-DAY         PIC 9(2).
      *    FILLER sert a reserver un endroit qui n'est pas une variable 
      *    dans lequel je peux mettre ce que je veux(ex completer octet)
              10 FILLER         PIC XX VALUE "("
      *          99 ou 9(2) identique.
                 15 WS-HOUR     PIC 99.
                 15 FILLER      PIC X VALUE "h".
                 15 WS-MINUTES  PIC 9(2).
              10 FILLER         PIC XX VALUE ")/"
              10 WS-MONTH       PIC 9(2).
              10 FILLER         PIC XX VALUE "/"
              10 WS-YEAR        PIC 9(2).
       
      *    le nivbeau 88 est un booleen. ici j'ai defini la plage d'age 
      *    pour les mineur de 0 a 18
       01  WS-AGE         PIC 9(2).
           88 WS-MINOR    VALUE 0 THRU 18.

      *    autre exemple ici avec si SEXE a la valeure H alors le bool 
      *    MALE sera sur TRUE. SINON on peut SET WS-MALE TO TRUE alors 
      *    WS-SEXE aura la valeure H.
       01  WS-SEXE        PIC A.
           88 WS-MALE     VALUE 'H'.
           88 WS-FEMALE   VALUE 'F'.

      *    deux variables elementaires dependantes peuvent avoir le meme
      *    nom et etre differencier dans la PROCEDURE DIVISION grace a
      *    OF ou IN (equivalent). ici NAME 2 fois     
       01  EMPLOYEE-RECORD.
           05  NAME          PIC X(20).
           05  ID            PIC 9(5).
       01  CUSTOMER-RECORD.
           05  NAME          PIC X(30).
           05  ADDRESS       PIC X(50).
       
      * entier signé (donnée 32 bits qui code un entier compris entre
      * -2147483648 et 2147483647)
       01 WS-SOLDE PIC S9(4).

      * decimal (ici ce sera 1234,56).
       01 WS-SALAIRE PIC 9(4)V9(2).

      * données numériques compactées (opti)
       01 WS-COMPACTE
      *    pour savoir le nombre d'octet prit : 
      *    COMP1 : (9+1)/2 = 5 octet au lieu des 9 avec var classique
           05 WS-COMP1 PIC 9(9)       USAGE COMP-3.
      *    COMP2 : (7+1)/2 = 4 octet au lieu de 7
           05 WS-COMP2 PIC 9(5)V99    COMP-3.
      *    COMP3 : (6+1)/2 = 3.5 -> 4 octet au lieu de 6
           05 WS-COMP3 PIC 9(4)V99    PACKED-DECIMAL.

      * données numériques binaire (stockage format binaire)
       01 WS-BINAIRE
           05 WS-COMP1 PIC 9(9)       USAGE IS COMP.
           05 WS-COMP2 PIC 9(5)V99    COMP.
           05 WS-COMP3 PIC 9(4)V99    BINARY.

       
      * REDEFINES sert a redefinir une variables sous une nouvelle forme
      * cela peut etre utile pour l'optimisation de vitesse et de place
      *1er exemple :
       01 WS-ALPHANUMERIQUE PIC X(10).
       01 WS-ENTIER REDEFINES WS-ALPHANUMERIQUE PIC 9(10).
      
      *second exemple :
       01 WS-BASE-DATE PIC X(8) VALUE "01122023".
       01 WS-REDEF-DATE REDEFINES WS-BASE-DATE.
           05 WS-REDEF-DAY   PIC 9(2).
           05 WS-REDEF-MONTH PIC 9(2).
           05 WS-REDEF-YEAR  PIC 9(4).
      * ca fonctionne ca REDEFINES reutilise la zone memoire de la
      * variable de base

      ******************************************************************
      * CARACTÈRES D'INSERTION : Symboles insérés dans les formats pour
      * structurer l'affichage (monnaie, séparateurs, etc.).
      ******************************************************************
       01  INSERTION-CHARS.
           05  INS-CURRENCY-SYM      PIC X(2) VALUE '€ '.
      * Résultat attendu : "€ " (symbole monétaire, ex. pour afficher "€ 123.45")
           05  INS-DECIMAL-POINT     PIC X(1) VALUE '.'.
      * Résultat attendu : "." (point décimal, ex. "123.45")
           05  INS-THOUSANDS-SEP     PIC X(1) VALUE ','.
      * Résultat attendu : "," (séparateur de milliers, ex. "1,234,567")
           05  INS-GROUPING-SEP      PIC X(1) VALUE ' '.
      * Résultat attendu : " " (espace comme séparateur, ex. "1 234 567")
           05  INS-PERCENT  PIC X(1) VALUE '%'.
      * Résultat attendu : "%" (pour afficher des pourcentages, ex. "50%")
           05  INS-SLASH             PIC X(1) VALUE '/'.
      * Résultat attendu : "/" (séparateur de date, ex. "19/04/2025")
           05  INS-COLON             PIC X(1) VALUE ':'.
      * Résultat attendu : ":" (séparateur d'heure, ex. "14:30:45")
           05  INS-QUOTE             PIC X(1) VALUE '"'.
      * Résultat attendu : """ (guillemet pour chaînes, ex. "COBOL")
           05  INS-APOSTROPHE        PIC X(1) VALUE "'".
      * Résultat attendu : "'" (apostrophe pour chaînes, ex. 'DATA')
           05  INS-PLUS              PIC X(1) VALUE '+'.
      * Résultat attendu : "+" (signe positif, ex. "+123.45")
           05  INS-MINUS             PIC X(1) VALUE '-'.
      * Résultat attendu : "-" (signe négatif, ex. "-123.45")
           05  INS-ASTERISK          PIC X(1) VALUE '*'.
      * Résultat attendu : "*" (protection chèque, ex. "***123.45")

      ******************************************************************
      * CARACTÈRES DE SUBSTITUTION : Valeurs prédéfinies pour initialiser
      * ou comparer (espaces, zéros, valeurs extrêmes).
      ******************************************************************
       01  SUBSTITUTION-CHARS.
           05  SUBS-SPACE            PIC X(1) VALUE SPACE.
      * Résultat attendu : " " (espace unique, pour initialiser ou effacer)
           05  SUBS-ZERO             PIC X(1) VALUE ZERO.
      * Résultat attendu : "0" (zéro, pour initialiser un champ numérique)
           05  SUBS-LOW-VALUE        PIC X(1) VALUE LOW-VALUE.
      * Résultat attendu : Caractère non imprimable (valeur binaire 00, pour comparaisons)
           05  SUBS-HIGH-VALUE       PIC X(1) VALUE HIGH-VALUE.
      * Résultat attendu : Caractère non imprimable (valeur binaire FF, pour comparaisons)
           05  SUBS-NULL             PIC X(1) VALUE NULL.
      * Résultat attendu : Caractère vide (pour initialiser à vide)
           05  SUBS-ALL-STARS        PIC X(5) VALUE ALL '*'.
      * Résultat attendu : "*****" (motif répété d'astérisques)
           05  SUBS-ALL-DASHES       PIC X(5) VALUE ALL '-'.
      * Résultat attendu : "-----" (motif répété de tirets)
           05  SUBS-ALL-NUM          PIC 9(5) VALUE ALL '9'.
      * Résultat attendu : "99999" (motif répété de chiffres 9)

      ******************************************************************
      * CARACTÈRES MIXTES : Formats combinant numérique, alphanumérique,
      * et motifs d'édition pour des cas variés (monnaie, dates, etc.).
      ******************************************************************
       01  MIXED-FORMATS.
           05  MIXED-NUM-RAW         PIC 9(6)V99 VALUE 123456.78.
      * Résultat attendu : "12345678" (numérique brut, sans formatage)
           05  MIXED-NUM-EDITED      PIC ZZZ,ZZZ.99 VALUE 123456.78.
      * Résultat attendu : "123,456.78" (formaté avec virgule et décimales)
           05  MIXED-NUM-SIGNED      PIC S9(6)V99 SIGN LEADING VALUE -123456.78.
      * Résultat attendu : "-12345678" (signe devant pour négatif)
           05  MIXED-CURRENCY        PIC $$,$$$,$$$.99 VALUE 9876543.21.
      * Résultat attendu : "$9,876,543.21" (format monétaire avec symbole)
           05  MIXED-PERCENT         PIC 99.99% VALUE 12.34.
      * Résultat attendu : "12.34%" (format pourcentage avec symbole)
           05  MIXED-DATE-ISO        PIC 9999/99/99 VALUE '2025/04/19'.
      * Résultat attendu : "2025/04/19" (format date ISO)
           05  MIXED-DATE-FR         PIC 99/99/9999 VALUE '19/04/2025'.
      * Résultat attendu : "19/04/2025" (format date français)
           05  MIXED-TIME            PIC 99:99:99 VALUE '14:30:45'.
      * Résultat attendu : "14:30:45" (format heure)
           05  MIXED-ALPHA           PIC X(15) VALUE 'COBOL PROGRAM  '.
      * Résultat attendu : "COBOL PROGRAM  " (texte avec espaces à droite)
           05  MIXED-EDITED-ALPHA    PIC A(10) VALUE 'COBOL    '.
      * Résultat attendu : "COBOL     " (texte justifié, seulement lettres)
           05  MIXED-MASKED          PIC XXBXXBXX VALUE 'AB CD EF'.
      * Résultat attendu : "AB CD EF" (format avec espaces prédéfinis)
           05  MIXED-CHECK-PROTECT   PIC ***,***.99 VALUE 123456.78.
      * Résultat attendu : "***,123.78" (protection chèque avec astérisques)

      ******************************************************************
      * TABLEAUX ET CARACTÈRES SPÉCIAUX : Gestion de collections
      * de caractères et conditions pour tests.
      ******************************************************************
       01  SPECIAL-CHARS-TABLE.
           05  WS-PERCENT        VALUE '%'.
           05  WS-HASH           VALUE '#'.
           05  WS-AT             VALUE '@'.
           05  WS-AMPERSAND      VALUE '&'.
           05  WS-ASTERISK       VALUE '*'.
           05  WS-EXCLAMATION    VALUE '!'.
           05  WS-QUESTION       VALUE '?'.
           05  WS-DOLLAR         VALUE '$'.
           05  WS-POUND          VALUE '£'.
           05  WS-EURO           VALUE '€'.

      ******************************************************************
      * CARACTÈRES DE CONTRÔLE : Caractères non imprimables pour
      * gestion technique (fichiers, terminaux, etc.).
      ******************************************************************
       01  CONTROL-CHARS.
           05  CTRL-TAB              PIC X(1) VALUE X"09".
      * Résultat attendu : Tabulation (déplace curseur, non visible)
           05  CTRL-NEWLINE          PIC X(1) VALUE X"0A".
      * Résultat attendu : Saut de ligne (nouvelle ligne, non visible)
           05  CTRL-CARRIAGE-RETURN  PIC X(1) VALUE X"0D".
      * Résultat attendu : Retour chariot (début de ligne, non visible)
           05  CTRL-BELL             PIC X(1) VALUE X"07".
      * Résultat attendu : Son de cloche (signal sonore, non visible)
           05  CTRL-ESCAPE           PIC X(1) VALUE X"1B".
      * Résultat attendu : Caractère d'échappement (pour séquences, non visible)

      ******************************************************************
      * ÉDITION AVANCÉE : Formats complexes pour rapports, affichages
      * ou besoins spécifiques.
      ******************************************************************
       01  ADVANCED-EDITING.
           05  EDIT-NUM-CR           PIC ZZZ,ZZZ.99CR VALUE 123456.78.
      * Résultat attendu : "123,456.78CR" (indicateur crédit si négatif)
           05  EDIT-NUM-DB           PIC ZZZ,ZZZ.99DB VALUE 123456.78.
      * Résultat attendu : "123,456.78DB" (indicateur débit si négatif)
           05  EDIT-NUM-PLUS         PIC +ZZZ,ZZZ.99 VALUE 123456.78.
      * Résultat attendu : "+123,456.78" (signe explicite positif)
           05  EDIT-NUM-MINUS        PIC -ZZZ,ZZZ.99 VALUE -123456.78.
      * Résultat attendu : "-123,456.78" (signe explicite négatif)
           05  EDIT-MIXED-CUSTOM     PIC $ZZZ,ZZZ.99BL VALUE 123456.78.
      * Résultat attendu : "$123,456.78 L" (format avec blank et lettre)



       PROCEDURE DIVISION.
      *    initialisation/reinitialisation valeur par defaut des
      *    variable a 0 pour les numeriques et espace pour les alpha et
      *    alphanumerique (ici init de toute les var WS-USERS)
           INITIALIZE WS-USERS.

      *    MOVE deplace la valeur vers une variable (equivalent = en C)
           MOVE 12 TO WS_HOUR.
           MOVE "Theo" TO WS-NAME.
      *    Remplir de zero une variable :
           MOVE ZERO TO WS-AGE.
      *    ici utiliser INITIALIZE ca reinitialiserait ces variables

