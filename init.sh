for file in *
  do [ "$file" != "init.sh" ] && ln -s $(pwd)/$file ~/.$file
done
