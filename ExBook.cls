\def\fileversion{1.0}
\def\filedate{2024/12/30}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ExBook}[\filedate\space Version \fileversion\space by
 MA WEI JIAN]
 
 %                         *****************
 %                         **   宏包选项   **
 %                         *****************
 
 
 % 文档类支持以下宏包选项:
 
 % adobe 使用adobe字体
 % ubuntu 使用ubuntu字体
 % windows 使用windows字体
 % fandol 使用fandol字体，随texlive默认安装
 % mac 使用mac字体
 % list 以列表项目格式显示试题
 % twocolumn 使用A3纸张并分栏
  

\newcommand\@fontset{windows}
\DeclareOption{adobe}{\renewcommand\@fontset{adobe}}
\DeclareOption{ubuntu}{\renewcommand\@fontset{ubuntu}}
\DeclareOption{mac}{\renewcommand\@fontset{mac}}
\DeclareOption{windows}{\renewcommand\@fontset{windows}}
\DeclareOption{fandol}{\renewcommand\@fontset{fandol}}


\newif\if@list  \@listfalse
\DeclareOption{list}{\@listtrue}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage[fontset = \@fontset, punct=kaiming]{ctex}
\ctexset{linestretch = 4, autoindent = 0pt}


%                    *****************************
%                    **        加载其他宏包       **
%                    *****************************

\RequirePackage{tabularx, ifthen} % 排选项用
\RequirePackage{xcolor,graphicx,caption} % 彩色、图片、图释
\RequirePackage{geometry,fancyhdr} % 纸张、边距、页眉、页脚
\RequirePackage{etoolbox} 
\RequirePackage{amsmath,amsmath,amssymb} % ams数学相关
\RequirePackage{unicode-math}
\RequirePackage{pifont} % 带圈数字\ding
\RequirePackage{bbding} % 图案
\RequirePackage{romannum} % 罗马数字
\RequirePackage{enumitem}
\RequirePackage{listings} % 代码
\RequirePackage{tikz} % 绘图
\RequirePackage{titletoc} % 目录
\RequirePackage{titlesec} % 标题
\RequirePackage{hyperref} 
\RequirePackage{afterpage} 
\RequirePackage{zhnumber} 
\RequirePackage{fontspec} 
\RequirePackage{pifont} 
\RequirePackage{lastpage} 
\RequirePackage{titling} 
\RequirePackage{adjustbox} 
\RequirePackage{fontawesome5} 
\RequirePackage{multicol} 
\RequirePackage{bm} 
\RequirePackage{fontawesome5} 
\RequirePackage{fontawesome5} 
\usetikzlibrary{fadings}
\usetikzlibrary{shapes, positioning}

\punctstyle{quanjiao} % 全角（主要是为了让中文逗号占满一个字符的宽度）

\hypersetup {colorlinks=true,linkcolor=black}

%                         *****************
%                         **   页面设置   **
%                         *****************


\AtBeginDocument{
	\pagenumbering{arabic}  % 使用阿拉伯数字页码
	\geometry{a4paper,left=20mm,right=20mm,top=25mm,bottom=25mm, headheight=20mm}
}



%
% 图释
%
\captionsetup[figure]{font=small,belowskip=0pt}


%                    ***************************
%                    **    试题、解答环境定义   **
%                    ***************************

\newcounter{Question}

\newif\if@showscore
\@showscorefalse
\newif\if@showskip
\@showskipfalse
\newif\if@showparen
\@showparenfalse
\newif\if@resetcounter
\@resetcounterfalse
\newlength{\myvertspace}


% 定义试题环境
\newenvironment{questions}[1][]{
	\@tfor \@opt :=#1\do
		{\if\@opt s\global\@showscoretrue\fi
		 \if\@opt t\global\@showskiptrue\fi
	 	 \if\@opt p\global\@showparentrue\fi
 	 	 \if\@opt r\global\@resetcountertrue\fi}
  	\if@resetcounter
  		\setcounter{Question}{0}
	 \fi
	\if@list
		\list{\arabic{Question}.}{\setlength{\leftmargin}{0pt}}
	\else
		\par \begingroup \par
	\fi
}{
	\if@list
		\endlist
	\else
		\par \endgroup \par
	\fi
	
	\global\@showscorefalse
	\global\@showskipfalse
	\global\@showparenfalse
}

% 定义新增试题命令
\newcommand{\question}[1][0]{
	\stepcounter{Question}
	\if@list
		\item \if@showscore \kaishu ( #1 分) \songti \fi
	\else
		\vspace{2mm}

		% 【\textcolor{black!50}{\kaishu {研小布}} \labelitemi \;\textbf{\arabic{Question}}】
		% \textbf{\arabic{Question}}.
		\arabic{Question}.
		\if@showscore \kaishu ( #1 分) \songti \fi
	\fi
}

% 定义小问环境
\newlist{subquestions}{enumerate}{2}
\setlist[subquestions,1]{label=(\arabic*)}
\setlist[subquestions,2]{label=(\roman*)}

% 定义新增小问命令
\newcommand{\subquestion}{\item} 

\newenvironment{solution}[1]{
	\setlength{\myvertspace}{#1}
	\vspace*{\myvertspace}
}{

}



\newlength{\choicelengtha}
\newlength{\choicelengthb}
\newlength{\choicelengthc}
\newlength{\choicelengthd}
\newlength{\choicelengthe}
\newlength{\maxlength}

% 三个选项
\newcommand{\threechoices}[3]{
	\if@showparen \dotfill (\qquad) \fi
	\par
	\settowidth{\choicelengtha}{A.~#1~~~}
	\settowidth{\choicelengthb}{B.~#2~~~}
	\settowidth{\choicelengthc}{C.~#3~~~}

	\ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
	\ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
	\ifthenelse{\lengthtest{\maxlength>0.4\linewidth}}
	{
		\begin{tabularx}{\linewidth}{X}
			\setlength\tabcolsep{0pt}
			A.~#1~~~\\
			B.~#2~~~\\
			C.~#3~~~\\
		\end{tabularx}
	}%
	{
		\ifthenelse{\lengthtest{\maxlength>0.2\linewidth}}
		{
			\begin{tabularx}{\linewidth}{XX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~ & B.~#2~~~\\
				C.~#3~~~ & \\
			\end{tabularx}
		}%
		{
			\begin{tabularx}{\linewidth}{XXXX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~  & B.~#2~~~ & C.~#3~~~ &\\ 
			\end{tabularx}
		}
	}
	\unskip \unskip 
}

% 四个选项
\newcommand{\fourchoices}[4]{
	\if@showparen \dotfill (\qquad) \fi
	\par
	\settowidth{\choicelengtha}{A.~#1~~~}
	\settowidth{\choicelengthb}{B.~#2~~~}
	\settowidth{\choicelengthc}{C.~#3~~~}
	\settowidth{\choicelengthd}{D.~#4~~~}
	\ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
	\ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
	\ifthenelse{\lengthtest{\choicelengthd>\maxlength}}{\setlength{\maxlength}{\choicelengthd}}{}
	\ifthenelse{\lengthtest{\maxlength>0.4\linewidth}}
	{
		\begin{tabularx}{\linewidth}{X}
			\setlength\tabcolsep{0pt}
			A.~#1~~~\\
			B.~#2~~~\\
			C.~#3~~~\\
			D.~#4~~~\\
		\end{tabularx}
	}%
	{
		\ifthenelse{\lengthtest{\maxlength>0.2\linewidth}}
		{
			\begin{tabularx}{\linewidth}{XX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~ & B.~#2~~~\\
				C.~#3~~~ & D.~#4~~~\\
			\end{tabularx}
		}%
		{
			\begin{tabularx}{\linewidth}{XXXX}
				\setlength\tabcolsep{0pt}
				A.~#1.~~~  & B.~#2~~~ & C.~#3~~~ & D.~#4~~~\\ 
				% A.~#1~~~  & B.~#2~~~ & C.~#3~~~ & D.~#4~~~\\ 
			\end{tabularx}
		}%
	}
	\unskip \unskip 
}

% 五个选项
\newcommand{\fivechoices}[5]{
	\if@showparen \hfill \dotfill (\quad) \fi
	\par
	\settowidth{\choicelengtha}{A.~#1~~~}
	\settowidth{\choicelengthb}{B.~#2~~~}
	\settowidth{\choicelengthc}{C.~#3~~~}
	\settowidth{\choicelengthd}{D.~#4~~~}
	\settowidth{\choicelengthe}{E.~#5~~~}
	\ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
	\ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
	\ifthenelse{\lengthtest{\choicelengthd>\maxlength}}{\setlength{\maxlength}{\choicelengthd}}{}
	\ifthenelse{\lengthtest{\choicelengthe>\maxlength}}{\setlength{\maxlength}{\choicelengthe}}{}
	\ifthenelse{\lengthtest{\maxlength>0.4\linewidth}}{
		\begin{tabularx}{\linewidth}{X}
			\setlength\tabcolsep{0pt}
			A.~#1~~~\\
			B.~#2~~~\\
			C.~#3~~~\\
			D.~#4~~~\\
			E.~#5~~~\\
		\end{tabularx}
	}%
	{
		\ifthenelse{\lengthtest{\maxlength>0.2\linewidth}}
		{
			\begin{tabularx}{\linewidth}{XX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~ & B.~#2~~~\\
				C.~#3~~~ & D.~#4~~~\\
				E.~#5~~~ &         \\
			\end{tabularx}
		}%
		{
			\begin{tabularx}{\linewidth}{XXXX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~  & B.~#2~~~ & C.~#3~~~ & D.~#4~~~ \\
				E.~#5~~~  &          &          &          \\
			\end{tabularx}
		}
	}%
	\unskip \unskip 
}

% 六个选项
\newcommand{\sixchoices}[6]{
	\if@showparen \hfill \dotfill (\quad) \fi
	\par
	\settowidth{\choicelengtha}{A.~#1~~~}
	\settowidth{\choicelengthb}{B.~#2~~~}
	\settowidth{\choicelengthc}{C.~#3~~~}
	\settowidth{\choicelengthd}{D.~#4~~~}
	\settowidth{\choicelengthe}{D.~#5~~~}
	\ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
	\ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
	\ifthenelse{\lengthtest{\choicelengthd>\maxlength}}{\setlength{\maxlength}{\choicelengthd}}{}	\ifthenelse{\lengthtest{\choicelengthe>\maxlength}}{\setlength{\maxlength}{\choicelengthe}}{}
	
	\ifthenelse{\lengthtest{\maxlength>0.4\linewidth}}
	{
		\begin{tabularx}{\linewidth}{X}
			\setlength\tabcolsep{0pt}
			A.~#1~~~\\
			B.~#2~~~\\
			C.~#3~~~\\
			D.~#4~~~\\
			E.~#5~~~\\
			F.~#6~~~\\
		\end{tabularx}
	}%
	{
		\ifthenelse{\lengthtest{\maxlength>0.2\linewidth}}
		{
			\begin{tabularx}{\linewidth}{XX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~ & B.~#2~~~\\
				C.~#3~~~ & D.~#4~~~\\
				E.~#5~~~ & F.~#6~~~\\
			\end{tabularx}
		}%
		{
			\begin{tabularx}{\linewidth}{XXXX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~  & B.~#2~~~ & C.~#3~~~ & D.~#4~~~ \\
				E.~#2~~~  & F.~#6~~~ &          &          \\
			\end{tabularx}
		}%
	}
	\unskip \unskip 
}


% 定义一个变量，用于选择页面格式，0表示紧凑版，1表示标准版，2表示横版
\newcommand{\myPageFormat}{1}

% 封面使用的标题文字
\newcommand{\Titile}{\heiti 408WD}
\newcommand{\TitileDescription}{数据结构\, 选择题刷题本}
\newcommand{\RedBook}{小红书·石头剪刀布（ID：4131632984）}
\newcommand{\VersionText}{2025版}
\newcommand{\TypeOne}{A4紧凑版}
\newcommand{\TypeTwo}{A4标准版}
\newcommand{\TypeThree}{横版Pad版}

% 定义字符串宏，用来自定义页眉
\newcommand{\Lhead}{微信公众号·研小布} % 封面也适用
\newcommand{\LheadC}{公众号·研小布·}
\newcommand{\Chead}{25考研} % 封面也适用
\newcommand{\Rhead}{408WD数据结构选择题刷题本}

\newlength{\mylength} % 定义一个长度，该长度为每个题目后面的空闲高度
\newcommand{\blankbox}{(\hspace{1.2em})} % 空括号，或者使用 \quad 替代 \hspace{1cm}
\newcommand{\mycustomtext}{\textcolor{black!38}{\selectfont 【微信公众号·研小布】}}
\newcommand{\qanswerloc}[1]{\textcolor{themeColor}{\selectfont \ding{226} 此部分答案见原书P#1}}
\newcommand{\qnum}{\textcolor{black}{\selectfont \textbf{一、单项选择题}}}

\newcommand{\preBookName}{\textcolor{black}{\selectfont 2025 版 408 王道数据结构考研复习指导}}

\setmainfont{Times New Roman} % 设置全局英文字体为 Times New Roman
% \setCJKmainfont{STSong} % 设置中文字体为宋体
\setmathfont{Times New Roman}

\definecolor{themeColor}{HTML}{015697} % 自定义颜色 蓝色
% \definecolor{themeColor}{HTML}{01847c} % 自定义颜色 绿色 
% \definecolor{themeColor}{HTML}{61589b} % 自定义颜色 紫色
% \definecolor{themeColor}{HTML}{f98919} % 自定义颜色 橙色

% \definecolor{themeColor}{HTML}{3f8827} % 自定义颜色

% \renewcommand{\cftdotsep}{1} % 调整点的密度，可以根据需要设置

\renewcommand\arraystretch{1.3}  % 表格行高
\renewcommand{\baselinestretch}{1.3} % 设置行间距

% listings代码样式
\lstset{
%   language=C, % 设置默认语言
%   basicstyle=\ttfamily\small, % 设置基本字体样式
    % keywordstyle=\color{blue}, % 设置关键字样式
    % commentstyle=\color{green!40!black}, % 设置注释样式
    % stringstyle=\color{orange}, % 设置字符串样式
%   numbers=left, % 行号显示在左侧
%   numberstyle=\tiny\color{gray}, % 行号样式
%   stepnumber=1, % 每隔一行显示行号
    breaklines=true, % 自动换行
%   frame=single, % 设置代码框
%   backgroundcolor=\color{gray!10}, % 设置背景颜色
%   captionpos=b, % 设置标题位置为底部
    language=C, 
    % numbers=left, 
    basicstyle=\ttfamily, 
    backgroundcolor=\color{themeColor!6.2}, 
    showspaces=false, 
    showstringspaces=false,
    escapeinside={(*@}{@*)}, % 设置逃逸字符
}

\ifcase\myPageFormat
    % 当变量为0时，选择页面格式为a
    \geometry{a4paper, left=15mm, right=15mm, top=16mm, bottom=8mm, headsep=0.3cm}

    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt] at (current page.north) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{img/cov01.jpg}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2] ([yshift=2cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=3cm, xshift=1cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\textbf{\Chead · 刷题本系列}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=0cm, xshift=1cm]current page.west) {\fontsize{42pt}{0}{\textbf{ \Titile}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1.8cm, xshift=1cm]current page.west) {\fontsize{36pt}{0}{\textbf{\TitileDescription}}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\textbf{\faWeixin{}\Lhead}}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\textbf{\faBook{}\RedBook}}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=3cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ding{108} \ding{108} \ding{108}}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            % \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=2cm]current page.south west) rectangle ++(5cm,2cm);
            % \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\textbf{2025版}};

            % \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=8cm]current page.south west) rectangle ++(5cm,2cm);
            % \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=10.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\textbf{2025版}};
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\textbf{\TypeOne}};
        \end{tikzpicture}
       
    \end{titlepage}
    }


    \pagestyle{fancy} % 启用自定义页眉

    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\faWeixin{}\Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\faGg{} \Chead\faGg}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{ \Rhead}} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor}\ding{118} 第 \thepage 页  / 共 \pageref{LastPage} 页 \ding{118}}
    \fancyfoot[L]{\color{themeColor}\kaishu  \leftmark}
    \fancyfoot[R]{\color{themeColor}\kaishu  \rightmark}
    \renewcommand{\sectionmark}[1]{\markboth{\ding{111} \thesection.#1}{}}
    \renewcommand{\subsectionmark}[1]{\markright{\ding{43} \thesubsection.#1}{}}

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}

    \setlength{\mylength}{0cm} % 设置长度的值为0厘米，也就是每道题后面的空位高度

    \newenvironment{bbox}
    {
    % \clearpage 
    \begin{minipage}{\textwidth}
    }
    {
    % \begin{solution}{\the\mylength}
    % \end{solution} 
    % \begin{solution}{\the\mylength}
    % \end{solution} 
    \end{minipage}
    \begin{tikzpicture}[overlay,remember picture]
        \node[anchor=east, opacity=0.01] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{img/water.png}}; 
    \end{tikzpicture}
    % \newpage % 在环境结束时插入新页面
    }
\or
    % 当变量为1时，选择页面格式为b
    \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=3mm}

    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt] at (current page.north) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{img/cov01.jpg}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2] ([yshift=2cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=3cm, xshift=1cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\textbf{\Chead · 刷题本系列}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=0cm, xshift=1cm]current page.west) {\fontsize{42pt}{0}{\textbf{\kaishu \Titile}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1.8cm, xshift=1cm]current page.west) {\fontsize{36pt}{0}{\textbf{\TitileDescription}}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\textbf{\faWeixin{}\Lhead}}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\textbf{\faBook{}\RedBook}}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=3cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ding{108} \ding{108} \ding{108}}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            % \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=2cm]current page.south west) rectangle ++(5cm,2cm);
            % \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\textbf{2025版}};

            % \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=8cm]current page.south west) rectangle ++(5cm,2cm);
            % \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=10.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\textbf{2025版}};
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\textbf{\TypeTwo}};
        \end{tikzpicture}
       
    \end{titlepage}
    }

    \pagestyle{fancy} % 启用自定义页眉

    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\faWeixin{}\Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\faGg{} \Chead\faGg}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{ \Rhead }} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor}\ding{118} 第 \thepage 页  / 共 \pageref{LastPage} 页 \ding{118}}
    \fancyfoot[L]{\color{themeColor}\kaishu  \leftmark}
    \fancyfoot[R]{\color{themeColor}\kaishu  \rightmark}
    \renewcommand{\sectionmark}[1]{\markboth{\ding{111} \thesection.#1}{}}
    \renewcommand{\subsectionmark}[1]{\markright{\ding{43} \thesubsection.#1}{}}

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}


    \setlength{\mylength}{2.5cm} % 设置长度的值为0.5厘米

    \newenvironment{bbox}
    {
    % \clearpage 
    \begin{minipage}{\textwidth}
    }
    {
    % \begin{solution}{\the\mylength}
    % \end{solution} 
    \begin{solution}{\the\mylength}
    \end{solution} 
    \end{minipage}

    \begin{tikzpicture}[overlay,remember picture]
        \node[anchor=east, opacity=0.02] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{img/water.png}}; 
    \end{tikzpicture}
    % \newpage % 在环境结束时插入新页面
    }
\or
    % 当变量为2时，选择页面格式为c
    \newcommand{\myCFormat}{1}
    \geometry{paperheight=150mm, paperwidth=200mm,left=12mm,right=12mm,top=10mm,bottom=15mm}
    


    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt](image) at ([xshift=10cm, yshift=5cm]current page.north west) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{img/cov01.jpg}};
            % 渐变效果
            % \fill[left color=white!0, right color=white!0, shading angle=0] (image.south west) rectangle (image.north east);
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2] ([yshift=0cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=1cm, xshift=1cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\textbf{\Chead · 刷题本系列}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1cm, xshift=1cm]current page.west) {\fontsize{32pt}{0}{\textbf{\kaishu \Titile}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-2.8cm, xshift=1cm]current page.west) {\fontsize{28pt}{0}{\textbf{\TitileDescription}}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\textbf{\Lhead}}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\textbf{\RedBook}}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=2.4cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ding{108} \ding{108} \ding{108}}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            % \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=2cm]current page.south west) rectangle ++(5cm,2cm);
            % \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\textbf{2025版}};

            % \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=8cm]current page.south west) rectangle ++(5cm,2cm);
            % \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=10.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\textbf{2025版}};
            \fill[themeColor!6.2, rounded corners=12pt] ([yshift=2.5cm, xshift=15.5cm]current page.south west) rectangle ++(3.5cm,1.5cm);
            \node[anchor=south, align=center] at ([yshift=2.8cm, xshift=17.3cm]current page.south west) {\color{themeColor}\fontsize{18pt}{0}\textbf{\TypeThree}};
        \end{tikzpicture}
    \end{titlepage}
    }

    \pagestyle{fancy}
    \fancyhf{} % 清空当前设置

    % 设置页码位置
    % \fancyfoot[R]{\color{themeColor} \ding{118} 第\thepage 页  / 共\pageref{LastPage}页 \ding{118}}
    
    \renewcommand{\headrulewidth}{0pt} % 移除页眉底部的横线
    \renewcommand{\footrulewidth}{0pt} % 页面底部横线 \faWeixin{}
    \newcommand{\myrecttext}{\fontsize{14}{0} \textbf{\LheadC\Chead \Rhead}}
    \newcommand{\myrecttextolus}{\fontsize{14}{0}\heiti \ding{228} \leftmark}
    \newcommand{\myrecttexttwo}{\fontsize{8pt}{0}{\textbf{  \kaishu  \leftmark}}}
    \newcommand{\myrecttextthree}{\fontsize{8pt}{0}{\textbf{ \kaishu \rightmark}}}
    \renewcommand{\sectionmark}[1]{\markboth{\ding{111} \thesection.#1}{}}
    \renewcommand{\subsectionmark}[1]{\markright{\ding{43} \thesubsection.#1}{}}

    % 在每页的页眉位置添加矩形
    \chead{%
    \begin{tikzpicture}[remember picture,overlay]
        \fill[themeColor] (current page.north west) rectangle ++(0.668\paperwidth,-0.8cm);
        \node[anchor=north west, text width=\paperwidth, text height=0.4cm, align=left] at ([xshift=0.0em]current page.north west) {%
        \textcolor{white}{\myrecttext}
        };
        
    \end{tikzpicture}%

    \begin{tikzpicture}[overlay,remember picture]
        \fill[themeColor!6.2] ([xshift=-0.332\paperwidth]current page.north east) rectangle ++(0.267\paperwidth,-0.8cm);
        
        \ifcase\myCFormat
            \node[anchor=north west, text width=\paperwidth, text height=0.4cm, align=left, font=\bfseries] at ([xshift=0.668\paperwidth]current page.north west) {%
            \textcolor{themeColor}{\myrecttextolus}
            };
        \or
            \node[anchor=north west, text width=\paperwidth, text height=0.16cm, align=left, font=\bfseries] at ([xshift=0.668\paperwidth]current page.north west) {%
            \textcolor{themeColor}{\myrecttexttwo}
            };
            \node[anchor=north west, text width=\paperwidth, text height=0.52cm, align=left, font=\bfseries] at ([xshift=0.668\paperwidth]current page.north west) {%
            \textcolor{themeColor}{\myrecttextthree}
            };
        \fi
        
    \end{tikzpicture}
    
    \begin{tikzpicture}[overlay,remember picture]
        \fill[themeColor] ([xshift=-0.115\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};
    \end{tikzpicture}

    \begin{tikzpicture}[overlay,remember picture]
        \fill[themeColor!60] ([xshift=-0.075\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};
    \end{tikzpicture}

    \begin{tikzpicture}[overlay,remember picture]
        \fill[themeColor!20] ([xshift=-0.024\paperwidth]current page.north east) rectangle ++(0.027\paperwidth,-0.8cm);
        \node[anchor=east, text=white, text height=1.2cm] at (current page.north east) {};
    \end{tikzpicture}

    \begin{tikzpicture}[overlay,remember picture]
        \draw[line width=1.5pt, color=themeColor] (current page.north west) ++(0,-0.8cm) -- ++(\paperwidth,0);
    \end{tikzpicture}

    \begin{tikzpicture}[overlay,remember picture]
        % \draw[rounded corners=6pt, fill = themeColor!6.2, themeColor!6.2] ([xshift=-5.5cm, yshift=0.2cm]current page.south east) rectangle ++(5cm,0.8cm);
        \node[anchor=east, text height=1.2cm, font=\small] at ([xshift=-8cm, yshift=1cm]current page.south east) {\color{themeColor} \ding{118} 第 \thepage 页  / 共 \pageref{LastPage} 页 \ding{118}};
    \end{tikzpicture}
    }
    
    \newenvironment{bbox}
    {
    % \clearpage 
    \begin{minipage}{\textwidth}
    }
    {
    % \begin{solution}{\the\mylength}
    % \end{solution} 
    \begin{solution}{\the\mylength}
    \end{solution} 
    \end{minipage}
    % \newpage % 在环境结束时插入新页面
    \begin{tikzpicture}[overlay,remember picture]
        % \node[anchor=east, text height=1.2cm] at ([xshift=12.5cm, yshift=1cm]current page.south west) {\color{themeColor} \heiti \ding{80} 此题重要程度（请根据自身情况涂黑\ding{72}）: \fontsize{18}{0} \ding{73} \ding{73} \ding{73} \ding{73} \ding{73}};
        \node[anchor=east, opacity=0.08] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{img/water.png}}; 
    \end{tikzpicture}
    % \fancyfoot[L]{\color{themeColor} \heiti \ding{80} 此题重要程度（请根据自身情况涂黑\ding{72}）: \fontsize{18}{0} \ding{73} \ding{73} \ding{73} \ding{73} \ding{73}}
    \newpage % 在环境结束时插入新页面
    }


\fi

% 自定义 \section 标题样式
\titleformat{\section}[block]
{\centering\heiti\normalsize}{第\thesection 章}{1em}{} % 居中、字体和大小，每一个section都重启一页

% 自定义 \section 标题在目录中的样式
\titlecontents{section}[0em]
  {\bfseries}
  {第\thecontentslabel\ 章\hspace{1em}}
  {}
  {\titlerule*[0.4pc]{.}\contentspage}

\titlecontents{subsection}[2em]
{}
{\thecontentslabel \hspace{1em}}
{}
{\titlerule*[0.4pc]{.}\contentspage}

\titlecontents{subsubsection}[4em]
{}
{\thecontentslabel \hspace{1em}}
{}
{\titlerule*[0.4pc]{.}\contentspage}

% % 定义新的章节命令，带有超链接
% \newcommand{\mysection}[1]{\section[#1]{第\thesection\ 章\hspace{1em}#1}}
% % 设置章节标题格式
% \titleformat{\section}[block]
% {\centering\heiti\normalsize}
% {第\thesection 章}
% {1em}
% {} % 居中、字体和大小，每一个section都重启一页

% % 设置目录样式
% \titlecontents{section}[0em]
%   {\bfseries} % 调整目录中标题的字体和大小
%   {第\thecontentslabel\ 章\hspace{1em}}
%   {}
%   {\hyperlink{\thecontentslabel}{\titlerule*[0.4pc]{.}\contentspage}}

% 设置 \section 标题之后的间距
\titlespacing{\section}
{0pt} % 左边距
{2pt plus 2pt minus 2pt} % 上边距
{4pt plus 2pt minus 2pt} % 下边距

% 自定义 \subsection 标题样式
\titleformat{\subsection}
{\normalfont\normalsize\bfseries} % 字体和大小
{\thesubsection} % 标题编号
{0.6em} % 与标题编号的间距
{} % 标题之后的间距

% 自定义 \subsection 标题在目录中的样式
% \titlecontents{subsection}[2em]
%   {}
%   {\thecontentslabel\hspace{1em}}
%   {}
%   {\titlerule*[0.3pc]{.}\contentspage}

% 设置 \subsection 标题之后的间距
\titlespacing{\subsection}
{0pt} % 左边距
{2pt plus 2pt minus 2pt} % 上边距
{2pt plus 2pt minus 2pt} % 下边距

\hypersetup{
  bookmarksnumbered=true
} % PDF阅读器显示侧边目录


\endinput
