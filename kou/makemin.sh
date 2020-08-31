#! /usr/local/bin/zsh
cat premin > $1.tex
echo >> $1.tex
cat $1 >> $1.tex
echo >> $1.tex
cat postmin >> $1.tex
echo >> $1.tex
cat bodymin >> $1.tex
lualatex $1
