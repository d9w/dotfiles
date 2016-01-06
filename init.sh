#!/bin/bash
for file in *
  do [ "$file" != "init.sh" ] && [ ! -e ~/.$file ] && ln -s $(pwd)/$file ~/.$file
done
