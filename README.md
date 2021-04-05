Stream2Chromecast pour Caja
===========================

Décompresser l'archive dans le dossier ./Python de votre $HOME

Faire un lien vers le script dans votre dossier bin ou .bin de votre $HOME suivant votre installation :
(Regardez la configuration de votre fichier .profile ou .bashrc)

ln -s $HOME/.Python/stream2chromecast.sh s2c

On rend le script éxécutable :

chmod +x $HOME/.Python/stream2chromecast.sh

On ajoute un fichier bash pour appeler le script dans Caja :

mv "Caster (Images, Musiques et Vidéos)" $HOME/.config/caja/scripts/
chmod +x "$HOME/.config/caja/scripts/Caster (Images, Musiques et Vidéos)"

