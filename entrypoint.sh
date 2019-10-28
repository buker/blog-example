#!/bin/bash 

case $1 in
     serve)      
          jekyll server
          ;;
     new)      
          jekyll new $2
          cp -r /srv/jekyll/blog_example /srv/jekyll
          echo 'test'
          ;;
     *)
          exit
          ;;
esac