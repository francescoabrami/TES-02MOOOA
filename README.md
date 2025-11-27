# Teoria ed Elaborazione dei Segnali TES-02MOOOA 📡

This repository is intended to contain all the files necessary for compiling a main.pdf document useful for studying and preparing for the subject Theory and Signal Processing.

Knowing that not all students might be able to download and compile the file on their own the repository implements some automations to keep the latest version compiled and available to download. In this case the file is named **"TES - X.Y.Z.pdf"** where X.Y.Z indicates the latest version available. For more information about the process check the sections below.

## 🤔 What about this repository?

As said before this repository is intended to help students obtain a document to study and prepare for the Theory and Signal Processing exam. Specifically the content of the whole repository is specifically useful for deal with exam Teoria ed Elaborazione dei Segnali (TES-02MOOOA) at the Polytechnic School of Turin (PoliTO) taught the first semester of the third year.

## 🫠 How is the repository is divided?

Inside the repository you will find all the necessary files and code to compile the main.pdf file, with a LaTex compiler, from the files containing all the information that are available to the user to modify to his liking.
In the repository you will find the main.tex file with all the settings, layouts and packages used in all the other subfiles which are dived in the following way:

- 📁 **sections:** contains all the subfiles divided between lectures, exercises and laboratories.
- 📊 **images:** contains all the images displayed in the document.
- 💾 **code:** contains the MATLAB code used for: laboratories, generating graphs to display as images and display the code for the user to understand.
- 🚀 **TES.pdf:** contains the latest available version of the compiled .pdf file.

## 🤌 How does it work?

As said before the repository keeps available the latest version of the document **"TES - X.Y.Z.pdf"** with the help of GitHub Actions.
In particular whenever a push action is done on the repository the action, available in the .github/workflows/ directory, compiles the whole LaTex code into a document, renames it to the correct version and then pushes it to the repository deleting the old version.
For more detail about the process check out the .github/workflows/latex.yml file.



**⛔️ IMPORTANT NOTES ⛔️** 
- The TES.pdf file might not be the latest compiled version respect to the LaTex code available in the repository but just a recent version compiled for accessibility purposes.
- Inside the file the following command (and example is used here) is used to display the MATLAB code used to generate graphs or to solve problems. 

```LaTex
\lstinputlisting[language = Matlab, firstline = X, lastline = Y]{code/ENS-1.m}
```

- For readability purposes all the code for a section will be included in one single file (.m) and divided in different section using the "%%" string as provided by the MATLAB language. As noted in the command displayed before to show code we use the command by passing the first and last line we want to display. This is not ideal for large scale projects (need to rewrite every line when you change the .m file) but is used here instead of using single files for every command display or graph.

Last but not least the whole project is based off this template called [TexPlate.](https://www.github.com/francescoabrami/TexPlate)