#! /bin/zsh
out='n-test.tex'
cat > ${out} << EOS
\documentclass[twocolumn]{article}
\usepackage{fontspec}
\usepackage[margin=10mm]{geometry}
\usepackage{luacode}
\begin{luacode*}
	my = my or {}
	function my.pua(n)
		local t, c = font.getfont(font.current()), 0
		if t and t.shared and t.shared.rawdata and t.shared.rawdata.descriptions then
			for i,v in pairs(t.shared.rawdata.descriptions) do
				if not v.name and v.unicode==n then c=i; break end
			end
		end
		tex.sprint(tostring(c))
	end
\end{luacode*}
\def\PUACHAR#1{\char\directlua{my.pua(\the\numexpr#1)}}

\setmainfont{Nishiki-teki}
\setlength{\parindent}{0pt}
\begin{document}
EOS

for i in $(seq $(printf '%d\n' 0x0) $(printf '%d\n' 0xFDF) | xargs printf '%X '); do
	echo -n '\\makebox[5em][r]{'${i}'x}\quad' >> ${out}
	for j in 0 1 2 3 4 5 6 7 8 9 A B C D E F; do
		echo -n '\\makebox[1.225em][c]{\\char"'${i}${j}'}' >> ${out}
	done
	echo '\\\\' >> ${out}
done

for i in $(seq $(printf '%d\n' 0xFE1) $(printf '%d\n' 0xFF0) | xargs printf '%X '); do
	echo -n '\\makebox[5em][r]{'${i}'x}\quad' >> ${out}
	for j in 0 1 2 3 4 5 6 7 8 9 A B C D E F; do
		echo -n '\\makebox[1.225em][c]{\\char"'${i}${j}'}' >> ${out}
	done
	echo '\\\\' >> ${out}
done

for i in $(seq $(printf '%d\n' 0x1000) $(printf '%d\n' 0x2FA1) | xargs printf '%X '); do
	echo -n '\\makebox[5em][r]{'${i}'x}\quad' >> ${out}
	for j in 0 1 2 3 4 5 6 7 8 9 A B C D E F; do
		echo -n '\\makebox[1.225em][c]{\\char"'${i}${j}'}' >> ${out}
	done
	echo '\\\\' >> ${out}
done

for i in $(seq $(printf '%d\n' 0xF000) $(printf '%d\n' 0x10FFF) | xargs printf '%X '); do
	echo -n '\\makebox[5em][r]{'${i}'x}\quad' >> ${out}
	for j in 0 1 2 3 4 5 6 7 8 9 A B C D E F; do
		echo -n '\\makebox[1.225em][c]{\\PUACHAR{"'${i}${j}'}}' >> ${out}
	done
	echo '\\\\' >> ${out}
done

echo '\\end{document}' >> ${out}

lualatex ${out}