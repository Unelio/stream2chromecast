#!/bin/bash
## Initialisation
DIR=`pwd`
FILE="$@"
EXT=`echo $FILE | sed 's/.*\.//g' | awk '{print tolower($0)}'`

## Fonction
z(){
  zenity --error --width="300" --title="Caster (Images, Musiques et Vidéos)" --text "$1"
}

c(){
  notify-send --icon=$HOME/.Python/stream2chromecast/chromecast.svg "Stream2Chromecast" "$1"
}

## On se place dans le répertoire d'installation
cd $HOME/.Python/stream2chromecast

## On teste qu'un chromecast est présent
NB=`./stream2chromecast.py -devicelist | grep "0 devices found"`
[ -n "$NB" ] && {
  z "Aucun chromecast n'a été trouvé sur le réseau."
  exit 1
}

## Si un chromecast est trouvé, on "streame" le média
if [ ! -d "$DIR"/"$@" ]
then
  case $EXT in
	  jpg|png|mp3)
       if [ $EXT = "mp3" ]; then
        c "Votre musique a été envoyé sur votre chromecast"
       else
        c "Votre image a été envoyé sur votre chromecast"
       fi
      ./stream2chromecast.py "$DIR"/"$@"
	  ;;
	  mp4|mkv)
      c "Votre vidéo a été envoyé sur votre chromecast"
      ./stream2chromecast.py -transcode "$DIR"/"$@"
	  ;;
	  *)
      z "Ce fichier ne peut pas être casté, veuillez en sélectionner un autre."
  esac
else
  z "Les dossiers ne peuvent pas être castés, veuillez sélectionner un fichier."
fi

exit 0
