%Copyright (c) 2006 Rice University
%All Rights Reserved
%This code is covered by the Rice-WARP license
%See http://warp.rice.edu/license/ for details

%% WARPdoc Documentation class file

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{WARPdoc}

% gbmidd adding the following:
\usepackage{color}
\usepackage{graphicx}
\definecolor{WARPBlue}{rgb}{0.004,0.29,0.57}

\usepackage[pdftex,
						pdfpagelayout = useoutlines,
						bookmarks,
						bookmarksopen = true,
						bookmarksnumbered = true,
						breaklinks = true,
						linktocpage,
						backref,
						colorlinks = true,
						linkcolor = blue,
						urlcolor = blue,
						citecolor = blue,
						anchorcolor = green,
						hyperindex = true,
						hyperfigures]{hyperref}


% end gbmidd additions


% Define commands relevant to the titling
\renewcommand{\rmdefault}{phv} % Switch to Helvetica !
\newcommand\@ptsize{}
\newcommand{\footruleskip}{\normalbaselineskip}

\newcommand\@version{\relax}
\newcommand\@tversion{\relax}
\newcommand\version[1]{\renewcommand\@version{\textnormal{#1}}%
                       \renewcommand\@tversion{\par\textnormal{#1}}}
\newcommand\@organization{\relax}
\newcommand\@torganization{\relax}
\newcommand\organization[1]{\renewcommand\@organization{\textnormal{#1}}%
                       \renewcommand\@torganization{\par\textnormal{#1}}}
\newcommand\@confidential{\relax}
\newcommand\@tconfidential{\relax}
\newcommand\confidential[1]{\renewcommand\@confidential{\textnormal{#1}}
                            \renewcommand\@tconfidential{\par\textbf{#1}}}
\newcommand\fullcenter[1]{\hbox to\linewidth{\hss\hbox to\fullwidth{\parbox[c]{\fullwidth}{\begin{center}#1\end{center}}}}}

\newif\if@restonecol
\newif\if@titlepage
\@titlepagefalse

\if@compatibility\else
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\fi


\if@compatibility
  \renewcommand\@ptsize{0}
\else
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi

\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi

\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}

\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi

\DeclareOption{titlepage}{\@titlepagetrue}

\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi

\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi

\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\DeclareOption{twocolumn}{%
    \ClassError{WARPdoc2a}
    {There is no twocolumn layout in this class}
    {Please remove the 'twocolumn' attribute in the document class declaration}
    \@twocolumnfalse}

\ExecuteOptions{letterpaper,10pt,oneside,onecolumn,final}
\ProcessOptions
\input{size1\@ptsize.clo}

\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\setlength\headsep {.5in}  %{\baselineskip}
\setlength\parskip{0\p@ \@plus \p@}
\renewcommand\baselinestretch{}

\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

\setlength\oddsidemargin{.75in}
\setlength\textwidth{6in}
\setlength\textheight{9in}
\setlength\headsep{.5in}
\setlength\topmargin{-.6in}

\newdimen\fullwidth
\setlength\fullwidth\textwidth
\addtolength\fullwidth{1in}
\newdimen\leftmarginwidth
\setlength\leftmarginwidth\oddsidemargin

\setlength{\pdfpagewidth}{\paperwidth}
\setlength{\pdfpageheight}{\paperheight}

\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}

\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}

\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}

\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}


%\def\ps@headings{%
%    \let\@oddfoot\@empty
%    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
%    \let\@mkboth\markboth
%    \def\sectionmark##1{%
%      \markright {\MakeUppercase{%
%        \ifnum \c@secnumdepth >\m@ne
%          \thesection\quad
%        \fi
%        ##1}}}}
%
%
%
%\def\ps@myheadings{%
%    \let\@oddfoot\@empty\let\@evenfoot\@empty
%    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
%    \def\@oddhead{\vspace{-1in}{\slshape\rightmark}\hfil\thepage}%
%    \let\@mkboth\@gobbletwo
%    \let\sectionmark\@gobble
%    \let\subsectionmark\@gobble
%    }

% Make the titlepage if required
\if@titlepage
  \renewcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \null\vskip 70\p@
  \begin{centering}
  	\hskip -30\p@
  	\includegraphics[scale=1.5]{warplogo}
  \end{centering}
  \vskip 70\p@
  \longthickrule\vskip1.5em%
 	
  \fullcenter{\LARGE \textbf \@title}%
  \vskip1.5em\longthickrule%	
  \vskip 3em%
  \fullcenter{\large
   \lineskip .75em%
    \begin{tabular}[t]{c}%
      \@author
    \end{tabular}%
    \vskip 1.5em
    \@torganization\@tconfidential
    \vskip 1.5em
    Document Revision \@version
    \par}%
    \vskip 1.5em%
  \fullcenter{\large \@date \par}%       % Set date in \large size.
  \par
  \fullcenter{\@thanks}
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@date\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
  \renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
   \thispagestyle{empty}\@thanks
  \endgroup

  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@date\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}


\def\@maketitle{%
    \newpage
    %\null
    \flushright{\includegraphics[scale=1]{warplogo}}
    \hbox to\linewidth{\hss\hbox to\fullwidth{\makebox[\fullwidth][c]{\@tconfidential}}}
    \longthickrule\vskip1.5em%
    {\secshape \parskip\z@ \parindent\z@
    \Large\bfseries \@title \par}%
    \vskip1.5em\longthickrule\vskip1.5em%
    {\normalsize
      \lineskip .5em%
      \begin{flushright}%
        {\slshape\@author\@torganization\par}
        \vskip 1em%
        {\@date}%
      \end{flushright}\par}%
    \vskip 1.5em}

\fi

\setcounter{secnumdepth}{3}

\newcounter {part}
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]

\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thesection {\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}

\newcommand\part{%
   \if@noskipsec \leavevmode \fi
   \par
   \addvspace{4ex}%
   \@afterindentfalse
   \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >\m@ne
       \Large\bfseries \partname~\thepart
       \par\nobreak
     \fi
     \huge \bfseries #2%
     \markboth{}{}\par}%
    \nobreak
    \vskip 3ex
    \@afterheading}

\def\@spart#1{%
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \huge \bfseries #1\par}%
     \nobreak
     \vskip 3ex
     \@afterheading}

\newcommand\secshape{\leftskip=-\leftmarginwidth%
                     \rightskip=\@flushglue%
                     \hyphenpenalty=2000}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\secshape\normalfont\Large\bfseries}}

\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\secshape\normalfont\large\bfseries}}

\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\secshape\normalfont\normalsize\bfseries}}

\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}

\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}

\setlength\leftmargini  {2.5em}

\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}

\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty

\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}

\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}

\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}

\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}

\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}

\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment{abstract}{%
  \small
    \begin{center}%
      {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
    \end{center}%
    \quotation
     }
    \endquotation

\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}

\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}

\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}


\if@compatibility
\newenvironment{titlepage}
    {%
      \@restonecolfalse\newpage
      \thispagestyle{empty}%
      \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
    }
\else
\newenvironment{titlepage}
    {%
      \@restonecolfalse\newpage
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\fi

\renewcommand\appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \gdef\thesection{\@Alph\c@section}}
  
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}

\renewcommand \theequation {\@arabic\c@equation}

\newcounter{figure}
\renewcommand \thefigure {\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}

\newenvironment{figure}
               {\@float{figure}}
               {\end@float}

\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}
\renewcommand\thetable{\@arabic\c@table}

\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}

\newenvironment{table}
               {\@float{table}}
               {\end@float}

\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}

\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}

\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}

\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{3}
\newcommand\tableofcontents{%
    \section*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    \if@titlepage
    	\pagebreak
    \fi
    }

\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty\@secpenalty
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
       \if@compatibility
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
      \fi
    \endgroup
  \fi}
\newcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \addvspace{1.0em \@plus\p@}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}

\newcommand*\l@subsection{\@dottedtocline{2}{1.5em}{2.3em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{7.0em}{4.1em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{10em}{5em}}
\newcommand\listoffigures{%
    \section*{\listfigurename
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}%
    \@starttoc{lof}%
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \section*{\listtablename
      \@mkboth{%
          \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
    \@starttoc{lot}%
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}

\newenvironment{thebibliography}[1]
     {\section*{\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\renewcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\section*{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}

\def\longrule{\color{WARPBlue} \hbox to \linewidth{\hss
              \vrule width \fullwidth height 1.0\p@ depth \z@} \color{black}}
\def\longthickrule{\par \color{WARPBlue} \hbox to \linewidth{\hss
              \vrule width \fullwidth height 3.0\p@ depth \z@}\color{black}\par}

\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\refname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}

\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

\def\shortday{\number\day-\ifcase\month\or Jan\or Feb\or Mar\or Apr\or May\or Jun\or
  Jul\or Aug\or Sep\or Oct\or Nov\or Dec\fi
  -\number\year}

\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}

\pagestyle{plain}
\pagenumbering{arabic}

\def\@oddhead{\vbox{\hbox to\linewidth{\hss\hbox to\fullwidth{
      {\rlap{\parbox[b]{\textwidth}{\raggedright{\bf{\@title}}}}\hfill%
      \parbox[b]{\textwidth}{\centering{\@confidential}}\hfill%
      \llap{\parbox[b]{\textwidth}{\raggedleft{\includegraphics[scale=.5]{warplogo}}}}}}}%
      \vskip  1.0\p@ \longrule }}

\def\@oddfoot{\vbox{\vskip-\footruleskip%
      \longrule%\vskip-1in%1.0\p@%
      \vskip-.25in%
      \hbox to\linewidth{\hss\hbox to\fullwidth{%
      {\rlap{\parbox[t]{\textwidth{\raggedright{\footnotesize{ver. \@version : \shortday}}}}}\hfill%
      \parbox[t]{1\fullwidth}{\centering{\footnotesize{\href{http://warp.rice.edu}{http://warp.rice.edu}}}}\hfill%
      \llap{\parbox[t]{\textwidth}{\raggedleft{\thepage}}}}}}}}

\def\@evenfoot{\@oddfoot}
\def\@evenhead{\@oddhead}


\raggedbottom

\onecolumn
\endinput