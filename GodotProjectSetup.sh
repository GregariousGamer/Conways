!#/bin/bash

mkdir addons assets entities scenes scripts UI build GDD
cd assets && mkdir fints textures materials models sounds etc
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
git init
cp ~/Desktop/.gitignore -t .
git add .
git commit

