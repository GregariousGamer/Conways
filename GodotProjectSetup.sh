#!/bin/bash

mkdir addons assets entities scenes scripts UI build GDD
cd assets && mkdir fonts textures materials models sounds etc
cd ..
cd entities && mkdir player enemies environment etc
cd .. 
cd scripts && mkdir globals app game etc
cd ..
cd UI && mkdir MainMenu GameMenu HUD Debug etc BackgroundLoading
cd ..
cd GDD
cp ~/GodotGames/TemplateGDD.odt -t .
cd ..
cp ~/Desktop/.gitignore -t .

find . ! -path . -type d -exec cp .keep {} \;
