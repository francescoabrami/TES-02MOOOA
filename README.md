# Teoria ed Elaborazione dei Segnali TES-02MOOOA 📡

This repository is intended to contain all the files necessary for compiling a main.pdf document useful for studying and preparing for the subject Theory and Signal Processing.

## 🤔 What about this repository?

As said before this repository is intended to help students obtain a document to study and prepare for the Theory and Signal Processing exam. Specifically the content of the whole repository is specifically useful for deal with exam Teoria ed Elaborazione dei Segnali (TES-02MOOOA) at the Polytechnic School of Turin (PoliTO) taught the first semester of the third year.

## 🫠 How is the repository is divided?

Inside the repository you will find all the necessary files and code to compile the main.pdf file, with a LaTex compiler, from the files containing all the information that are available to the user to modify to his liking.
In the repository you will find the main.tex file with all the settings, layouts and packages used in all the other subfiles which are dived in the following way:

- 📁 **sections:** contains all the subfiles divided between lectures, exercises and laboratories.
- 📊 **images:** contains all the images displayed in the document.
- 💾 **code:** contains the MATLAB code used for: laboratories, generating graphs to display as images and display the code for the user to understand.
- 🚀 **TES.pdf:** contains the latest available version of the compiled .pdf file.

**⛔️ IMPORTANT NOTES ⛔️** 
- The TES.pdf file might not be the latest compiled version respect to the LaTex code available in the repository but just a recent version compiled for accessibility purposes.
- Inside the file the following command (and exaple is used here) is used to display the MATLAB code used to generate graphs or to solve problems. 

```LaTex
\lstinputlisting[language = Matlab, firstline = X, lastline = Y]{code/ENS-1.m}
```

- For readability purposes all the code for a section will be included in one single file (.m) and divided in different section using the "%%" string as provided by the MATLAB language. As noted in the command displayed before to show code we use the command by passing the first and last line we want to display. This is not ideal for large scale projects (need to rewrite every line when you change the .m file) but is used here instead of using single files for every command display or graph.

Last but not least the whole project is based off this template called [TexPlate.](https://www.github.com/francescoabrami/TexPlate)