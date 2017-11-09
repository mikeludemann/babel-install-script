#!/bin/bash

echo "Checking babel"

file=./package.json
apps=./apps.txt
babel_file=.babelrc

if babel --version > /dev/null; then
  echo "babel is already installed."
  if [ -e "$file" ]; then
    echo "File - package.json - exists"
    if [ -e "$babel_file" ]; then
      echo "File - .babelrc - exists"
      npm install --save-dev babel-preset-env
      echo '{\n\t"presets": ["env"]\n}' > $babel_file
    else
      echo "File not exists"
      touch .babelrc
    fi
  else
    echo "File not exists"
    npm init
  fi
else
  if node -v > /dev/null; then
    if npm -v > /dev/null; then
      echo "installing babel"
      npm install gulp-cli -g
      npm install gulp -g
      touch gulpfile.js
      if [ -e "$file" ]; then
        echo "File - package.json - exists"
        if [ -e "$apps" ]; then
          echo "File - apps.txt - exists"
          while read -r line
          do
            app=`echo $line | cut -d \; -f 1`
            npm install --save-dev $app
          done < $apps
          if [ -e "$babel_file" ]; then
            echo "File - .babelrc - exists"
            echo "Write text into .babelrc"
            echo '{\n\t"presets": ["env"]\n}' > $babel_file
          else
            echo "File not exists"
            touch .babelrc
          fi
        else
          echo "File not exists"
        fi
      else
        echo "File not exists"
        npm init
      fi
    else
      echo "npm is not installed"
    fi
  else
    echo "node is not installed"
  fi
fi
