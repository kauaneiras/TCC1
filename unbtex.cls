%%
%% UnBTeX: A class for bachelor, master, and doctoral thesis at the
%% University of Brasilia (UnB), Brazil
%% Version 1.5.5 2025/04/10
%% Copyright (C) 2021-2025 by Henrique C. Ferreira <hcferreira@unb.br>
%%
%% This class file may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3 of this license
%% or (at your option) any later version. The latest version of this
%% license is in:
%% 
%%    https://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2005/12/01 or later.
%%
%% This package consists of the file unbtex.cls and the bibliographic style 
%% files located in the unbtexcite directory.
%% Template files: unbtex-example.pdf, unbtex-example.tex, and files within
%% unbtex-example directory.
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unbtex}[2024/04/10 v1.5.5 Modelo da Universidade de Brasília baseado em abnTeX2]

% ------------------------------------------------------------------------
% Opções para a classe
% ------------------------------------------------------------------------

% ---
% Opção para definição de idioma principal
% ---
\def\idioma{brazil} % Português, por default
\DeclareOption{idioma=brazil}{\def\idioma{brazil}}
\DeclareOption{idioma=english}{\def\idioma{english}}
% ---

% ---
% Opção para definição de estilo de referências bibliográficas
% ---
\def\bibsty{alf} % Autor-data, por default
\DeclareOption{bib=alf}{\def\bibsty{alf}}
\DeclareOption{bib=num}{\def\bibsty{num}}
% ---

% ---
% Opção para indicar as páginas que cada referência é citada
% ---
\def\refpage{off} % Desabilitada, por default
\DeclareOption{refback}{\def\refpage{on}}
% ---

% ---
% Opção para definição de estilo de numeração de figuras, tabelas, etc
% ---
\def\numb{chap} % Numeração por capítulo, por default
\DeclareOption{numb=chap}{\def\numb{chap}}
\DeclareOption{numb=abnt}{\def\numb{abnt}}
% ---

% ---
% Repassa demais opções à classe abntex2
% ---
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{abntex2}
}
\PassOptionsToPackage{english,brazil}{babel}
\ProcessOptions\relax
\LoadClass[12pt,a4paper]{abntex2}
% ---

% ------------------------------------------------------------------------
% Configurações básicas
% ------------------------------------------------------------------------

% ---
% Pacotes matemáticos
% ---
\RequirePackage{mathtools} % Melhoria nas equações
\RequirePackage{amsthm} % Para configuração de ambientes do tipo teorema
% ---

% ---
% Pacotes de fontes tipográficas
% ---
\RequirePackage{stickstootext} % Fonte principal (Stix2)
\RequirePackage[stickstoo,vvarbb]{newtxmath} % Fonte matemática (Stix2)
\RequirePackage[cal=stixplain,scr=stixtwofancy,frak=stixtwo,bb=stix]{mathalfa}
\RequirePackage[scale=0.90]{tgheros} % Fonte sans serif (TeX Gyre Heros)
\RequirePackage[scale=1]{inconsolata} % Fonte monoespaçada
% ---

% ---
% Cores verde e azul UnB
% http://www.marca.unb.br/arquivosdigitais/files/guia_pratico/guia_pratico.pdf
% ---
% Define cores da UnB
\RequirePackage[dvipsnames]{xcolor}
\definecolor{verdeunb}{cmyk}{1,0,1,0.2}
\definecolor{azulunb}{cmyk}{1,0.65,0,0.35}
% Cores nos títulos
\renewcommand{\tocheadstart}{}
\renewcommand{\ABNTEXchapterfont}{\bfseries\color{verdeunb}\sffamily}
\renewcommand{\ABNTEXsubsectionfont}{}
% ---

% ---
% Configurações para a opção article
% ---
\ifthenelse{\equal{\ABNTEXistwocolumn}{true}}{
\renewcommand{\ABNTEXisarticle}{true}}{}
\ifthenelse{\equal{\ABNTEXisarticle}{true}}{
\chapterstyle{article}
\numberwithin{section}{chapter}
\setlength{\droptitle}{-2em}
%\addtolength{\droptitle}{-1.5\baselineskip}
\renewcommand{\maketitlehookd}{\vskip -.8em}
\renewcommand{\chaptitlefont}{\bfseries\sffamily\Large\color{verdeunb}}
\setsecheadstyle{\large\bfseries\sffamily\color{verdeunb}}
\setsubsecheadstyle{\normalfont\bfseries\sffamily}
\renewcommand{\chapternamenum}[1]{\ifanappendix \chaptitlefont\appendixname\space#1\else #1\fi}
\renewcommand{\afterchapternum}{\ifanappendix\space\hspace{-20pt}\enspace\textendash\enspace\fi}
\setlength\absleftindent{0cm}
\setlength\absrightindent{0cm}
\renewcommand{\abstracttextfont}{\normalfont\normalsize}
\ifthenelse{\equal{\ABNTEXistwocolumn}{false}}{
\setlength{\parindent}{2.3em} % Tamanho da indentação da primeira linha do parágrafo
\setlength{\parskip}{.1\baselineskip plus .05\baselineskip} % Espaço entre parágrafos
\setlrmarginsandblock{2cm}{2cm}{*}
\setulmarginsandblock{2.5cm}{2cm}{*}
\checkandfixthelayout[nearest]}{
\input{mem11.clo} % Tamanho da fonte
\SingleSpacing
\setlength{\parindent}{1.8em}
\AtBeginEnvironment{thebibliography}{\linespread{0.8}\selectfont}
\setlength{\columnsep}{7.5mm}
\def\@mathmargin{0pt}
\setlrmarginsandblock{1.5cm}{1.5cm}{*}
\setulmarginsandblock{2.5cm}{2cm}{*}
\checkandfixthelayout[nearest]}
\ifthenelse{\boolean{ABNTEXsumario-tradicional}}{}{
\renewcommand{\tocpartapendices}{\addtocontents{toc}{
\cftsetindents{chapter}{\cftlastnumwidth}{2em}}\cftinserthook{toc}{A}}
\renewcommand{\tocpartanexos}{\addtocontents{toc}{
\cftsetindents{chapter}{\cftlastnumwidth}{2em}}
\cftinserthook{toc}{A}}}}{ % Opção article não utilizada
\setlrmarginsandblock{3cm}{2cm}{*} % Margens esquerda e direita
\setulmarginsandblock{3cm}{2cm}{*} % Margens superior e inferior
\checkandfixthelayout[nearest]
\setlength{\parindent}{2.3em} % Tamanho da indentação da primeira linha do parágrafo
\setlength{\parskip}{.1\baselineskip plus .05\baselineskip} % Espaço entre parágrafos
}
\renewcommand{\maketitlehookb}{\vskip -1.5\topsep\vskip -1.5\partopsep}
\pretitle{\begin{center}\color{verdeunb}\LARGE\sffamily\bfseries}
\posttitle{\par\end{center}\vskip 0.5em}
\renewcommand{\and}{\unskip, }
% ---

% ---
% Pacotes para figuras
% ---
\RequirePackage[captionskip=8pt]{subfig} % Permite fazer subfiguras
%\RequirePackage[skip=8pt]{subcaption} % Permite fazer subfiguras
% ---

% ---
% Configurações para tabelas e quadros
% ---
\RequirePackage{longtable}% Para tabelas longas
\RequirePackage{multirow} % Para combinar linhas nas tabelas
\RequirePackage{colortbl} % Permite alterar cores de linhas e células das tabelas
\arrayrulecolor{verdeunb} % Define a cor das linhas das tabelas
\setlength\arrayrulewidth{0.6pt} % Define a espessura das linhas das tabelas

% Alinhamento em colunas com especificação de largura
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Criacao dos ambientes flutuantes para quadros
\newfloat[chapter]{quadro}{loq}{\Quadroname}
\newlistof{listofquadros}{loq}{\listquadroname}
\newlistentry{quadro}{loq}{0}
\renewcommand{\cftquadroname}{\Quadroname\space}
\IfStrEq{\numb}{chap}
{\cftsetindents{quadro}{0em}{2.3em}}{\cftsetindents{quadro}{0em}{1.8em}}
\renewcommand{\thequadro}{\thechapter.\arabic{quadro}}
\def\QT@c@ption#1[#2]#3{%
  \LT@makecaption#1\fnum@quadro{#3}%
  \def\@tempa{#2}%
  \ifx\@tempa\@empty\else
     {\let\\\space
     \addcontentsline{\ext@quadro}{quadro}{\protect\numberline{\thequadro}{#2}}}%
  \fi}
\newenvironment{longquadro}
{\let\LT@c@ption\QT@c@ption\let\c@table\c@quadro\crefalias{table}{quadro}
\renewcommand{\theHtable}{quadro\thechapter.\arabic{quadro}}\longtable}
{\endlongtable}
% ---

% ---
% Pacotes para algoritmos
% ---
\IfStrEq{\idioma}{brazil}
{\usepackage[algochapter,linesnumbered,boxed,portuguese,onelanguage]{algorithm2e}
\SetAlgorithmName{Algoritmo}{algoritmo}{Lista de algoritmos}}
{\usepackage[algochapter,linesnumbered,boxed,english,onelanguage]{algorithm2e}
\SetAlgorithmName{Algorithm}{algorithm}{List of algorithms}}
\SetAlgoCaptionSeparator{\ABNTEXcaptiondelim}
\renewcommand{\AlCapFnt}{\normalfont\small}
\renewcommand{\AlCapNameFnt}{\small}
\renewcommand{\@algocf@capt@boxed}{above}
\DontPrintSemicolon
\setlength{\algomargin}{1.8em}
\xpatchcmd\algocf@makecaption{\hbox}{\hskip\algomargin\hbox}{}{\fail}
\SetAlgoInsideSkip{smallskip}
\renewcommand*\listofalgorithms{\listoftoc[\listalgorithmcfname]{loa}}
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{loa}{\protect\noaddvspace}
% ---

% ---
% Pacote para códigos de programação
% ---
\RequirePackage{listings}
% Julia (Linguagem não reconhecida automaticamente pelo pacote listings)
\lstdefinelanguage{Julia}%
    {morekeywords={abstract,break,case,catch,const,continue,do,else,elseif,%
    end,export,false,for,function,immutable,import,importall,if,in,%
    macro,module,otherwise,quote,return,switch,true,try,type,typealias,%
    using,while},%
    sensitive=true,%
    alsoother={\$},%
    morecomment=[l]\#,%
    morecomment=[n]{\#=}{=\#},%
    morestring=[s]{"}{"},%
    morestring=[m]{'}{'},%
}[keywords,comments,strings]%
% Configurações gerais
\definecolor{mygreen}{RGB}{28,172,0} % Color values Red, Green, Blue
\definecolor{mylilas}{RGB}{170,55,241}
\lstset{%
    basicstyle=\linespread{1.08}\ttfamily\footnotesize,
    numbers=left,%
    numberstyle={\tiny \color{black}}, % Size of the numbers
    numbersep=9pt, % This defines how far the numbers are from the text
    backgroundcolor=\color{gray!10},
    tabsize=2,
    frame=single,
    rulecolor=\color{black!30},
    captionpos=t,
    belowcaptionskip=10pt,
    escapeinside={\%*}{*)},
    breaklines=true,%
    breakatwhitespace=true,
    framextopmargin=2pt,
    framexbottommargin=2pt,
    keywordstyle=\color{blue},%
    morekeywords=[2]{1}, keywordstyle=[2]{\color{black}},
    identifierstyle=\color{black},%
    stringstyle=\color{mylilas},
    commentstyle=\color{mygreen},%
    extendedchars=true,
    inputencoding=utf8,
    showstringspaces=false,% Without this there will be a symbol in the places where there is a space
    literate={á}{{\'a}}1 {ã}{{\~a}}1 {é}{{\'e}}1 {ç}{{\c{c}}}1 {â}{{\^a}}1 {õ}{{\~o}}1 {ú}{{\'u}}1 {ó}{{\'o}}1 {í}{{\'i}}1 {Í}{{\'I}}1 
}
% Configura lista de códigos
\AtBeginDocument{%
\renewcommand\lstlistoflistings{\bgroup
  \let\contentsname\lstlistlistingname
  \IfStrEq{\numb}{chap}
  {\def\l@lstlisting##1##2{\@dottedtocline{1}{0em}{2.3em}{\lstlistingname~##1}{##2}}}
  {\def\l@lstlisting##1##2{\@dottedtocline{1}{0em}{1.8em}{\lstlistingname~##1}{##2}}}
  \let\lst@temp\@starttoc \def\@starttoc##1{\lst@temp{lol}}%
  \tableofcontents \egroup}
}
% ---

% ---
% Configurações do texto
% ---
\RequirePackage{indentfirst} % Indenta o primeiro parágrafo de cada seção.
\RequirePackage[disable=ifdraft,protrusion=false]{microtype} % Para melhorias de justificação
\RequirePackage{icomma} % Configura casas decimais separadas por vírgula
\frenchspacing % Retira espaço extra entre as frases (após o ponto final)
\pdfminorversion=7 % Configuração da versão do arquivo pdf produzido

% Configurações dos cabeçalhos
\makepagestyle{simple} % Cabeçalho com número de pagina e linha horizontal
\makeevenhead{simple}{\footnotesize\thepage}{}{}
\makeoddhead{simple}{}{}{\footnotesize\thepage}
\makeheadrule{simple}{\textwidth}{\normalrulethickness}
\makepagestyle{plain} % Cabeçalho com número de pagina e sem linha horizontal
\makeevenhead{plain}{\footnotesize\thepage}{}{}
\makeoddhead{plain}{}{}{\footnotesize\thepage}
\newcommand{\textualsimples}{\ifthenelse{\equal{\ABNTEXisarticle}{true}}
{\pagestyle{plain}}{\pagestyle{simple}\aliaspagestyle{chapter}{abntchapfirst}}}

% Espaçamento para notas de rodapé
\setlength{\skip\footins}{20pt plus 2pt minus 2pt} % Espaço entre o texto e as notas de rodapé
\addtolength{\footnotesep}{2pt} % Espaço entre as notas de rodapé
\renewcommand*{\footnoterule}{\kern-3pt \hrule width 5cm \kern 2.6pt} % Tamanho do traço superior (5cm)

% Ajusta espaço entre texto e figuras/tabelas
\setlength{\textfloatsep}{18pt plus 2pt minus 2pt} % Espaçamento entre texto e floats no topo/base da página
\setlength{\floatsep}{12pt plus 2pt minus 2pt} % Espaçamento entre floats
\setlength{\intextsep}{14pt plus 2pt minus 2pt} % Espaçamento entre texto e floats no meio da página

% Ajusta espaçamento nos ambientes itemize, enumerate, description e alineas
\setlist[itemize,enumerate,description]{topsep=1pt,itemsep=0pt,parsep=1pt,partopsep=1pt,leftmargin=\parindent}
\setlist[alineas,1]{label={\alph*)},topsep=1pt,itemsep=0pt,parsep=1pt,partopsep=1pt,leftmargin=\parindent}

% Numeração de figuras, tabelas, etc. por capítulo ou para o documento inteiro
\AtBeginDocument{% Numeração por capítulo
\IfStrEq{\numb}{chap}{
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}\numberwithin{figure}{chapter}
\renewcommand{\thetable}{\thechapter.\arabic{table}}\numberwithin{table}{chapter}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}\numberwithin{equation}{chapter}
}{% Numeração para o documento inteiro (padrão ABNT)
\counterwithout{equation}{chapter}
\counterwithout{quadro}{chapter}
\counterwithout{lstlisting}{chapter}
\counterwithout{algocf}{chapter}
\counterwithout{theorem}{chapter}
\counterwithout{lemma}{chapter}
\counterwithout{proposition}{chapter}
\counterwithout{corollary}{chapter}
\counterwithout{definition}{chapter}
\counterwithout{assumption}{chapter}
\counterwithout{axiom}{chapter}
\counterwithout{conjecture}{chapter}
\counterwithout{property}{chapter}
\counterwithout{example}{chapter}
\counterwithout{exercise}{chapter}
\counterwithout{problem}{chapter}
\counterwithout{remark}{chapter}
}}
% Modifica o tamanho da fonte e espaçamento entre linhas no ambiente verbatim
\RequirePackage{fvextra}
\renewenvironment{verbatim}{\VerbatimEnvironment
  \begin{Verbatim}[fontsize=\footnotesize,baselinestretch=1.08]%
}{%
  \end{Verbatim}
}%
\fvset{listparameters=\setlength{\topsep}{4pt}\setlength{\partopsep}{0pt}}
% ---

% ---
% Configurações do Sumário
% ---
\ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{
\renewcommand{\cftpartfont}{\bfseries\sffamily}
\renewcommand{\cftpartpagefont}{\bfseries\sffamily}
\renewcommand{\cftchapterfont}{\bfseries\sffamily}
\renewcommand{\cftsectionfont}{\bfseries\sffamily}
}{
\renewcommand{\cftpartfont}{\bfseries\sffamily}
\renewcommand{\cftchapterfont}{\bfseries\sffamily}
\renewcommand{\cftpartpagefont}{\bfseries\sffamily}
\renewcommand{\cftchapterpagefont}{\bfseries\sffamily}
\settocdepth{subsection}
\setlength{\cftbeforechapterskip}{5pt plus 1pt minus 1pt}
\setlength{\cftbeforepartskip}{10pt plus 2pt minus 2pt}
}
% Corrige warning do pacote hyperref para sumário ABNT
\renewcommand{\PRIVATEapendiceconfig}[2]{%
 \setboolean{abntex@apendiceousecao}{true}%
 \renewcommand{\appendixname}{#1}
 \ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{
   %\renewcommand{\appendixtocname}{\uppercase{#2}}}{%
   \renewcommand{\appendixtocname}{\texorpdfstring{\MakeTextUppercase{#2}}{#2}}}{%
  \renewcommand{\appendixtocname}{#2}
  }
 \renewcommand{\appendixpagename}{#2}
 \ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}
 {\switchchapname{\MakeTextUppercase{#1}}}{\switchchapname{#1}}
 \renewcommand*{\cftappendixname}{#1 \space}
}
% Apendices - comando 
\renewcommand{\apendices}{%
 \PRIVATEapendiceconfig{\apendicename}{\apendicesname}
 \appendix
}
% Apendices - ambiente
\renewenvironment{apendicesenv}{%
 \PRIVATEapendiceconfig{\apendicename}{\apendicesname}
 \crefalias{chapter}{appendix} % Adicionado
 \begin{appendix}
}{
 \end{appendix}
 \setboolean{abntex@apendiceousecao}{false}
 \bookmarksetup{startatroot}
}
% Corrige nome dos anexos nas referências cruzadas
\renewcommand{\anexos}{%
 \cftinserthook{toc}{AAA}
 %\PRIVATEapendiceconfig{\anexoname}{\anexosname}
 \PRIVATEapendiceconfig{\Anexoname}{\Anexosname}
 \appendix
 \renewcommand\theHchapter{anexochapback.\arabic{chapter}}
}
\renewenvironment{anexosenv}{%
 \cftinserthook{toc}{AAA}
 %\PRIVATEapendiceconfig{\anexoname}{\anexosname}
 \PRIVATEapendiceconfig{\Anexoname}{\Anexosname}
 %\crefalias{appendix}{annex}
 \crefalias{chapter}{annex}%
 \begin{appendix}
 \renewcommand\theHchapter{anexochapback.\arabic{chapter}}
}{%
 \end{appendix}
 \setboolean{abntex@apendiceousecao}{false}
 \bookmarksetup{startatroot}
}
% ---

% ---
% Configurações das legendas
% ---
% Legenda das figuras/tabelas na parte superior, tamanho da fonte e espaçamento
\captionsetup{font=small,belowskip=2pt}
% Espaçamento vertical do comando \legend
\renewcommand{\legend}[1]{%
  \M@gettitle{#1}%
  \memlegendinfo{#1}%
  \par
  \begingroup
     \@parboxrestore
     \if@minipage
       \@setminipage
     \fi
     \ABNTEXfontereduzida
     \captionsetup{aboveskip=0pt,belowskip=6pt}
     \captiondelim{\mbox{}}
     \@makecaption{}{\ABNTEXfontereduzida #1}\par
  \endgroup
}
% Espaçamento vertical do comando \fonte (e de \nota)
\renewcommand{\fonte}[2][\fontename]{%
  \M@gettitle{#2}%
  \memlegendinfo{#2}%
  \par
  \begingroup
     \@parboxrestore
     \if@minipage
       \@setminipage
     \fi
     \ABNTEXfontereduzida
     \captionsetup{aboveskip=0pt,belowskip=6pt}
     \captiondelim{\ABNTEXcaptionfontedelim}
     \@makecaption{\ABNTEXfontereduzida #1}{\ignorespaces\ABNTEXfontereduzida #2}\par
  \endgroup
}
% ---

% ---
% Configurações do pacote hyperref
% ---
\hypersetup{%
    pdfstartview=FitH,
    breaklinks=true, 
    colorlinks=true,
    allcolors=azulunb,
    linktocpage,
    bookmarksdepth=4,
}
% ---

% ---
% Pacote para remissões internas
% ---
\IfStrEq{\idioma}{brazil}
{\RequirePackage[nameinlink,noabbrev,brazilian]{cleveref}}
{\RequirePackage[nameinlink,noabbrev,english]{cleveref}}
\crefname{annex}{\anexoname}{\anexosname}
\Crefname{annex}{\Anexoname}{\Anexosname}
\crefname{listing}{\codigoname}{\codigosname}
\Crefname{listing}{\Codigoname}{\Codigosname}
\crefname{subsection}{\subsectionname}{\subsectionsname}
\Crefname{subsection}{\Subsectionname}{\Subsectionsname}
\crefname{quadro}{\quadroname}{\quadrosname}
\Crefname{quadro}{\Quadroname}{\Quadrosname}
\newcommand\cref@smugglelabel{\let\cref@currentlabel\cref@gcurrentlabel@temp}
\newcommand\cref@updatelabeldata[1]{%
 \cref@constructprefix{#1}{\cref@result}%
  \@ifundefined{cref@#1@alias}%
    {\def\@tempa{#1}}%
    {\def\@tempa{\csname cref@#1@alias\endcsname}}%
  \protected@xdef\cref@gcurrentlabel@temp{%
    [\@tempa][\arabic{#1}][\cref@result]%
    \csname p@#1\endcsname\csname the#1\endcsname}%
  \aftergroup\cref@smugglelabel}
\AddToHook{label}{\cref@updatelabeldata{\@currentcounter}}
% ---

% ---
% Definição de ambientes teorema, exemplo, demonstração, etc.
% ---
\RequirePackage{mdframed}

\theoremstyle{definition}
\mdfdefinestyle{plainSty}{hidealllines=true,backgroundcolor=verdeunb!10,innertopmargin=0pt}
\newmdtheoremenv[style=plainSty]{theorem}{\thname}[chapter] % Teorema
\newmdtheoremenv[style=plainSty]{lemma}{\lmname}[chapter] % Lema
\newmdtheoremenv[style=plainSty]{proposition}{\prname}[chapter] % Proposição
\newmdtheoremenv[style=plainSty]{corollary}{\crname}[chapter] % Corolário

\theoremstyle{definition}
\mdfdefinestyle{defnSty}{hidealllines=true,backgroundcolor=azulunb!10,innertopmargin=0pt}
\newmdtheoremenv[style=defnSty]{definition}{\dfname}[chapter] % Definição
\newmdtheoremenv[style=defnSty]{assumption}{\aptname}[chapter] % Hipótese
\newmdtheoremenv[style=defnSty]{axiom}{\axname}[chapter] % Axioma
\newmdtheoremenv[style=defnSty]{conjecture}{\cjcname}[chapter] % Conjectura
\newmdtheoremenv[style=defnSty]{property}{\prpname}[chapter] % Propriedade
\newmdtheoremenv[style=defnSty]{example}{\expname}[chapter] % Exemplo
\newmdtheoremenv[style=defnSty]{exercise}{\excname}[chapter] % Exercício
\newmdtheoremenv[style=defnSty]{problem}{\prbname}[chapter] % Proplema

\theoremstyle{remark}
\let\proof\relax
\let\endproof\relax
\newmdtheoremenv[linecolor=azulunb,linewidth=1pt,hidealllines=false,innertopmargin=4pt]{remark}{\rmname}[chapter] % Observação

\newtheoremstyle{myproof}{\topsep}{\topsep}{}{}{\bfseries}{}{ }{\thmname{#1} \thmnote{#3}}
\theoremstyle{myproof}
\let\proof\relax
\let\endproof\relax
\newmdtheoremenv[linecolor=verdeunb,linewidth=1pt,hidealllines=false,innertopmargin=0pt]{proof}{\proofname.} % Prova
\AtEndEnvironment{proof}{\hfill$\square$}
\newmdtheoremenv[linecolor=azulunb,linewidth=1pt,hidealllines=false,innertopmargin=0pt]{solution}{\sltname.} % Solução
% ---

% ---
% Referências bibliográficas
% ---
% Lista na bibliografia o número das páginas em que cada referência é citada
\IfStrEq{\refpage}{off}{}{
\IfStrEq{\idioma}{brazil}
{\RequirePackage[hyperpageref,brazilian]{backref}}{\RequirePackage[hyperpageref,english]{backref}}
\renewcommand*{\backref}[1]{}
\renewcommand*{\backrefalt}[4]{\ifcase#1\nocitation\or\citedp~#2.\else\citedpp~#2.\fi}
}
\AtBeginDocument{
% Retira os limitadores < e > dos hiperlinks
\addtociteoptionlist{abnt-url-package=url}
\def\UrlLeft{}
\def\UrlRight{}
\urlstyle{same}
}
% Gera as referências bibliográficas de acordo com as normas da ABNT
\newcommand{\bibhang}[1]{\setlength{\bibindent}{#1}}
\IfStrEq{\bibsty}{alf}{% Estilo autor-data
\RequirePackage[alf,abnt-etal-list=0,abnt-etal-cite=3,abnt-emphasize=bf,abnt-missing-year=sd,bibjustif]{abntex2cite}
\renewcommand{\@biblabel}[1]{}%
\IfStrEq{\idioma}{brazil} % Seleciona o arquivo de estilo de citação
{\bibliographystyle{unbtexcite/unbtex-alf-pt}}{\bibliographystyle{unbtexcite/unbtex-alf-en}}
}{%
\IfStrEq{\bibsty}{num}{% Estilo numérico
\RequirePackage[num,abnt-etal-list=0,abnt-emphasize=bf,abnt-missing-year=sd,bibjustif]{abntex2cite}
\RequirePackage{cite} % Para ordenar, comprimir e colocar entre colchetes os números nas citações
\renewcommand{\@biblabel}[1]%
{%
\ifthenelse{\equal{#1}{}}{}%
{%
% Para números entre colchetes na lista de referências
%\def\biblabeltext{{\citenumstyle #1\hspace{\biblabelsep}}}%
\def\biblabeltext{{\citenumstyle[#1]\hspace{\biblabelsep}}}%
\settowidth{\ABCIauxlen}{\biblabeltext}%
\ifthenelse{\lengthtest{\ABCIauxlen<\minimumbiblabelwidth}}%
{\setlength{\ABCIauxlen}{\minimumbiblabelwidth-\ABCIauxlen}}%
{\setlength{\ABCIauxlen}{0cm}}%
%{\biblabeltext\hspace{\ABCIauxlen}}%
\parbox[t]{\bibindent}{\raggedleft\biblabeltext\hspace{\ABCIauxlen}}%
}}%
\renewcommand{\citeonline}[2][] % Redefine \citeonline como \cite
{\ifthenelse{\equal{#1}{}}{\cite{#2}}{\cite[#1]{#2}}}
\IfStrEq{\idioma}{brazil} % Seleciona o arquivo de estilo de citação
{\bibliographystyle{unbtexcite/unbtex-num-pt}}{\bibliographystyle{unbtexcite/unbtex-num-en}}
}}
% ---

% ---
% Listas de abreviaturas/siglas/símbolos
% ---
\IfStrEq{\idioma}{brazil}
{\RequirePackage[portuguese]{nomencl}}{\RequirePackage[english]{nomencl}}
%\RequirePackage[refpage]{nomencl} % Para imprimir página onde o símbolo foi registrado
%\def\pagedeclaration#1{\dotfill\hyperlink{page.#1}{\nobreakspace#1}\par}
\renewcommand{\nomname}{\listadesiglasname} % Nome da lista de siglas
\setlength{\nomitemsep}{-\parsep} % Espaço entre os itens das listas
% Imprime os títulos das listas e dos grupos
\newcommand{\nomenclheader}[1]{\section*{\hspace*{-\leftmargin}\large#1}}
\renewcommand\nomgroup[1]{%
  \IfStrEqCase{#1}{%
   {A}{\vspace{-38pt}\nomenclheader{}} % Lista de abreviaturas e siglas
   {B}{\PRIVATEclearpageifneeded % Quebra de página
       \pretextualchapter{\hspace{-\leftmargin}\listadesimbolosname} % Lista de símbolos
       \vspace{-10pt}\nomenclheader{\nomBname}} % Símbolos romanos
   {C}{\nomenclheader{\nomCname}} % Símbolos gregos
   %{Letra}{\nomenclheader{Nome do grupo}} % Acrescente, se necessário, outros grupos
   {X}{\nomenclheader{\nomXname}} % Sobrescritos
   {Z}{\nomenclheader{\nomZname}} % Subscritos
   % Grupos podem ser alterados ou adicionados
  }%
}
% Ajusta a largura do rótulo nas listas de abreviaturas/siglas/símbolos
\RequirePackage{xpatch}
\xapptocmd\thenomenclature{\let\@item\nomencl@item\def\nomencl@width{0pt}}{}{}
\let\nomencl@item\@item
\xpretocmd\nomencl@item{\nomencl@measure{#1}}{}{}
\def\nomencl@measure#1{%
  \sbox0{#1}%
  \ifdim\wd0>\nomencl@width\relax
    \edef\nomencl@width{\the\wd0}%
  \fi
}
\xapptocmd\endthenomenclature{%
  \immediate\write\@mainaux{\global\nomlabelwidth\nomencl@width\relax}%
}{}{}
% ---

% ---
% Ajusta a indentação das listas de figuras e de tabelas
% ---
\RequirePackage{tocbasic} % Já carregado pelo pacote nomencl
\DeclareTOCStyleEntry[
    indent=0pt,
    entrynumberformat=\entrynumberwithprefix{\figurename},
    dynnumwidth,
]{tocline}{figure}
\DeclareTOCStyleEntry[
    indent=0pt,
    entrynumberformat=\entrynumberwithprefix{\tablename},
    dynnumwidth,
]{tocline}{table}
\DeclareTOCStyleEntry[
    level:=figure,
    numwidth:=figure,
    indent=0pt,
    entrynumberformat=\entrynumberwithprefix{\algorithmname},
    dynnumwidth,
]{tocline}{algocf}
\newcommand\entrynumberwithprefix[2]{#1~#2\thinspace\hfill}
% ---

% ---
% Citacao direta com mais de 3 linhas - ABNT NBR 10520/2002 - 5.3
% Corrige tamanho do recuo do ambiente citacao do abntex2 para 4cm
% ---
\ifthenelse{\equal{\ABNTEXistwocolumn}{true}}{%
 \setlength{\ABNTEXcitacaorecuo}{1.8cm}
}{% else
 \setlength{\ABNTEXcitacaorecuo}{4cm}
}
\renewenvironment*{citacao}[1][default]{%
  \begin{adjustwidth}{\ABNTEXcitacaorecuo}{0mm}%
  \ABNTEXfontereduzida\vspace{4pt}
  \begin{SingleSpace}%
  \ifthenelse{\not\equal{#1}{default}}{\itshape\selectlanguage{#1}}{}%
}{%
  \end{SingleSpace}\vspace{4pt}%
  \end{adjustwidth}
}
% ---

% ---
% Define o texto dos rótulos de acordo com o idioma principal selecionado
% ---
\newcommand{\Anexoname}{Anexo}\newcommand{\Anexosname}{Anexos}
\newcommand{\subsectionname}{subseção}\newcommand{\subsectionsname}{subseções}
\newcommand{\Subsectionname}{Subseção}\newcommand{\Subsectionsname}{Subseções}
\newcommand{\codigoname}{código}\newcommand{\codigosname}{códigos}
\newcommand{\Codigoname}{Código}\newcommand{\Codigosname}{Códigos}
\newcommand{\algorithmname}{Algoritmo}
\newcommand{\listquadroname}{Lista de quadros}
\newcommand{\quadroname}{quadro}\newcommand{\quadrosname}{quadros}
\newcommand{\Quadroname}{Quadro}\newcommand{\Quadrosname}{Quadros}
\newcommand{\thname}{Teorema}
\newcommand{\lmname}{Lema}
\newcommand{\prname}{Proposição}
\newcommand{\crname}{Corolário}
\newcommand{\aptname}{Hipótese}
\newcommand{\dfname}{Definição}
\newcommand{\axname}{Axioma}
\newcommand{\cjcname}{Conjectura}
\newcommand{\prpname}{Propriedade}
\newcommand{\expname}{Exemplo}
\newcommand{\excname}{Exercício}
\newcommand{\prbname}{Problema}
\newcommand{\sltname}{Solução}
\newcommand{\rmname}{Observação}
\newcommand{\nocitation}{Nenhuma citação no texto.}
\newcommand{\citedp}{Citado na p.}
\newcommand{\citedpp}{Citado nas pp.}
\newcommand{\nomBname}{Símbolos romanos}
\newcommand{\nomCname}{Símbolos gregos}
\addto\captionsbrazil{
\renewcommand{\listfigurename}{Lista de figuras}
\renewcommand{\apendicename}{Apêndice}
\renewcommand{\anexoname}{anexo}\renewcommand{\anexosname}{anexos}
\renewcommand{\lstlistingname}{Código}
\renewcommand{\lstlistlistingname}{Lista de códigos}
\renewcommand{\proofname}{Demonstração}
}
\addto\captionsenglish{
\renewcommand{\bibname}{References}
\renewcommand{\listfigurename}{List of figures}
\renewcommand{\listtablename}{List of tables}
\renewcommand{\apendicename}{Appendix}
\renewcommand{\apendicesname}{Appendices}
\renewcommand{\anexoname}{annex}\renewcommand{\anexosname}{annexes}
\renewcommand{\Anexoname}{Annex}\renewcommand{\Anexosname}{Annexes}
\renewcommand{\subsectionname}{subsection}\renewcommand{\subsectionsname}{subsections}
\renewcommand{\Subsectionname}{Subsection}\renewcommand{\Subsectionsname}{Subsections}
\renewcommand{\lstlistingname}{Code}
\renewcommand{\lstlistlistingname}{List of codes}
\renewcommand{\codigoname}{code}\renewcommand{\codigosname}{codes}
\renewcommand{\Codigoname}{Code}\renewcommand{\Codigosname}{Codes}
\renewcommand{\algorithmname}{Algorithm}
\renewcommand{\listquadroname}{List of charts}
\renewcommand{\quadroname}{chart}\renewcommand{\quadrosname}{charts}
\renewcommand{\Quadroname}{Chart}\renewcommand{\Quadrosname}{Charts}
\renewcommand{\thname}{Theorem}
\renewcommand{\lmname}{Lemma}
\renewcommand{\prname}{Proposition}
\renewcommand{\crname}{Corollary}
\renewcommand{\aptname}{Assumption}
\renewcommand{\dfname}{Definition}
\renewcommand{\axname}{Axiom}
\renewcommand{\cjcname}{Conjecture}
\renewcommand{\prpname}{Property}
\renewcommand{\expname}{Example}
\renewcommand{\excname}{Exercise}
\renewcommand{\prbname}{Problem}
\renewcommand{\sltname}{Solution}
\renewcommand{\rmname}{Remark}
\renewcommand{\proofname}{Proof}
\renewcommand{\nocitation}{No citations.}
\renewcommand{\citedp}{Cit. on p.}
\renewcommand{\citedpp}{Cit. on pp.}
\renewcommand{\nomBname}{Roman letters}
\renewcommand{\nomCname}{Greek letters}
}
\AtBeginDocument{
\IfStrEq{\idioma}{brazil}
{\selectlanguage{brazil}}{\selectlanguage{english}}
}
% ---

% ------------------------------------------------------------------------
% Informações do trabalho
% ------------------------------------------------------------------------

% Autores
\newcommand{\autori}[3][]{\def\autorinome{#2}\def\autorisobrenome{#3}}
\newcommand{\autorii}[3][]{\def\autoriinome{#2}\def\autoriisobrenome{#3}}

% Código Cutter
\newcommand{\numerocutter}[1]{\def\imprimircutter{#1}}

% Orientadores
\renewcommand{\orientador}[4][]{\def\orientname{#1}\def\orienttitulo{#2}\def\orientnome{#3}\def\orientsobrenome{#4}}
\renewcommand{\coorientador}[4][]{\def\coorientname{#1}\def\coorienttitulo{#2}\def\coorientnome{#3}\def\coorientsobrenome{#4}}

% Tipo de trabalho
\newcommand{\tipocurso}[1]{\def\imprimircurso{#1}}

% Informação adicional do trabalho
\newcommand{\publicacao}[1]{\def\imprimirpublicacao{#1}}

% Instituição
\renewcommand{\instituicao}[3][]{\def\instituicaoi{#1}\def\instituicaoii{#2}\def\instituicaoiii{#3}}

% data
\newcommand{\dia}[1]{\def\imprimirdia{#1}}
\newcommand{\mes}[1]{\def\imprimirmes{#1}}
\newcommand{\ano}[1]{\def\imprimirano{#1}}

% Membros da banca
\newcommand{\membrodabancai}[1]{\def\membrodabancainome{#1}}
\newcommand{\membrodabancaii}[1]{\def\membrodabancaiinome{#1}}
\newcommand{\membrodabancaiii}[1]{\def\membrodabancaiiinome{#1}}
\newcommand{\membrodabancaiv}[1]{\def\membrodabancaivnome{#1}}
\newcommand{\membrodabancav}[1]{\def\membrodabancavnome{#1}}
\newcommand{\membrodabancaifuncao}[1]{\def\membrodabancaifuncaonome{#1}}
\newcommand{\membrodabancaiifuncao}[1]{\def\membrodabancaiifuncaonome{#1}}
\newcommand{\membrodabancaiiifuncao}[1]{\def\membrodabancaiiifuncaonome{#1}}
\newcommand{\membrodabancaivfuncao}[1]{\def\membrodabancaivfuncaonome{#1}}
\newcommand{\membrodabancavfuncao}[1]{\def\membrodabancavfuncaonome{#1}}

% Palavras-chave
\newcommand{\pchavei}[1]{\def\pchaveinome{#1}}
\newcommand{\kwordi}[1]{\def\kwordinome{#1}}
\newcommand{\pchaveii}[1]{\def\pchaveiinome{#1}}
\newcommand{\kwordii}[1]{\def\kwordiinome{#1}}
\newcommand{\pchaveiii}[1]{\def\pchaveiiinome{#1}}
\newcommand{\kwordiii}[1]{\def\kwordiiinome{#1}}
\newcommand{\pchaveiv}[1]{\def\pchaveivnome{#1}}
\newcommand{\kwordiv}[1]{\def\kwordivnome{#1}}
\newcommand{\pchavev}[1]{\def\pchavevnome{#1}}
\newcommand{\kwordv}[1]{\def\kwordvnome{#1}}
% ---

% ---
% Imprime capa e contracapa
% ---
\RequirePackage{pdfpages}
% Imprime capa
\renewcommand{\imprimircapa}{%
\hypersetup{pageanchor=false}
\begin{adjustwidth}{0cm}{1cm}
  \begin{capa}%
    \begin{center}
    \AddToShipoutPictureBG*{\includegraphics[height=\paperheight]{unbtexcover/capa.pdf}}
    \vspace*{7.5cm}
    {\LARGE\sffamily\bfseries\instituicaoi \\ \instituicaoii \\
    \abntex@ifnotempty{\instituicaoiii}{\instituicaoiii}\par}
    \vfill
    \begin{center}
    % Define o tamanho da fonte do título
    \autotitle[4]{\bfseries\imprimirtitulo}
    \titleformat\bfseries \imprimirtitulo\par
    \end{center}
    \normalfont
    \vfill
    {\Large\autorinome\ \autorisobrenome \\
    \abntex@ifnotempty{\autoriinome}{\autoriinome\ \autoriisobrenome}\par}
    \vfill\vfill
    \color{white}{\sffamily\large\MakeUppercase \imprimirtipotrabalho \\[2pt]
    \MakeUppercase\imprimircurso \\
    % Define o espaçamento vertical entre o nome do curso e o local (Brasília)
    \autotitle[1]{\MakeUppercase\imprimircurso}
    \ifdefined\decvspace \vspace{2pt} \else \vspace{20pt} \fi
    \imprimirlocal \\ \imprimirano\par}
   \end{center}
  \end{capa}
% Reestabelece as margens
\end{adjustwidth}
\cleardoublepage
\hypersetup{pageanchor=true}
\AtEndDocument{\imprimircontracapa}
}
% Imprime contracapa
\newcommand{\imprimircontracapa}{%
\cleardoublepage
\pagestyle{empty}
\if@twoside
\addtocounter{page}{-2}
\ifoddpage\else\ \fi
\else
\addtocounter{page}{-1}
\fi
\hypersetup{pageanchor=false}
\newpage
\includepdf[height=\paperheight]{unbtexcover/contracapa.pdf}
\hypersetup{pageanchor=true}
}
% ---

% ---
% Imprime folha de rosto 
% ---
\renewcommand{\folhaderostocontent}{%
\begin{center}
    {\LARGE\sffamily\bfseries \instituicaoi \\ \instituicaoii \\ 
    \abntex@ifnotempty{\instituicaoiii}{\instituicaoiii}\par}
    \vfill\vfill
\begin{center}
% Define o tamanho da fonte do título
\ifthenelse{\equal{\imprimirtituloestrangeiro}{}}
{\autotitle[4]{\bfseries\imprimirtitulo}{\color{verdeunb}\titleformat\bfseries \imprimirtitulo\par}}
{\autotitle[4]{\bfseries\imprimirtituloestrangeiro}{\color{verdeunb}\titleformat\bfseries \imprimirtituloestrangeiro\par}}
\end{center}
\vfill
{\Large\autorinome\ \autorisobrenome \\
\abntex@ifnotempty{\autoriinome}{\autoriinome\ \autoriisobrenome}\par}
\vfill
\abntex@ifnotempty{\imprimirpreambulo}{%
    \begin{flushright}
    \begin{minipage}{.5\textwidth}
    {\SingleSpacing
    \begin{otherlanguage*}{brazil}
    \imprimirpreambulo
    \end{otherlanguage*}}
    \end{minipage}%
    \end{flushright}
\vfill}%
{\abntex@ifnotempty{\orientnome}{\large \orientname: \orienttitulo\ \orientnome\ \orientsobrenome \\
\abntex@ifnotempty{\coorientnome}{\coorientname: \coorienttitulo\ \coorientnome\ \coorientsobrenome}\par}}
\vfill
{\sffamily\large\abntex@ifnotempty{\imprimirpublicacao}{\imprimirpublicacao \\ \vfill} \imprimirlocal \\ \imprimirano\par}
\end{center}
}
% ---

% ---
% Imprime ficha catalográfica
% ---
% https://bce.unb.br/servicos/elaboracao-de-fichas-catalograficas/
\newcommand{\cutter}{\IfInteger{\imprimircutter}{&}{}}
\renewcommand{\fichacatalografica}{%
\thispagestyle{empty}{%
\ifthenelse{\equal{\imprimirpublicacao}{}}{}{
\begin{OnehalfSpace}
{\noindent\sffamily\large REFERÊNCIA BIBLIOGRÁFICA}\par
\noindent\MakeUppercase\autorisobrenome, \autorinome \ifthenelse{\equal{\autoriinome}{}}{.}{;~\MakeUppercase\autoriisobrenome, \autoriinome.} {\bfseries\StrDel{\imprimirtitulo}{\\}}. \begin{otherlanguage*}{brazil}\imprimirtipotrabalho\ (\imprimircurso)\ifthenelse{\equal{\imprimirpublicacao}{}}{}{,~\imprimirpublicacao} -- \ifthenelse{\equal{\instituicaoiii}{}}{}{\instituicaoiii,~}\instituicaoii, \instituicaoi, \imprimirlocal, \thelastpage~p. \imprimirano.\end{otherlanguage*}
\end{OnehalfSpace}}
\IfInteger{\imprimircutter}{\setlength{\fboxsep}{10pt}}{\setlength{\fboxsep}{18pt}}
\vspace*{\fill}
{\small
{\SingleSpacing
\begin{center}
{\sffamily\large FICHA CATALOGRÁFICA} \\[18pt]
\fbox{\begin{minipage}[t][7.5cm]{12.5cm}
\IfInteger{\imprimircutter}{\begin{tabular}{p{1.25cm} p{10.25cm}}}{} \cutter
\autorisobrenome, \autorinome. \\
\IfInteger{\imprimircutter}{\StrChar{\autorisobrenome}{1}\imprimircutter\StrChar{\imprimirtitulo}{1}[\SUBtemp]\MakeLowercase{\SUBtemp}}{} \cutter
\hspace*{2em}\noindent \StrDel{\imprimirtitulo}{\\} ~/ \begin{otherlanguage*}{brazil}{\autorinome\ \autorisobrenome; \ifthenelse{\equal{\autoriinome}{}}{}{\autoriinome\ \autoriisobrenome;} \MakeLowercase\orientname\ \orientnome\ \orientsobrenome \ifthenelse{\equal{\coorientnome}{}}{.}{;~\MakeLowercase\coorientname\ \coorientnome\ \coorientsobrenome.} \texttt{-{}-} \imprimirlocal, \imprimirano.}\end{otherlanguage*} \\ \cutter
\hspace*{2em}\noindent \thelastpage~p. \\ \cutter
\\ \cutter
\hspace*{2em}\noindent\begin{otherlanguage*}{brazil}\imprimirtipotrabalho\ (\imprimircurso)\ \texttt{-{}-} \instituicaoi, \imprimirano.\end{otherlanguage*} \\ \cutter
\\ \cutter
\hspace*{2em}\noindent\IfStrEq{\idioma}{brazil}{1. \expandafter\MakeUppercase\pchaveinome. 2. \expandafter\MakeUppercase\pchaveiinome. 3. \expandafter\MakeUppercase\pchaveiiinome. \ifthenelse{\equal{\pchaveivnome}{}}{}{4. \expandafter\MakeUppercase\pchaveivnome. \ifthenelse{\equal{\pchavevnome}{}}{}{5. \expandafter\MakeUppercase\pchavevnome.~}}}{1. \expandafter\MakeUppercase\kwordinome. 2. \expandafter\MakeUppercase\kwordiinome. 3. \expandafter\MakeUppercase\kwordiiinome. \ifthenelse{\equal{\kwordivnome}{}}{}{4. \expandafter\MakeUppercase\kwordivnome. \ifthenelse{\equal{\kwordvnome}{}}{}{5. \expandafter\MakeUppercase\kwordvnome.~}}}%
\begin{otherlanguage*}{brazil}{\ifthenelse{\equal{\autoriinome}{}}{\ifthenelse{\equal{\coorientnome}{}}{I. \orientsobrenome, \orientnome, orient. II. Título.}{I. \orientsobrenome, \orientnome, orient. II. \coorientsobrenome, \coorientnome, coorient. III. Título.}}{\ifthenelse{\equal{\coorientnome}{}}{I. \autoriisobrenome, \autoriinome. II. \orientsobrenome, \orientnome, orient. III. Título.}{I. \autoriisobrenome, \autoriinome. II. \orientsobrenome, \orientnome, orient. III. \coorientsobrenome, \coorientnome, coorient. IV. Título.}}}\end{otherlanguage*}
\IfInteger{\imprimircutter}{\end{tabular}}{}
\end{minipage}}
\end{center}
}}
\newpage
}}
% ---

% ---
% Imprime folha de aprovação
% ---
\newcommand{\signlinewidth}[1]{\setlength{\ABNTEXsignwidth}{#1}}
\newcommand{\imprimirfolhadeaprovacao}{%
\begin{folhadeaprovacao}
\begin{center}
    {\Large\sffamily\bfseries\instituicaoi \\ \instituicaoii \\
    \abntex@ifnotempty{\instituicaoiii}{\instituicaoiii}\par}
    \vfill
    \begin{center}
    % Define o tamanho da fonte do título
    \autotitle[1]{\bfseries\StrDel{\imprimirtitulo}{\\}}
    \ifthenelse{\equal{\titleformat}{\large}}
    {\color{verdeunb}\Large\bfseries \StrDel{\imprimirtitulo}{\\}\par}
    {\color{verdeunb}\titleformat\bfseries \StrDel{\imprimirtitulo}{\\}\par}
    \end{center}
    \vfill
{\large\autorinome\ \autorisobrenome \\[2pt]
\abntex@ifnotempty{\autoriinome}{\autoriinome\ \autoriisobrenome}\par}
\vfill
\abntex@ifnotempty{\imprimirpreambulo}{%
    \begin{flushright}
    \begin{minipage}{.5\textwidth}
    {\SingleSpacing
    \begin{otherlanguage*}{brazil}
    \imprimirpreambulo
    \end{otherlanguage*}}
    \end{minipage}%
    \end{flushright}
}%
\vspace{24pt}
\raggedright{Trabalho aprovado. \imprimirlocal, \imprimirdia\ de \imprimirmes\ de \imprimirano:}
{%
    \assinatura{\textbf{\membrodabancainome} \\ \membrodabancaifuncaonome} 
    \assinatura{\textbf{\membrodabancaiinome} \\ \membrodabancaiifuncaonome} 
    \assinatura{\textbf{\membrodabancaiiinome} \\ \membrodabancaiiifuncaonome} 
    \abntex@ifnotempty{\membrodabancaivnome}{\assinatura{\textbf{\membrodabancaivnome} \\ \membrodabancaivfuncaonome}}
    \abntex@ifnotempty{\membrodabancavnome}{\assinatura{\textbf{\membrodabancavnome} \\ \membrodabancavfuncaonome}}
}
\end{center}
\end{folhadeaprovacao}
\cleardoublepage
}
% ---

\RequirePackage{scontents}
% ---
% Imprime dedicatória
% ---
\newenvsc{DedicatoriaAutorI}[store-env=dedicatoriaautori]
\newenvsc{DedicatoriaAutorII}[store-env=dedicatoriaautorii]

\newcommand{\imprimirdedicatoria}{
\begin{dedicatoria}
\centering
\vspace*{\fill}
% Primeiro autor
{\itshape\getstored{dedicatoriaautori}}\par
\ifthenelse{\equal{\autoriinome}{}}{}{
\vspace{\baselineskip}
\autorinome\ \autorisobrenome \par
\vspace*{\fill}
% Segundo autor
{\itshape\getstored{dedicatoriaautorii}}\par
\vspace{\baselineskip}
\autoriinome\ \autoriisobrenome
}
\vspace*{\fill}
\end{dedicatoria}
\cleardoublepage
}
% ---

% ---
% Imprime agradecimentos
% ---
\newenvsc{AgradecimentosAutorI}[store-env=agradecimentosautori]
\newenvsc{AgradecimentosAutorII}[store-env=agradecimentosautorii]

\newcommand{\idiomaagradecimentos}[1]{\def\acklang{#1}}
\newcommand{\imprimiragradecimentos}{
% Define o título da seção de agradecimentos
\IfStrEq{\acklang}{brazil}{
\renewcommand{\agradecimentosname}{Agradecimentos}
}{% Caso os agradecimentos sejam escritos em inglês
\renewcommand{\agradecimentosname}{Acknowledgements}}
\begin{agradecimentos}
% Primeiro autor
\getstored{agradecimentosautori}\par
\vspace{\baselineskip}
\ifthenelse{\equal{\autoriinome}{}}{}{
\hfill \autorinome\ \autorisobrenome \par
\vspace{2\baselineskip}
% Segundo autor
\getstored{agradecimentosautorii}\par
\vspace{\baselineskip}
\hfill \autoriinome\ \autoriisobrenome
}
\end{agradecimentos}
\cleardoublepage
}
% ---

% ---
% Imprime epígrafe
% ---
\newenvsc{Epigrafe}[store-env=epigrafe]
\newcommand{\imprimirepigrafe}{
\begin{epigrafe}
\getstored{epigrafe}\par
\end{epigrafe}
\cleardoublepage
}
% ---

% ---
% Imprime resumo e abstract
% ---
\setlength{\absparsep}{\parsep}
\ifthenelse{\equal{\ABNTEXisarticle}{false}}
{\setlength{\abstitleskip}{\baselineskip}}{\setlength{\abstitleskip}{-0.5\baselineskip}}
% Resumo
\newenvsc{Resumo}[store-env=resumo]
\newcommand{\imprimirresumo}{
\begin{resumo}[Resumo]
\begin{otherlanguage*}{brazil}
\getstored{resumo}\par
\vspace{\baselineskip}
{\sffamily\bfseries Palavras-chave:} \pchaveinome; \pchaveiinome; \pchaveiiinome\ifthenelse{\equal{\pchaveivnome}{}}{.}{;~\pchaveivnome\ifthenelse{\equal{\pchavevnome}{}}{.}{;~\pchavevnome.}}
\end{otherlanguage*}
\end{resumo}
\PRIVATEclearpageifneeded
}
% Abstract
\newenvsc{Abstract}[store-env=abstract]
\newcommand{\imprimirabstract}{
\begin{resumo}[Abstract]
\begin{otherlanguage*}{english}
\getstored{abstract}\par
\vspace{\baselineskip}
{\sffamily\bfseries Keywords:} \kwordinome; \kwordiinome; \kwordiiinome\ifthenelse{\equal{\kwordivnome}{}}{.}{;~\kwordivnome\ifthenelse{\equal{\kwordvnome}{}}{.}{;~\kwordvnome.}}
\end{otherlanguage*}
\end{resumo}
\PRIVATEclearpageifneeded
}
% Insere resumo e abstract
\newcommand{\imprimirresumos}{
\IfStrEq*{\idioma}{brazil}
{\imprimirresumo
\imprimirabstract}
{\imprimirabstract
\imprimirresumo}
}
% ---

% ---
% Imprime lista de figuras
% ---
\newcommand{\imprimirlistadefiguras}{
\pdfbookmark[0]{\listfigurename}{lof}
\listoffigures*
\PRIVATEclearpageifneeded
}
% ---

% ---
% Imprime lista de quadros
% ---
\newcommand{\imprimirlistadequadros}{
\pdfbookmark[0]{\listquadroname}{loq}
\listofquadros*
\PRIVATEclearpageifneeded
}
% ---

% ---
% Imprime lista de tabelas
% ---
\newcommand{\imprimirlistadetabelas}{
\pdfbookmark[0]{\listtablename}{lot}
\listoftables*
\PRIVATEclearpageifneeded
}
% ---

% ---
% Imprime lista de algoritmos
% ---
\newcommand{\imprimirlistadealgoritmos}{
\pdfbookmark[0]{\listalgorithmcfname}{loa}
\listofalgorithms
\PRIVATEclearpageifneeded
}
% ---

% ---
% Imprime lista de códigos
% ---
\newcommand{\imprimirlistadecodigos}{
\pdfbookmark[0]{\lstlistlistingname}{lol}
\begin{KeepFromToc} % Não inclui a lista de códigos no sumário
\lstlistoflistings
\end{KeepFromToc}
\PRIVATEclearpageifneeded
}
% ---

% ---
% Imprime lista de abreviaturas e siglas e lista de símbolos
% ---
\newcommand{\imprimirlistadesiglasesimbolos}{
\PRIVATEbookmarkthis{\listadesiglasname}
\printnomenclature
\PRIVATEclearpageifneeded
}
% ---

% ---
% Imprime sumário
% ---
\newcommand{\imprimirsumario}{
\pdfbookmark[0]{\contentsname}{toc}
\tableofcontents*
\PRIVATEclearpageifneeded
}
% ---

% ---
% Define o tamanho da fonte tipográfica do título
% ---
\newbox\testbox
\newdimen\testblskip
\newcommand*{\testlines}[1]{%
    \setbox\testbox\hbox to\textwidth{\vbox{\centering\testfontsize #1\global\testblskip\baselineskip\par}}%
}
\newcommand*{\autotitle}[2][]{% \autotitle{número de linhas}{texto do título}
% \huge
    \let\testfontsize\huge\sffamily\testlines{#2}%
    \ifdim\ht\testbox>#1\testblskip
% \LARGE
        \let\testfontsize\LARGE\sffamily\testlines{#2}%
        \ifdim\ht\testbox>#1\testblskip
% \Large
            \let\testfontsize\Large\sffamily\testlines{#2}%
            \ifdim\ht\testbox>#1\testblskip
% \large
                \let\testfontsize\large\sffamily\testlines{#2}%
                \ifdim\ht\testbox>#1\testblskip
                    \newcommand{\decvspace}{}
                \fi
            \fi
        \fi
    \fi
    \newcommand{\titleformat}{\testfontsize}
}
% ---

% ---
% Configuracoes para definir idioma principal do documento
% ---
\def\HyLang@DeclareLang#1#2#3{%
    \expandafter\HyLang@addto
        \csname extras#1\expandafter\endcsname
        \csname HyLang@#2\endcsname
    \begingroup
      \edef\x{\endgroup
        #3%
      }%
    \x
    \@namedef{HyLang@#1@done}{}%
  \begingroup
    \edef\x##1##2{%
      \noexpand\ifx##2\relax
        \errmessage{No definitions for language #2' found!}%
      \noexpand\fi
      \endgroup
      \noexpand\define@key{Hyp}{#1}[]{%
        \noexpand\@ifundefined{HyLang@#1@done}{%
          \noexpand\HyLang@addto{\noexpand##1}{\noexpand##2}%
          #3%
          \noexpand\@namedef{HyLang@#1@done}{}%
        }{}%
      }%
    }%
  \expandafter\x\csname extras#1\expandafter\endcsname
                \csname HyLang@#2\endcsname
}
\HyLang@DeclareLang{english}{english}{}
\HyLang@DeclareLang{brazil}{portuges}{}
\HyLang@DeclareLang{brazilian}{portuges}{}
\HyLang@DeclareLang{portuguese}{portuges}{}
% ---