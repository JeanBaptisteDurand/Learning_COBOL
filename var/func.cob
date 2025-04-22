      INSPECT {chaine}
         [TALLYING {compteur1} FOR {ALL | LEADING} {caractère1}
                                   [BEFORE | AFTER [INITIAL] {caractère2}] ]
         [REPLACING [ALL | LEADING] {caractère1} BY {caractère2}
                    [BEFORE | AFTER [INITIAL] {caractère3}] ]
      
      * INSPECT : Analyse ou modifie une chaîne.
      * TALLYING : Compte le nombre de fois qu’un caractère apparaît.
      * FOR ALL : Compte toutes les occurrences du caractère.
      * FOR LEADING : Compte seulement les occurrences en début de chaîne.
      * BEFORE : Ne traite que la partie avant le caractère spécifié.
      * AFTER : Ne traite que la partie après le caractère spécifié.
      * INITIAL : Applique BEFORE ou AFTER uniquement à la première occurrence du séparateur.
      * REPLACING : Remplace un caractère par un autre.
      * BY : Spécifie le caractère de remplacement.
      
      
      STRING {expr1} [DELIMITED BY {SPACE | SIZE | "valeur"}]
             {expr2} [DELIMITED BY ...]
         INTO {chaine-cible}
         [WITH POINTER pointeur]
         [ON OVERFLOW traitement-debordement]
         [NOT ON OVERFLOW traitement-normal]
      
      * STRING : Concatène des chaînes dans une seule cible.
      * DELIMITED BY : Définit la fin de la portion à concaténer.
        - SPACE : s’arrête au premier espace.
        - SIZE : prend toute la chaîne.
      * INTO : Variable dans laquelle stocker le résultat final.
      * WITH POINTER : Position dans la chaîne cible où commencer à écrire.
      * ON OVERFLOW : S’exécute si la chaîne cible est trop petite.
      * NOT ON OVERFLOW : S’exécute si tout s’est bien passé.
      
      
      UNSTRING {source}
         DELIMITED BY {chaîne | ALL chaîne | SIZE}
         INTO {dest1} [WITH POINTER pointeur1] [TALLYING compteur1],
              {dest2} ...
         [ON OVERFLOW traitement-debordement]
         [NOT ON OVERFLOW traitement-normal]
      
      * UNSTRING : Découpe une chaîne en plusieurs morceaux.
      * DELIMITED BY : Définit le séparateur entre les morceaux.
        - ALL : Considère toutes les occurrences du séparateur.
        - SIZE : Chaque destination reçoit toute la chaîne (utile en 1 seul champ).
      * INTO : Liste des variables où placer les morceaux.
      * WITH POINTER : Gère la position actuelle de lecture dans la source.
      * TALLYING : Stocke le nombre de caractères extraits.
      * ON OVERFLOW : S’exécute si les champs de destination sont insuffisants.
      * NOT ON OVERFLOW : S’exécute si tout s’est bien passé.
      

      EVALUATE var1 ALSO var2
         WHEN "A" ALSO "B"
            DISPLAY "Cas A/B"
         WHEN "C" ALSO "D"
            DISPLAY "Cas C/D"
         WHEN OTHER
            DISPLAY "Cas par défaut"
      END-EVALUATE

      * ALSO but with dynamic var
      EVALUATE TRUE ALSO var2
         WHEN var1 = "A" ALSO "B"
            DISPLAY "var1 est A et var2 est B"
      END-EVALUATE


      ADD {valeur1} [valeur2 ...]
          TO {variable1} [variable2 ...]
          [ROUNDED]
          [ON SIZE ERROR traitement]
          [NOT ON SIZE ERROR traitement]
      
      * ADD : Ajoute une ou plusieurs valeurs à une ou plusieurs variables.
      * TO : Cible(s) dans lesquelles les résultats seront ajoutés.
      * ROUNDED : Arrondit le résultat selon la précision définie dans la clause PICTURE.
      * ON SIZE ERROR : Bloc exécuté si dépassement de capacité (overflow).
      * NOT ON SIZE ERROR : Bloc exécuté si l'opération réussit normalement.


      SUBTRACT {valeur1} [valeur2 ...]
          FROM {variable1} [variable2 ...]
          [ROUNDED]
          [ON SIZE ERROR traitement]
          [NOT ON SIZE ERROR traitement]
      
      * SUBTRACT : Soustrait une ou plusieurs valeurs de une ou plusieurs variables.
      * FROM : Définit les variables de destination qui seront soustraites.
      * ROUNDED, ON SIZE ERROR, NOT ON SIZE ERROR : mêmes effets que pour ADD.


      MULTIPLY {valeur1}
          BY {variable1} [variable2 ...]
          [ROUNDED]
          [ON SIZE ERROR traitement]
          [NOT ON SIZE ERROR traitement]
      
      * MULTIPLY : Multiplie la valeur par les variables cibles.
      * BY : Spécifie les variables à multiplier.
      * ROUNDED, ON SIZE ERROR, NOT ON SIZE ERROR : identiques aux autres opérations.


      DIVIDE {valeur1}
          INTO {variable1} [GIVING result1 [result2 ...]]
          [REMAINDER reste]
          [ROUNDED]
          [ON SIZE ERROR traitement]
          [NOT ON SIZE ERROR traitement]
      
      * DIVIDE ... INTO : Divise la valeur dans les variables cibles.
      * GIVING : Stocke le résultat dans des variables distinctes (au lieu d’écraser INTO).
      * REMAINDER : Stocke le reste de la division entière.
      * ROUNDED, ON SIZE ERROR, NOT ON SIZE ERROR : mêmes effets que précédemment.



