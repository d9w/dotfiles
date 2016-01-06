#!/bin/bash
for file in *
  do [ "$file" != "init.sh" ] && [ ! -e ~/.config/fish/$file ] && ln -s $(pwd)/$file ~/.config/fish/$file
done
