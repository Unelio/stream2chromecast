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

## Le format du fichier est-il pris en charge ?
if [ ! -d "$DIR"/"$@" ]
then
  if [[ $EXT != "mp3" && $EXT != "jpg" && $EXT != "png"  && $EXT != "mp4"  && $EXT != "mkv" ]]
  then
      z "Ce fichier ne peut pas être casté, veuillez en sélectionner un autre.\n\nFormat de fichier pris en charge :\njpg, png, mp3, mp4 et mkv"
      exit 1
  fi
else
  z "Les dossiers ne peuvent pas être castés, veuillez sélectionner un fichier.\n\nFormat de fichier pris en charge :\njpg, png, mp3, mp4 et mkv"
  exit 1
fi

## On teste qu'un chromecast est présent
NB=`./stream2chromecast.py -devicelist | grep "0 devices found"`
[ -n "$NB" ] && {
  z "Aucun chromecast n'a été trouvé sur le réseau."
  exit 1
}

## Si un chromecast est trouvé, on "streame" le média
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
esac

exit 0
