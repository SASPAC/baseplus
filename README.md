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
```
and more.

SHA256 digest for the latest version of `BasePlus`: EBA9EDB3D50D854288970CC0E965DA6AD5B057F6E6433EEBEC4A02B9A25CF6E2

[**Documentation for BasePlus**](./baseplus.md "Documentation for BasePlus")
