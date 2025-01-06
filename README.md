# 简介
**ExBook** 是一个专门制作做题本/刷题本的 LaTex 文档类，只录入一次题目，就可以快速生成6种版式的PDF文档（如下图），每种版式都可以自定义页眉、页脚、封面、主题颜色等，并同时支持文字录入型刷题本以及截图型截图型刷题本，还能实现选择题选项的自动排版。

**功能特点：**
1. 录入一次题目，就可以生成6种版式（A4紧凑版、A4标准版、A4宽松版、A4单题版、横版Pad版、竖版Pad版）的PDF文档，无需手动修改任何格式；
2. 支持制作**文字录入型刷题本**以及**截图型刷题本**；
3. 支持选择题选项自动排版，可根据选项的文字长度自动排列选项；
4. 极简自定义封面、页眉、页脚等，极简插入图片，无需关注复杂的 LaTex 代码；
5. 提供12种美观易用的颜色主题；
6. 支持自定义添加**行内文字水印**以及**页面水印**。

<!-- 
<img src="./README.IMAGE/1.png" width="70%">
<img src="./README.IMAGE/2.png" width="70%"> -->

![](./README.IMAGE/1.png)
![](./README.IMAGE/2.png)

# 如何使用
1. 配置本地 Latex 环境（或直接使用Overleaf）
2. 拷贝此项目到本地（或 overleaf）

注意：使用此项目需要一点 Latex 基础！

# 项目结构说明
* `ExBoook.cls`：ExBook 文档类，不用管，也不要随便修改；
* `config.tex`：配置文件，在此文件中详细设置页眉、页脚、封面、主题颜色等；
* `main.tex`：文档内容源文件；
* `contents`文件夹：
    * `content_type_one.tex`：制作文字录入型刷题本所要录入的内容（对应 `main.tex` 重的 `\include{contents/content_type_one}`）；
    * `content_type_two.tex`：制作截图型刷题本所要录入的内容（对应 `main.tex` 重的 `\include{contents/content_type_two}`；
    * `pre.tex`：“声明”部分；
* `img` 文件夹：存放项目图片（封面、水印等）
* `fig` 文件夹：存放文字录入型刷题本的题目插图
* `splitImg` 文件夹：存放截图型刷题本的所有题目图片

注：`main.tex` 中，制作文字录入型刷题本时，只需要保留`\include{contents/content_type_one}`；制作截图型刷题本时，只需要保留`\include{contents/content_type_two}`。

# 文档类参考

## 文档类选项
**字体选项（建议使用 `fandol`）：**
* `adobe`：使用 adobe 字体
* `ubuntu`：使用 ubuntu 字体
* `windows`：使用 windows 字体
* `fandol`：使用 fandol 字体，随 texlive 默认安装
* `mac`：使用 mac 字体

**版式选项：**
* `standard`：A4 标准版。每个题目有一定空隙（大概3cm左右），每道题目的内容会强制在同一页，对于选择题而言，题目和选项不会跨业出现；
* `loose`：A4宽松版。每页会有 2 题，对于较长的题目，会自动占用一页；
* `compact`：A4紧凑版。题目间无任何空隙；
* `single`：A4单题版。一页只会出现一题；
* `padl`：横版Pad版。平板刷题，一页一题，适合小题（选择题和填空题）；
* `padp`：竖版Pad版。平板刷题，一页一题，适合大题。

**其他选项：**
* `printmode`：只在A4版下有效，可生成适合双面打印的文档
* `water`：是否显示页面水印（水印图片可在配置文件中自定义，水印将显示在页面右下角）

## 封面设置
打开 `config.tex`，以下配置项可自定义封面内容：
```latex
% 封面设置
\CoverImg{img/cov01.jpg} % 封面图片
\PreTitle{ExBook · 刷题本模板} % 前置标题
\Title{此处填写主标题} % 主标题
\TitleDescription{此处填写副标题} % 副标题
\TypeOne{A4紧凑版} % A4紧凑版下的类型标识
\TypeTwo{A4标准版} % A4标准版下的类型标识
\TypeThree{横版Pad版} % 横版Pad版下的类型标识
\TypeFour{A4宽松版} % A4宽松版下的类型标识
\TypeFive{A4单题版} % A4单题版下的类型标识
\TypeSix{竖版Pad版} % 竖版Pad版下的类型标识
\motto{你这个年龄是怎么睡得着觉的} % 封面座右铭
\Creator{研小布} % 制作人
\UpdateTime{\today} % 更新时间
```
说明如下：
![](./README.IMAGE/3.png)

## 页眉页脚设置
打开 `config.tex`，以下配置项可自定义页眉页脚：
```latex
% 页眉页脚设置
\Lhead{微信公众号·研小布} % 左页眉 
\Chead{2025考研} % 中页眉、平板模式（padl或padp）下页眉中间的文字
\Rhead{408WD数据结构选择题刷题本} % 右页眉、平板模式（padl或padp）下页眉右侧的文字
\LheadC{公众号·研小布·} % 平板模式（padl或padp）下页眉左侧的文字
```

## 主题颜色设置
提供4种经典颜色和8种个性颜色。

1. 4种经典颜色
2. 8种个性颜色

## 题目录入环境及命令

1. 题组环境
2. 题目环境
3. 题目命令
4. 小问命令
5. 选择题选项命令
6. 其他命令
   * 空括号（英文和中文）
   * 空下划线
   * 文字水印命令

## 水印设置

1. 页面水印
2. 行内文字水印