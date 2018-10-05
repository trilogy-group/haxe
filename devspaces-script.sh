#!/usr/bin/env bash
if [ -d .stfolder  ]; 
then
    cndevspaces stop
    cndevspaces unbind
    rm -f .stignore
    rm -r .stfolder
fi
cndevspaces collections update -f devspaces.yml
cndevspaces bind -C haxe-coll -c haxe-config
# rm -f .stignore
# cp .gitignore .stignore
# echo ".git" >> .stignore
# echo ".stfolder" >> .stignore
# echo ".stignore" >> .stignore
# echo "*.sync-conflict-*" >> .stignore
# echo "*.syncthing.*" >> .stignore
cndevspaces info
cndevspaces exec /etc/haxe-unit-test-java-run.sh