## `basePlus` - The BASE SAS plus a bunch of functionalities I am missing in BASE SAS :-)

---

The **BasePlus** package adds a bunch of functionalities I am missing in BASE SAS, such as:
```sas
call arrMissToRight(myArray); 

call arrFillMiss(17, myArray); 

call arrFill(42, myArray); 

rc = delDataset("DataSetToDrop"); 

string = catXFn("date9.", "#", myArray);

format x bool.;

%put %getVars(sashelp.class, pattern = ght$, sep = +, varRange = _numeric_);

%rainCloudPlot(sashelp.cars,DriveTrain,Invoice)

%zipLibrary(sashelp,libOut=work)

%bpPIPE(ls -la ~/)

%dirsAndFiles(C:\SAS_WORK\,ODS=work.result)

%put %repeatTxt(#,15,s=$) HELLO SAS! %repeatTxt(#,15,s=$);

%put %intsList(42);
%put %letters(1:26:1);

%splitDSIntoBlocks(5, sashelp.class, classBlock)

%splitDSIntoParts(7, sashelp.cars, carsPart)

filename f temp;
%put %filePath(f);

%put %libPath(WORK);

libname NEW "%workPath()/new";

%put %translate(%str("A", "B", "C"),%str(%",),%str(%' ));

%put %tranwrd(Miss Joan Smith,Miss,Ms.);

%put %date() %time() %datetime();
```
and more.

SHA256 digest for the latest version of `BasePlus`: F*7EF23E80A2C03B29402183D97ECFF608B62BEDD9458848709B52DC362E6201B9

[**Documentation for BasePlus**](./baseplus.md "Documentation for BasePlus")

To work with a package use the [**SAS Packages Framework**](https://github.com/yabwon/SAS_PACKAGES/blob/main/README.md "SPFinit").
