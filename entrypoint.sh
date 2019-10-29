#!/bin/bash 
echo $1
case $1 in
     serve) 
          jekyll server
          ;;
     new)      
          jekyll new $2
          echo "New page generated"
          cp Gem* $2/
          ;;
     *)
          echo "No arguments"
          exit
          ;;
esac