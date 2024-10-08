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

%put %date(yymmddn10.) %time(time5.) %datetime(e8601dt.);

%put %monthShift(2023,1,-5);

%put #%expandDataSetsList(lib=sashelp,datasets=_all_)#;
```
and more.

SHA256 digest for the latest version of `BasePlus`: F*DFA83F8E0D7424DEB63D49620392068BC68D766552E2804CB6B01DE8E5A87769

[**Documentation for BasePlus**](./baseplus.md "Documentation for BasePlus")

To work with a package use the [**SAS Packages Framework**](https://github.com/yabwon/SAS_PACKAGES/blob/main/README.md "SPFinit").
