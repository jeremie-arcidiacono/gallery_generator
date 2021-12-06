Bienvenue dans le message d'aide du programme

Avant de commencer, soyez sûr que le package "ImageMagick" est installé sur votre machine.
Vous pouvez vérifier cela avec la commande 'dpkg -s imagemagick'
Si vous ne l'avez pas vous devez le télécharger avec cette commande : 'sudo apt install imagemagick'
Vous pouvez également le trouver a cette addresse : https://imagemagick.org/script/download.php


Ce programme sert à dupliquer des images en changeant leur taille.
Vous pourrez consulter les images après l'execution du programme dans un dossier ou via une page web.
Seul certains types d'images sont supporté, voici la liste :
   - jpg 
   - png
   - gif
   - jpeg

Pour démarrer le script, tapez dans votre terminal './galerie.sh'
Pour afficher l'aide (ce que vous voyez actuellement), tapez dans votre terminal './galerie.sh --help'

L'application vous demandera diverses informations:
Si vous voulez la valeur par defaut, appuyez seulement sur ENTER sans répondre à la question.

  1. Le dossier des images originales
     Par defaut : 'img'
     Vous devrez donner le nom exact du dossier et il doit contenir des images à un format valide (voir ci-dessus).
     Après execution du programme, le dossier et son contenu seront intactes.

  2. Le dossier où seront stockées la copie des images (une fois qu'elles sont à la taille demandée)
     Par defaut : 'minia'
     Vous devrez donner le nom exact du dossier.
     Le programme est capable de le créer s'il n'existe pas encore.
     Après execution du programme, si vous enlevez les images de ce fichier, elles n'apparaitront plus dans la page web.

  3. La largeur à laquelle les images seront copiées.
     Par defaut : '300'
     Vous devrez donner une valeur numérique en pixel.
     Si ce que vous entrez n'est pas valide, l'application appliquera la valeur par defaut.

  4. La hauteur à laquelle les images seront copiées.
     Par defaut : '300'
     Vous devrez donner une valeur numérique en pixel.
     Si ce que vous entrez n'est pas valide, l'application appliquera la valeur par defaut.

  5. Le fichier de la page web.
     Par defaut : 'index'
     Vous devrez donner le nom du fichier.
     Le programme est capable de le créer s'il n'existe pas encore.

  6. Activation du style (css) pour la page web.
     Par defaut : 'oui'
     Vous devrez répondre par 'oui' ou 'non'
     Nombre de caractères max : 3

Pour les question 1, 2 et 5 : l'application ne travaille pas avec les espaces. Il est donc inutile d'en mettre car ils seront supprimés

Le traitement peut durer plus ou moins longtemps. Cela dépend du nombre de photos à transformer et de la puissance de votre machine. Durant ce temps le programme affichera un message pour vous faire attendre.

Apres le traitement, l'application vous résume ce qu'elle à fait et les données que vous lui avez fournit précédemment.


Utilisation avancée :
   Vous pouvez facilement modifier la base du html ou du css en modifiant les templates.


Info général
   Auteur :            Arcidiacono Jérémie
   Durée de dev :      octobre 2020 - janvier 2021
   Version :           V2.5
   Dernière maj :      26 janvier 2021
   Statut :            Officiel Stable
