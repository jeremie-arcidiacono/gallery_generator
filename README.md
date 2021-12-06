Bienvenue dans le message d'aide du programme

Avant de commencer, soyez sur que le package "ImageMagick" est installer sur votre machine.
Vous pouvez vérifiez cela avec la commande 'dpkg -s imagemagick'
Si vous ne l'avez pas vous devez le télécharger avec cette commande : 'sudo apt install imagemagick'
Vous pouvez également le trouver a cette addresse : https://imagemagick.org/script/download.php


Ce programme sert a dupliquer des images en changeant leur taille.
Vous pourrez consulter les images apres l'execution du programme dans un dossier ou via un page web.
Seul certaine type d'images sont supporter, voici la liste :
   - jpg 
   - png
   - gif
   - jpeg

Pour démarrer le script, taper dans votre terminal './galerie.sh'
Pour afficher l'aide (ce que vous voyez actuellement), taper dans votre terminal './galerie.sh --help'

L'application vous demandera diverse informations:
Si vous voulez la valeurs par defaut, appuyer seulement sur ENTER sans répondre à la question

  1. Le dossier des images originales
     Par defaut : 'img'
     Vous devrez donner le nom exacte du dossier et il doit contenir des images à un format valide (voir ci-dessus)
     Apres execution du programme, le dossier et son contenu seront intactes

  2. Le dossier où seront stockées la copie des images (une fois qu'elles sont à la taille demander)
     Par defaut : 'minia'
     Vous devrez donner le nom exacte du dossier
     Le programme est capable de le créez si il n'existe pas encore
     Apres execution du programme, si vous enlevez les images de ce fichier, elles n'apparaitront plus dans la page web

  3. La largeur a laquelle les images seront copiées
     Par defaut : '300'
     Vous devrez donner une valeur numérique en pixel
     Si ce que vous entrer n'est pas valide, l'application appliquera la valeur par defaut

  4. La hauteur a laquelle les images seront copiées
     Par defaut : '300'
     Vous devrez donner une valeur numérique en pixel
     Si ce que vous entrer n'est pas valide, l'application appliquera la valeur par defaut

  5. Le fichier de la page web
     Par defaut : 'index'
     Vous devrez donner le nom du fichier
     Le programme est capable de le créez si il n'existe pas encore

  6. Activation du style (css) pour la page web
     Par defaut : 'oui'
     Vous devrez répondre par 'oui' ou 'non'
     Nombre de caractère max : 3

Pour les question 1, 2 et 5 : l'application ne travaille pas avec les espaces. Il est donc inutile d'en mettre car ils seront supprimer

Le traitement peut durer plus ou moins longtemps. Cela dépend du nombre de photo a transformer et de la puissance de votre machine. Durant ce temps le programme affichera un message pour vous faire attendre

Apres le traitement, l'application vous résume se qu'elle a fait et les données que vous lui avez fournit precedament


Utilisation avancé :
   Vous pouvez facilement modifier la base du html ou du css en modifiant les templates


Info général
   Auteur :            Arcidiacono Jérémie
   Durée de dev :      octobre 2020 - janvier 2021
   Version :           V2.5
   Dernière maj :      26 janvier 2021
   Statut :            Officiel Stable


Pour toutes questions supplémentaires contactez cette adresse : jeremie.arcdc@eduge.ch