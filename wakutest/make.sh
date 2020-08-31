#! /usr/local/bin/zsh
cat pre > $1.tex
echo >> $1.tex
cat $1 >> $1.tex
echo >> $1.tex
cat post >> $1.tex
echo >> $1.tex
cat body >> $1.tex
lualatex $1
