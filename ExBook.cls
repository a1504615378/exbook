\def\fileversion{1.0}
\def\filedate{2023/12/30}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ExBook}[\filedate\space Version \fileversion\space by
 MA WEI JIAN]
 
 % 文档类支持以下宏包选项:
 
 % adobe 使用adobe字体
 % ubuntu 使用ubuntu字体
 % windows 使用windows字体
 % fandol 使用fandol字体，随texlive默认安装
 % mac 使用mac字体
 % list 以列表项目格式显示试题

\newcommand\@fontset{windows}
\DeclareOption{adobe}{\renewcommand\@fontset{adobe}}
\DeclareOption{ubuntu}{\renewcommand\@fontset{ubuntu}}
\DeclareOption{mac}{\renewcommand\@fontset{mac}}
\DeclareOption{windows}{\renewcommand\@fontset{windows}}
\DeclareOption{fandol}{\renewcommand\@fontset{fandol}}


\newif\if@list  \@listfalse
\DeclareOption{list}{\@listtrue}

\newif\if@printmode  \@printmodefalse
\DeclareOption{printmode}{\@printmodetrue}

\newif\if@online  \@onlinefalse
\DeclareOption{online}{\@onlinetrue}

\newif\if@water  \@waterfalse
\DeclareOption{water}{\@watertrue}


% 1. 定义默认页面格式
\def\@pageformat{standard} % 默认格式为 "standard"
\newcommand{\myPageFormat}{1}  % 默认值为 1

% 2. 定义选项，每个选项对应一个字符串值，并设置 \myPageFormat 的值
\DeclareOption{compact}{\def\@pageformat{compact}\def\myPageFormat{0}}  
\DeclareOption{standard}{\def\@pageformat{standard}\def\myPageFormat{1}} 
\DeclareOption{padl}{\def\@pageformat{padl}\def\myPageFormat{2}}  
\DeclareOption{loose}{\def\@pageformat{loose}\def\myPageFormat{3}}  
\DeclareOption{single}{\def\@pageformat{single}\def\myPageFormat{4}}  
\DeclareOption{padp}{\def\@pageformat{padp}\def\myPageFormat{5}}  



\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage[fontset = \@fontset, punct=kaiming]{ctex}
\ctexset{linestretch = 4, autoindent = 0pt}


%                    *****************************
%                    **        加载宏包       **
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
\RequirePackage{graphicx} 
\RequirePackage{pgffor}    % 用于循环
\usetikzlibrary{fadings}
\usetikzlibrary{shapes, positioning}

\punctstyle{quanjiao} % 全角（主要是为了让中文逗号占满一个字符的宽度）

\hypersetup {colorlinks=true,linkcolor=black, urlcolor=themeColor, citecolor=red}

\newcounter{QuestionCounter}

\newif\if@resetcounter
\@resetcounterfalse
\newlength{\myvertspace}


% 定义题目环境
\newenvironment{qitems}[1][]{
	\@tfor \@opt :=#1\do
		 {\if\@opt r\global\@resetcountertrue\fi}
  	\if@resetcounter
  		\setcounter{QuestionCounter}{0}
	 \fi
	\if@list
		\list{\arabic{QuestionCounter}.}{\setlength{\leftmargin}{0pt}}
	\else
		\par \begingroup \par
	\fi
}{
	\if@list
		\endlist
	\else
		\par \endgroup \par
	\fi

}

% 定义题目命令
\newcommand{\qitem}{
	\stepcounter{QuestionCounter}
	\if@list
		\item 
	\else
		\vspace{2mm}
		\arabic{QuestionCounter}.
	\fi
}

% 定义小问环境
\newlist{subqitems}{enumerate}{2}
\setlist[subqitems,1]{label=(\arabic*)}
\setlist[subqitems,2]{label=(\roman*)}

% 定义新增小问命令
\newcommand{\subqitem}{\item} 

\newenvironment{solution}[1]{
	\setlength{\myvertspace}{#1}
	\vspace*{\myvertspace}
}{

}


% 选择题选项自动排版参考了 BHCexam.cls 的实现

\newlength{\choicelengtha}
\newlength{\choicelengthb}
\newlength{\choicelengthc}
\newlength{\choicelengthd}
\newlength{\choicelengthe}
\newlength{\maxlength}

% 三个选项
\newcommand{\threechoices}[3]{
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
				A.~#1~~~  & B.~#2~~~ & C.~#3~~~ & D.~#4~~~\\ 
				% A.~#1~~~  & B.~#2~~~ & C.~#3~~~ & D.~#4~~~\\ 
			\end{tabularx}
		}%
	}
	\unskip \unskip 
}

% 五个选项
\newcommand{\fivechoices}[5]{
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
	\par
	\settowidth{\choicelengtha}{A.~#1~~~}
	\settowidth{\choicelengthb}{B.~#2~~~}
	\settowidth{\choicelengthc}{C.~#3~~~}
	\settowidth{\choicelengthd}{D.~#4~~~}
	\settowidth{\choicelengthe}{E.~#5~~~}
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
% \newcommand{\myPageFormat}{0}

\def\ExBook@value@PreTitle{\textbf{ExBook · 刷题本模板}}
\def\ExBook@value@Title{\heiti 此处填写主标题}
\def\ExBook@value@TitleDescription{\textbf{此处填写副标题}}
\def\ExBook@value@TypeOne{\textbf{A4紧凑版}}
\def\ExBook@value@TypeTwo{\textbf{A4标准版}}
\def\ExBook@value@TypeThree{\textbf{横版Pad版}}
\def\ExBook@value@TypeFour{\textbf{A4宽松版}}
\def\ExBook@value@TypeFive{\textbf{A4单题版}}
\def\ExBook@value@TypeSix{\textbf{竖版Pad版}}
\def\ExBook@value@motto{\kaishu “心无旁骛，行稳致远。”}
\def\ExBook@value@Creator{\textbf{制作人：研小布}}
\def\ExBook@value@UpdateTime{\textbf{最后更新时间：\today}}

\def\ExBook@value@Lhead{微信公众号·研小布}
\def\ExBook@value@Chead{2025考研}
\def\ExBook@value@Rhead{408WD数据结构选择题刷题本}
\def\ExBook@value@LheadC{公众号·研小布·}
\def\ExBook@value@TextWater{\textcolor{black!38}{\selectfont【微信公众号·研小布】}}
\def\ExBook@value@waterImg{img/water.png}
\def\ExBook@value@coverImg{img/cov01.jpg}
\def\ExBook@value@onlineCheckUrl{https://github.com/ExBook/ExBook}

\newcommand\PreTitle[1]{\def\ExBook@value@PreTitle{\textbf{#1}}}
\newcommand\Title[1]{\def\ExBook@value@Title{\heiti #1}}
\newcommand\TitleDescription[1]{\def\ExBook@value@TitleDescription{\textbf{#1}}}
\newcommand\TypeOne[1]{\def\ExBook@value@TypeOne{\textbf{#1}}}
\newcommand\TypeTwo[1]{\def\ExBook@value@TypeTwo{\textbf{#1}}}
\newcommand\TypeThree[1]{\def\ExBook@value@TypeThree{\textbf{#1}}}
\newcommand\TypeFour[1]{\def\ExBook@value@TypeFour{\textbf{#1}}}
\newcommand\TypeFive[1]{\def\ExBook@value@TypeFive{\textbf{#1}}}
\newcommand\TypeSix[1]{\def\ExBook@value@TypeSix{\textbf{#1}}}
\newcommand\motto[1]{\def\ExBook@value@motto{\kaishu “#1”}}
\newcommand\Creator[1]{\def\ExBook@value@Creator{\textbf{制作人：#1}}}
\newcommand\UpdateTime[1]{\def\ExBook@value@UpdateTime{\textbf{最后更新时间：#1}}}
\newcommand\Lhead[1]{\def\ExBook@value@Lhead{\textbf{#1}}}
\newcommand\Chead[1]{\def\ExBook@value@Chead{\textbf{#1}}}
\newcommand\Rhead[1]{\def\ExBook@value@Rhead{\textbf{#1}}}
\newcommand\LheadC[1]{\def\ExBook@value@LheadC{\textbf{#1}}}
\newcommand\TextWater[1]{\def\ExBook@value@TextWater{\textcolor{black!38}{\selectfont #1}}}
\newcommand{\textwater}{\ExBook@value@TextWater}
\newcommand\WaterImg[1]{\def\ExBook@value@waterImg{#1}}
\newcommand\CoverImg[1]{\def\ExBook@value@coverImg{#1}}
\newcommand\OnlineCheckUrl[1]{\def\ExBook@value@onlineCheckUrl{#1}}


\newcommand{\qanswerloc}[1]{\textcolor{themeColor}{\selectfont \ding{226} 此部分答案见原书P#1}}
\newcommand{\blankbox}{（\hspace{1.5em}）} % 中文空括号
\newcommand{\eblankbox}{(\hspace{1.5em})} % 英文空括号
\newcommand{\blankline}{\underline{\hspace{3em}}} % 空白下划线

\setmainfont{Times New Roman} % 设置全局英文字体为 Times New Roman

% \definecolor{themeColor}{HTML}{3f8827} % 自定义颜色
 %                         *****************
 %                         ** 主题颜色设置  **
 %                         *****************

% 设置颜色变量
\newcommand{\blue}{blue}
\newcommand{\green}{green}
\newcommand{\purple}{purple}
\newcommand{\orange}{orange}

\newcommand{\infj}{infj}
\newcommand{\enfp}{enfp}
\newcommand{\infp}{infp}
\newcommand{\esfp}{esfp}
\newcommand{\intj}{intj}
\newcommand{\entp}{entp}
\newcommand{\isfj}{isfj}
\newcommand{\enfj}{enfj}

% 设置颜色命令
\newcommand{\setThemeColor}[1]{%
    \ifx#1\blue
    \definecolor{themeColor}{HTML}{015697} % 自定义颜色 蓝色
    \else
    \ifx#1\green
    \definecolor{themeColor}{HTML}{01847c} % 自定义颜色 绿色
    \else
    \ifx#1\purple
    \definecolor{themeColor}{HTML}{61589b} % 自定义颜色 紫色
    \else
    \ifx#1\orange
    \definecolor{themeColor}{HTML}{EA4C0E} % 自定义颜色 橙色
    \else
    \ifx#1\infj
    \definecolor{themeColor}{HTML}{3b4676} % 自定义颜色 infj
    \else
    \ifx#1\enfp
    \definecolor{themeColor}{HTML}{d58a05} % 自定义颜色 enfp
    \else
    \ifx#1\infp
    \definecolor{themeColor}{HTML}{3b6079} % 自定义颜色 infp
    \else
    \ifx#1\esfp
    \definecolor{themeColor}{HTML}{d86b09} % 自定义颜色 esfp
    \else
    \ifx#1\intj
    \definecolor{themeColor}{HTML}{38558f} % 自定义颜色 intj
    \else
    \ifx#1\entp
    \definecolor{themeColor}{HTML}{8c2b2b} % 自定义颜色 entp
    \else
    \ifx#1\isfj
    \definecolor{themeColor}{HTML}{4d417e} % 自定义颜色 isfj
    \else
    \ifx#1\enfj
    \definecolor{themeColor}{HTML}{e15715} % 自定义颜色 enfj
    \else
    \definecolor{themeColor}{HTML}{015697} % 自定义颜色 蓝色
    \fi
    \fi
    \fi
    \fi
    \fi
    \fi
    \fi
    \fi
    \fi
    \fi
    \fi
    \fi
}

% \renewcommand{\cftdotsep}{1} % 调整点的密度，可以根据需要设置

\renewcommand\arraystretch{1.3}  % 表格行高（选择题选项间距）
\renewcommand{\baselinestretch}{1.3} % 设置行间距

% listings代码样式
\lstset{
    language=C, % 设置默认语言
    breaklines=true, % 自动换行
    basicstyle=\ttfamily, 
    backgroundcolor=\color{themeColor!6.2}, 
    showspaces=false, 
    showstringspaces=false,
    escapeinside={(*@}{@*)}, % 设置逃逸字符
}

\newcommand{\imgin}[2]{
    \par
    \begin{minipage}[t]{1.0\textwidth}
        \centering
        \includegraphics[width=#1\textwidth]{#2}
    \end{minipage}
}


\ifcase\myPageFormat
 %                         *****************
 %                         **   A4紧凑版   **
 %                         *****************
    \if@printmode
        \geometry{a4paper, twoside, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm, bindingoffset = 1cm}
    \else
        \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm}   
    \fi

    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt] at (current page.north) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2] ([yshift=2cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=3cm, xshift=1.5cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\ExBook@value@PreTitle}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=0cm, xshift=1.5cm]current page.west) {\fontsize{36pt}{0}{\ExBook@value@Title}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1.8cm, xshift=1.5cm]current page.west) {\fontsize{32pt}{0}{\ExBook@value@TitleDescription}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=2.5cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{22pt}{0}\ExBook@value@TypeOne};
        \end{tikzpicture}

        \if@online
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
            \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=1.50cm]current page.south west) rectangle ++(7cm,1cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=5.2cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
        \end{tikzpicture}

        \fi
        
    \end{titlepage}
    \if@printmode
        \clearpage
        \null
        \thispagestyle{empty}
        \clearpage
    \fi
    
    }

    % 启用自定义页眉
    \pagestyle{fancy}
    
    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Chead}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Rhead}} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor} 第 \thepage 页  / 共 \pageref{LastPage} 页}
    \fancyfoot[L]{\color{themeColor}\kaishu  \leftmark}
    \fancyfoot[R]{\color{themeColor}\kaishu  \rightmark}
    \renewcommand{\sectionmark}[1]{\markboth{\thesection.#1}{}}
    \renewcommand{\subsectionmark}[1]{\markright{\thesubsection.#1}{}}

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}


    \newenvironment{bbox}
    {

    }
    {
    \if@water
        \begin{tikzpicture}[overlay,remember picture]
            \node[anchor=east, opacity=0.01,] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
        \end{tikzpicture}
    \fi
    }
    
\or
 %                         *****************
 %                         **   A4标准版   **
 %                         *****************
    \if@printmode
    \geometry{a4paper, twoside, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm, bindingoffset = 1cm}
    \else
        \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm}   
    \fi

    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt] at (current page.north) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2] ([yshift=2cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=3cm, xshift=1.5cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\ExBook@value@PreTitle}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=0cm, xshift=1.5cm]current page.west) {\fontsize{36pt}{0}{\ExBook@value@Title}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1.8cm, xshift=1.5cm]current page.west) {\fontsize{32pt}{0}{\ExBook@value@TitleDescription}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=3cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\ExBook@value@TypeTwo};
        \end{tikzpicture}


        \if@online
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
            \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=1.50cm]current page.south west) rectangle ++(7cm,1cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=5.2cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
        \end{tikzpicture}

        \fi
       
    \end{titlepage}
    \if@printmode
        \clearpage
        \null
        \thispagestyle{empty}
        \clearpage
    \fi
    }


    \pagestyle{fancy} % 启用自定义页眉

    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Chead}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Rhead}} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor}第 \thepage 页  / 共 \pageref{LastPage} 页 }
    \fancyfoot[L]{\color{themeColor}\kaishu  \leftmark}
    \fancyfoot[R]{\color{themeColor}\kaishu  \rightmark}
    \renewcommand{\sectionmark}[1]{\markboth{\thesection.#1}{}}
    \renewcommand{\subsectionmark}[1]{\markright{\thesubsection.#1}{}}

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}

    \newenvironment{bbox}
    {
    \begin{minipage}{\textwidth}
    }
    {

    \vspace*{2.5cm}
    \end{minipage}

    \if@water
        \begin{tikzpicture}[overlay,remember picture]
            \node[anchor=east, opacity=0.02] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
        \end{tikzpicture}
    \fi
    % \newpage % 在环境结束时插入新页面
    }
\or
 %                         *****************
 %                         **   横Pad版    **
 %                         *****************
    % 当变量为2时，选择页面格式为c
    \newcommand{\myCFormat}{1}
    \geometry{paperheight=150mm, paperwidth=200mm,left=12mm,right=12mm,top=10mm,bottom=15mm}
    
    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt](image) at ([xshift=10cm, yshift=5cm]current page.north west) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};
            % 渐变效果
            % \fill[left color=white!0, right color=white!0, shading angle=0] (image.south west) rectangle (image.north east);
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2] ([yshift=0cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=1cm, xshift=1cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\textbf{\ExBook@value@Chead · 刷题本系列}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1cm, xshift=1cm]current page.west) {\fontsize{32pt}{0}{\textbf{\kaishu \ExBook@value@Title}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-2.5cm, xshift=1cm]current page.west) {\fontsize{28pt}{0}{\textbf{\ExBook@value@TitleDescription}}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};

            
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=2.4cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2, rounded corners=12pt] ([yshift=2.5cm, xshift=15.5cm]current page.south west) rectangle ++(3.5cm,1.5cm);
            \node[anchor=south, align=center] at ([yshift=2.8cm, xshift=17.3cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\ExBook@value@TypeThree}};
        \end{tikzpicture}

        \if@online
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=1.0cm, xshift=3.25cm]current page.south west) {\color{themeColor}\fontsize{10pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
            \node[anchor=south, align=center] at ([yshift=0.35cm, xshift=3.4cm]current page.south west) {\color{themeColor}\fontsize{10pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
        \end{tikzpicture}

        \fi
        
    \end{titlepage}
    }

    \pagestyle{fancy}
    \fancyhf{} % 清空当前设置

    \renewcommand{\headrulewidth}{0pt} % 移除页眉底部的横线
    \renewcommand{\footrulewidth}{0pt} % 页面底部横线 \faWeixin{}
    \newcommand{\myrecttext}{\fontsize{14}{0} \textbf{\ExBook@value@LheadC \ExBook@value@Chead \ExBook@value@Rhead}}
    \newcommand{\myrecttextolus}{\fontsize{14}{0}\heiti \leftmark}
    \newcommand{\myrecttexttwo}{\fontsize{8pt}{0}{\textbf{  \kaishu  \leftmark}}}
    \newcommand{\myrecttextthree}{\fontsize{8pt}{0}{\textbf{ \kaishu \rightmark}}}
    % \renewcommand{\sectionmark}[1]{\markboth{ \thesection.#1}{}}
    \renewcommand{\sectionmark}[1]{\markboth{ #1}{}}
    % \renewcommand{\subsectionmark}[1]{\markright{\thesubsection.#1}{}}
    \renewcommand{\subsectionmark}[1]{\markright{#1}{}}

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
        \node[anchor=east, text height=1.2cm, font=\small] at ([xshift=-8.5cm, yshift=1.5cm]current page.south east) {\color{themeColor}  第 \thepage 页  / 共 \pageref{LastPage} 页};
    \end{tikzpicture}
    }
    
    \newenvironment{bbox}
    {

    \begin{minipage}{\textwidth}
    }
    {
    \end{minipage}
    \if@water
    \begin{tikzpicture}[overlay,remember picture]
        \node[anchor=east, opacity=0.08] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
    \end{tikzpicture}
    \fi
    \newpage % 在环境结束时插入新页面
    }
\or
 %                         *****************
 %                         **   A4宽松版   **
 %                         *****************

    \if@printmode
        \geometry{a4paper, twoside, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm, bindingoffset = 1cm}
    \else
        \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm}   
    \fi

    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt] at (current page.north) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2] ([yshift=2cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=3cm, xshift=1.5cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\ExBook@value@PreTitle}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=0cm, xshift=1.5cm]current page.west) {\fontsize{36pt}{0}{\ExBook@value@Title}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1.8cm, xshift=1.5cm]current page.west) {\fontsize{32pt}{0}{\ExBook@value@TitleDescription}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=3cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\ExBook@value@TypeFour}; 
        \end{tikzpicture}

        \if@online
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
            \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=1.50cm]current page.south west) rectangle ++(7cm,1cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=5.2cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
        \end{tikzpicture}

        \fi
       
    \end{titlepage}
    }


    \pagestyle{fancy} % 启用自定义页眉

    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Chead}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Rhead}} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor}第 \thepage 页  / 共 \pageref{LastPage} 页 }
    \fancyfoot[L]{\color{themeColor}\kaishu  \leftmark}
    \fancyfoot[R]{\color{themeColor}\kaishu  \rightmark}
    \renewcommand{\sectionmark}[1]{\markboth{\thesection.#1}{}}
    \renewcommand{\subsectionmark}[1]{\markright{\thesubsection.#1}{}}

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}

    \newenvironment{bbox}
    {
    % \clearpage 
    \begin{minipage}{\textwidth}
    }
    {

    \vspace*{7.5cm}
    \end{minipage}
    \if@water
    \begin{tikzpicture}[overlay,remember picture]
        \node[anchor=east, opacity=0.02] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
    \end{tikzpicture}
    \fi
    % \newpage % 在环境结束时插入新页面
    }

\or
 %                         *****************
 %                         **   A4单题版   **
 %                         *****************
    % 当变量为1时，选择页面格式为b
    \if@printmode
        \geometry{a4paper, twoside, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm, bindingoffset = 1cm}
    \else
        \geometry{a4paper, left=18mm, right=18mm, top=25mm, bottom=25mm, headsep=5mm}   
    \fi

    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt] at (current page.north) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2] ([yshift=2cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=3cm, xshift=1.5cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\ExBook@value@PreTitle}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=0cm, xshift=1.5cm]current page.west) {\fontsize{36pt}{0}{\ExBook@value@Title}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1.8cm, xshift=1.5cm]current page.west) {\fontsize{32pt}{0}{\ExBook@value@TitleDescription}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=3cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2, rounded corners=16pt] ([yshift=4cm, xshift=14cm]current page.south west) rectangle ++(5cm,2cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=16.5cm]current page.south west) {\color{themeColor}\fontsize{24pt}{0}\ExBook@value@TypeFive};
        \end{tikzpicture}

        \if@online
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
            \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=1.50cm]current page.south west) rectangle ++(7cm,1cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=5.2cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
        \end{tikzpicture}

        \fi
       
    \end{titlepage}
    }


    \pagestyle{fancy} % 启用自定义页眉

    % 清除当前的页眉和页脚设置
    \fancyhf{}

    % 设置页眉内容
    \fancyhead[L]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Lhead}}}
    \fancyhead[C]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Chead}} }
    \fancyhead[R]{\color{themeColor} \fontsize{10pt}{0}{\textbf{\ExBook@value@Rhead}} }

    % 设置页码位置
    \fancyfoot[C]{\color{themeColor}第 \thepage 页  / 共 \pageref{LastPage} 页 }
    \fancyfoot[L]{\color{themeColor}\kaishu  \leftmark}
    \fancyfoot[R]{\color{themeColor}\kaishu  \rightmark}
    \renewcommand{\sectionmark}[1]{\markboth{\thesection.#1}{}}
    \renewcommand{\subsectionmark}[1]{\markright{\thesubsection.#1}{}}

    % 设置分隔线
    \renewcommand{\headrulewidth}{0.4pt}
    \renewcommand{\footrulewidth}{0pt}



    \newenvironment{bbox}
    {

    }
    {
    \if@water
    \begin{tikzpicture}[overlay,remember picture]
        \node[anchor=east, opacity=0.02] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
    \end{tikzpicture}
    \fi
    \newpage % 在环境结束时插入新页面
    }

\or
 %                         *****************
 %                         **   竖Pad版   **
 %                         *****************
    \newcommand{\myCFormat}{1}
    \geometry{paperheight=250mm, paperwidth=200mm,left=12mm,right=12mm,top=10mm,bottom=15mm}

    % 自定义封面样式
    \renewcommand{\maketitle}{
    \begin{titlepage}
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=north, inner sep=0pt](image) at ([xshift=10cm, yshift=0cm]current page.north west) {\includegraphics[width=\paperwidth, height=\paperheight, keepaspectratio]{\ExBook@value@coverImg}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2] ([yshift=0cm]current page.west) rectangle ++(\paperwidth,2cm);
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=1cm, xshift=1cm]current page.west) {\color{themeColor} \fontsize{24pt}{0}{\textbf{\ExBook@value@Chead · 刷题本系列}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-1cm, xshift=1cm]current page.west) {\fontsize{32pt}{0}{\textbf{\kaishu \ExBook@value@Title}}};
            \node[anchor=west, align=left, text width=\textwidth, inner sep=0] at ([yshift=-2.8cm, xshift=1cm]current page.west) {\fontsize{28pt}{0}{\textbf{\ExBook@value@TitleDescription}}};
            \fill[themeColor!6.2] (current page.south west) rectangle ++(\paperwidth,2cm);
            \node[anchor=south, align=center] at ([yshift=0.8cm]current page.south) {\color{themeColor}\fontsize{16pt}{0}{\ExBook@value@Creator}};
            \node[anchor=south, align=center] at ([yshift=0.2cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@UpdateTime}};

            
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=2.4cm]current page.south) {\color{themeColor}\fontsize{12pt}{0}{\ExBook@value@motto}};
        \end{tikzpicture}

        \begin{tikzpicture}[remember picture, overlay]
            \fill[themeColor!6.2, rounded corners=12pt] ([yshift=3.5cm, xshift=15.0cm]current page.south west) rectangle ++(3.5cm,1.5cm);
            \node[anchor=south, align=center] at ([yshift=3.8cm, xshift=16.8cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\ExBook@value@TypeSix}};
        \end{tikzpicture}

        \if@online
        
        \begin{tikzpicture}[remember picture, overlay]
            \node[anchor=south, align=center] at ([yshift=5.5cm, xshift=3.8cm]current page.south west) {\color{themeColor}\fontsize{14pt}{0}\textbf{\kaishu 遇到录入错误，可查看：}};
            \fill[themeColor!6.2, rounded corners=6pt] ([yshift=4.5cm, xshift=0.80cm]current page.south west) rectangle ++(7cm,1cm);
            \node[anchor=south, align=center] at ([yshift=4.5cm, xshift=4.5cm]current page.south west) {\color{themeColor}\fontsize{16pt}{0}\textbf{\href{\ExBook@value@onlineCheckUrl}{在线勘误文档（\underline{点击跳转}）}}};
        \end{tikzpicture}

        \fi
    \end{titlepage}
    }

    \pagestyle{fancy}
    \fancyhf{} % 清空当前设置
    
    \renewcommand{\headrulewidth}{0pt} % 移除页眉底部的横线
    \renewcommand{\footrulewidth}{0pt} % 页面底部横线 \faWeixin{}
    \newcommand{\myrecttext}{\fontsize{14}{0} \textbf{\ExBook@value@LheadC \ExBook@value@Chead \ExBook@value@Rhead}}
    \newcommand{\myrecttextolus}{\fontsize{14}{0}\heiti \leftmark}
    \newcommand{\myrecttexttwo}{\fontsize{8pt}{0}{\textbf{  \kaishu  \leftmark}}}
    \newcommand{\myrecttextthree}{\fontsize{8pt}{0}{\textbf{ \kaishu \rightmark}}}
    % \renewcommand{\sectionmark}[1]{\markboth{ \thesection #1}{}}
    % \renewcommand{\subsectionmark}[1]{\markright{\thesubsection #1}{}}
    \renewcommand{\sectionmark}[1]{\markboth{#1}{}}
    \renewcommand{\subsectionmark}[1]{\markright{#1}{}}

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
        \node[anchor=east, text height=1.2cm, font=\small] at ([xshift=-8.5cm, yshift=1.5cm]current page.south east) {\color{themeColor}  第 \thepage 页  / 共 \pageref{LastPage} 页};
    \end{tikzpicture}
    }
    
    \newenvironment{bbox}
    {
    % \clearpage 
    \begin{minipage}{\textwidth}
    }
    {
    \end{minipage}
    \if@water
    \begin{tikzpicture}[overlay,remember picture]
        \node[anchor=east, opacity=0.08] at ([xshift=-1.2cm, yshift=4.8cm]current page.south east)  {\includegraphics[width=0.16\textwidth]{\ExBook@value@waterImg}}; 
    \end{tikzpicture}
    \fi
    \newpage % 在环境结束时插入新页面
    }

\fi

% 自定义 \section 标题样式
\titleformat{\section}[block]
{\newpage \centering\heiti\normalsize}{第\thesection 章}{1em}{} % 居中、字体和大小，每一个section都重启一页

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

\titlespacing{\section}
{0pt} % 左边距
{2pt plus 2pt minus 2pt} % 上边距
{4pt plus 2pt minus 2pt} % 下边距

\titlespacing{\subsection}
{0pt} % 左边距
{2pt plus 2pt minus 2pt} % 上边距
{2pt plus 2pt minus 2pt} % 下边距

% 自定义 \subsection 标题样式
\titleformat{\subsection}
{\normalfont\normalsize\bfseries} % 字体和大小
{\thesubsection} % 标题编号
{0.6em} % 与标题编号的间距
{} % 标题之后的间距


\hypersetup{
  bookmarksnumbered=true
} % PDF阅读器显示侧边目录

% \newcommand{\TextType}{TextType}
% \newcommand{\ImgType}{ImgType}

\AtBeginDocument{
	\pagenumbering{arabic}  % 使用阿拉伯数字页码
}

\endinput
