#!/bin/bash
# Auteur      : Arcidiacono Jérérmie (CFPT Genève)
# Classe      : I.DA P2A
# Date        : octobre 2020 - janvier 2021
# Cours       : Atelier Infra
# Description : Créer un fichier html contenant des images redimensionnées
# Version     : V2.5
# Travail noté

clear
shopt -s -o nounset

declare SOURCE_DIR
declare CIBLE_DIR
declare HTML_FILE_NAME
declare IMG_WIDTH
declare IMG_HEIGHT
declare NEED_CSS
declare DATE_NOW=`date '+%d.%m.%Y %H:%M'` 


# Vérifie si l'utilisateur a demandé de l'aide
checkHelpRequest(){
    local NB_PARAM=$1
    # On ne prend pas seulement en compte le "--help"
    # L'aide est envoyé si il y a quelque chose en parametre (car de toute facon s'il y a un param c'est que l'utilisateur n'a pas compris comment marche l'appli)
    if [[ $NB_PARAM -gt 0 ]]
    then 
        echo "$(cat README.md)" # Affiche le message d'aide 
        exit 0
    fi
}


# 1. Demande a l'utilisateur les infos relative à l'exectution du programme
# 2. Vérification de l'intégrité des infos
# 3. Gestion des erreurs et rectifiaction si celle ci sont corrigible.
getMenuInput(){
    local NB_IMG_CIBLE_DIR
    echo "-- Bienvenue dans le générateur de miniatures et html --"
    echo
    echo "   Pour obtenir de l'aide démarrer le programme avec './galerie.sh --help'"
    echo
    read -p "   Source des images (par default: img) : " SOURCE_DIR
    read -p "   Destination des miniatures (par default: minia) : " CIBLE_DIR
    read -p "   Largeur des images (par default: 300) : " IMG_WIDTH
    read -p "   Hauteur des images (par default: 300) : " IMG_HEIGHT
    read -p "   Nom du fichier HTML à créer (par default: index) : " HTML_FILE_NAME
    read -n 3 -p "   Voulez vous du style ? oui/non (par default: oui) : " NEED_CSS # -n : nombre de caratère max
    echo 

    # Suppression de tous les espaces
    IMG_WIDTH=${IMG_WIDTH//[[:space:]]/}
    IMG_HEIGHT=${IMG_HEIGHT//[[:space:]]/}
    NEED_CSS=${NEED_CSS//[[:space:]]/}
    

    if [ -z "$SOURCE_DIR" ]; then # true si utilisateur ne donne rien -> demande la valeur par default
        SOURCE_DIR="img" # valeur par defaut
    fi
    if [ ! -d "$SOURCE_DIR" ]; then
        # Si le dossier n'existe pas, on stop le script
        echo "Invalid input : Directory '$SOURCE_DIR': No such directory"
        exit 1
    fi
    NB_IMG_CIBLE_DIR=`ls -A "$SOURCE_DIR"/*.{jpg,png,gif,jpeg} 2>/dev/null | tr -d " " | wc -w`
    if [ $NB_IMG_CIBLE_DIR -lt 1 ]; then
        echo "Invalid input : Directory '$SOURCE_DIR' is empty or don't have valid image ('--help' to see valid type)"
    fi


    if [ -z "$CIBLE_DIR" ]; then
        CIBLE_DIR="minia" # valeur par defaut
    fi
    if [ ! -d "$CIBLE_DIR" ]; then
        # Si le dossier n'existe pas, on le créer
        mkdir "$CIBLE_DIR"
    fi

    local INT_REGEX='^[0-9]+([.][0-9]+)?$'
    if ! [[ $IMG_WIDTH =~ $INT_REGEX ]]; then # double [] car utilisation de regex
        # Si l'utilisateur ne donne rien ou autre chose que des chiffres
        IMG_WIDTH="300" # valeur par defaut
    fi
    if ! [[ $IMG_HEIGHT =~ $INT_REGEX ]]; then
        IMG_HEIGHT="300"
    fi


    if [ -z "$HTML_FILE_NAME" ]; then
        HTML_FILE_NAME="index" # valeur par defaut
    fi
    if [[ "$HTML_FILE_NAME" == *".html"* ]]; then
        # l'utilisateur a donné ".html" dans le nom du fichier
        # on supprime l'extension pour éviter que l'application la rajoute alors quel y étais déja
        HTML_FILE_NAME=${HTML_FILE_NAME".html"}
    fi
    HTML_FILE_NAME="$HTML_FILE_NAME.html"
    if [ -f "$HTML_FILE_NAME" ]; then
        # Si le fichier existe, on le supprime
        rm -f "$HTML_FILE_NAME"
    fi
    touch "$HTML_FILE_NAME"


    if [ -z $NEED_CSS ]; then
        NEED_CSS="oui"
    fi
}


createResizedImg(){
    for FILE in "$SOURCE_DIR"/*.{jpg,png,gif,jpeg}
    do
        # converti seulement si le fichier existe
        if [ -e "$FILE" ]
        then
            FILE=${FILE#"$SOURCE_DIR/"} # FILE étais "img/nom_fichier.jpg" et devient "nom_fichier.jpg"
            convert "$SOURCE_DIR/$FILE" -resize ${IMG_WIDTH}x${IMG_HEIGHT}! "$CIBLE_DIR/$FILE"
        fi
    done
}


#PARAM1 : nom du fichier de la template
#PARAM2 : contenu du fichier a modifier
#PARAM3 : element a remplacer
#PARAM4 : element qui va etre placé dans le fichier
findAndRemplaceInTemplate(){
    local TEMPLATE=$2
    for I in $(grep $3 < $1 | wc -l)
    do 
        TEMPLATE=${TEMPLATE/"$3"/"$4"}
    done
    echo "$TEMPLATE"
}

# Prend la template du css puis la duplique en ayant remplacer les valeurs dynamique
createCssFile(){
    local CSS_TEMPLATE=$(cat template/style1Template.css)

    CSS_TEMPLATE=$(findAndRemplaceInTemplate "template/style1Template.css" "$CSS_TEMPLATE" "[REPLACE_IMG_WIDTH]" "$IMG_WIDTH") #Utilisation d'une func ici
    CSS_TEMPLATE=$(findAndRemplaceInTemplate "template/style1Template.css" "$CSS_TEMPLATE" "[REPLACE_IMG_HEIGHT]" "$IMG_HEIGHT")

    $(echo ${CSS_TEMPLATE} > style1.css)
}


createHtmlFile(){
    local HTML_TEXT_TO_ADD_IMG=""
    local HTML_TEXT_TO_ADD_CSS=""
    local HTML_TEMPLATE=$(cat template/indexTemplate.html)
    local NB_TOUR=1

    # Genere le code HTML qui affiche les images
    for FILE in "$CIBLE_DIR"/*.{jpg,png,gif,jpeg}
    do
        if [ -e "$FILE" ]
        then
            FILE=${FILE#"$CIBLE_DIR/"} # FILE étais "minia/nom_fichier.jpg" et devient "nom_fichier.jpg"
            HTML_TEXT_TO_ADD_IMG="$HTML_TEXT_TO_ADD_IMG<figure class=\"figure\" id=\"img_$NB_TOUR\"><a href=\"$SOURCE_DIR/$FILE\"><img src=\"$CIBLE_DIR/$FILE\" class=\"figure-img img-fluid rounded\" alt=\"$FILE\"></a><figcaption class=\"figure-caption\">$FILE</figcaption></figure>"
            let "NB_TOUR=NB_TOUR+1"
            fi
    done
    let "NB_TOUR=NB_TOUR-1" # Il y a en a 1 de trop apres le if

    # Genere le code HTML qui ajoute du CSS
    if [ "$NEED_CSS" = "oui" ]
    then
        HTML_TEXT_TO_ADD_CSS="<link rel=\"stylesheet\" href=\"style1.css\"><link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css\" integrity=\"sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2\" crossorigin=\"anonymous\">
        <script src=\"https://code.jquery.com/jquery-3.5.1.slim.min.js\" integrity=\"sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj\" crossorigin=\"anonymous\"></script>
        <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js\" integrity=\"sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx\" crossorigin=\"anonymous\"></script>"
        createCssFile
    else
        HTML_TEXT_TO_ADD_CSS=""
    fi

    HTML_TEMPLATE=${HTML_TEMPLATE/"[REPLACE_IMG]"/$HTML_TEXT_TO_ADD_IMG}
    HTML_TEMPLATE=${HTML_TEMPLATE/"[REPLACE_CSS]"/$HTML_TEXT_TO_ADD_CSS}

    # Integrer les infos qui vont etre afficher sur le HTML
    HTML_TEMPLATE=${HTML_TEMPLATE/"[REPLACE_INFO_NAME]"/"$HTML_FILE_NAME"}
    HTML_TEMPLATE=${HTML_TEMPLATE/"[REPLACE_INFO_DATE]"/$DATE_NOW}
    HTML_TEMPLATE=${HTML_TEMPLATE/"[REPLACE_INFO_NB]"/$NB_TOUR}
    HTML_TEMPLATE=${HTML_TEMPLATE/"[REPLACE_INFO_SIZE]"/"${IMG_WIDTH}x${IMG_HEIGHT}"}

    $(echo ${HTML_TEMPLATE} > "$HTML_FILE_NAME")
}


# Affiche le résumé a la fin
# Seulement si tous s'est bien passé
displayEndMessage(){
    clear
    echo "-- Programme terminé avec succes --"
    echo
    echo "   Retrouvez les miniatures dans le dossier '$CIBLE_DIR' ou dans le page '$HTML_FILE_NAME'"
    echo
    echo "   Largeur des images : $IMG_WIDTH"
    echo "   Hauteur des images : $IMG_HEIGHT"
    NEED_CSS="$(tr '[:lower:]' '[:upper:]' <<< ${NEED_CSS:0:1})${NEED_CSS:1}" # Selectionne le premier char et le met en maj(seulement si il ne l'es pas); puis rajoute le reste du string
    echo "   Contient du css : $NEED_CSS"
    echo
    echo "   Pour obtenir de l'aide démarrer le programme avec './galerie.sh --help'"
    echo 
}



checkHelpRequest $#
getMenuInput
echo "   Traitement en cours... Attendez svp..."
createResizedImg
createHtmlFile
displayEndMessage


unset SOURCE_DIR
unset CIBLE_DIR
unset HTML_FILE_NAME
unset IMG_WIDTH
unset IMG_HEIGHT
unset NEED_CSS
unset DATE_NOW

exit 0
