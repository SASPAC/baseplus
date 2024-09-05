/* WUSS 2024 Paper 164 */
/* "Here Comes the Rain (Cloud Plot) Again" */
/* by Bartosz Jablonski */

/* Rain Cloud Plots - PART 1 - Article Plots */

/* SETUP *//*
----------------------------------------------------------------------
Only the first time:
^^^^^^^^^^^^^^^^^^^^

  filename packages "/path/to/my/packages";

  filename SPFinit url "https://bit.ly/SPFinit";                 *(1);
  %include SPFinit;

  %installPackage(SPFinit BasePlus)                              *(2);



----------------------------------------------------------------------
On start of fresh SAS session:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  filename packages "/path/to/my/packages";
  %include packages(SPFinit.sas);

  %loadPackageS(BasePlus)                                        *(3);



----------------------------------------------------------------------*/
 
/*footnotes**********************************************************
*(1); Bitly points to:
  https://github.com/yabwon/SAS_PACKAGES/blob/main/SPF/SPFinit.sas

*(2); BasePlus is loaded for the %RainCloudPlot() macro.

*(3); RainCloudPlot can be just "cherry picked" from BasePlus:
  %loadPackage(BasePlus, cherryPick=RainCloudPlot)
*********************************************************************/


/* basePlus, version 1.41.0 or later is required */
/* Help notes in log */
%helpPackage(basePlus, RainCloudPlot)


%let path=/path/for/plots/; /* adjust for your session */

resetline;
data have;
  call streaminit(42);
  do i = 1 to 3;
    groupingVar = byte(64+i);
    do j = 1 to rand("integer",17,42);
      select(i);
        when(1) analysisVar = rand("uniform", 1, 7);
        when(2) analysisVar = rand("normal", -3, 2);
        when(3) analysisVar = rand("exponential", 2);
        otherwise;
      end;
      output;
    end;
  end;
  drop i j;
run;
proc print;
run;

/* utility macros */
%macro beforePlot(N,orientation=landscape,papersize=A4);
ods printer close; ods pdf close;
options orientation=&orientation. nodate nonumber papersize=&papersize. center;
options topmargin=0cm leftmargin=0cm rightmargin=0cm bottommargin=0cm;
ods pdf file="&path.//WUSS2024paper164plot&n..pdf" contents=no notoc dpi=600;
ods printer file="&path.//WUSS2024paper164plot&n..svg" printer=svg dpi=600;
%mend beforePlot;

%macro afterPlot();
ods printer close;
ods pdf close;
%mend afterPlot;


/* 1 */
%beforePlot(1);
%rainCloudPlot(
  have
, groupingVar
, analysisVar
)
%afterPlot()


/* 2 */
%beforePlot(2)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, TITLE = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";
                )
, FOOTNOTE = 
    %str(footnote1 J=R H=1 C=Gray 
        "Data set HAVE, with 87 observations, two variables.";)
)
%afterPlot()


/* 3 */
%beforePlot(3)
data colors;
input color :$20. @@;
retain y -0.5;
value=1;
x=1;
y+1;
cards;
BlueViolet RoyalBlue OliveDrab 
Gold HotPink Crimson
MediumPurple CornflowerBlue YellowGreen 
Goldenrod Orchid IndianRed
;
run;
proc sgplot data=colors noborder noautolegend nowall subpixel;
  styleattrs
    DATACOLORS = (
      BlueViolet RoyalBlue OliveDrab 
      Gold HotPink Crimson
      MediumPurple CornflowerBlue YellowGreen 
      Goldenrod Orchid IndianRed
    )
  ;
  vbarparm response=value category=value/
    group=color
    grouporder=data
    nooutline
    groupdisplay=stack
    clusterwidth=1
    baselineattrs=(thickness=0)
  ;
  text X=x Y=y TEXT=color / 
    backlight=.5
    position=right
    discreteoffset=-0.42
    textattrs=(family="Courier New" size=14 weight=bold)
  ; 

  xaxis display=none offsetmax=0 offsetmin=0;
  yaxis display=none;
run;
%afterPlot()


/* 4 */
%beforePlot(4)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";
                )
, footnote = 
    %str(footnote1 J=R H=1 C=Gray 
        "Data set HAVE, with 87 observations, two variables.";)
, MONOCHROME=1
)
%afterPlot()


/* 5 */
%beforePlot(5)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE, with 87 observations, two variables.";)
, COLORSLIST = CornflowerBlue OliveDrab IndianRed
)
%afterPlot()


/* 6 */
%beforePlot(6)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE, with 87 observations, two variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, RAINDROPSIZE = 8px
, KERNEL_K = quadratic
, KERNEL_C = 0.99
, VSCALE = Percent
, VSCALEmax = 60
)
%afterPlot()


/* 7 */
%beforePlot(7)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud (without BOX) Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE, with 87 observations, two variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, raindropsize = 8px
, kernel_k = quadratic
, kernel_c = 0.99
, vscale = percent
, vscalemax = 60
, BOXPLOT=0
)
%afterPlot()



/* 8 */
%beforePlot(8)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE, with 87 observations, two variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, raindropsize = 8px
, kernel_k = quadratic
, kernel_c = 0.99
, vscale = percent
, vscalemax = 60
, BOXPLOT=1
, BOXPLOTFILL = 0.5
, BOXPLOTLINESIZE = 2px
, BOXPLOTSYMBOLSIZE = 12px 8px
)
%afterPlot()








resetline;
proc format;
value $ FormatForGroup
  "A" = 'Uniform[1, 7]'
  "B" = 'Normal(-4, 2)'
  "C" = 'Exponential(2)'
  other = "Unknown!"
  ;

picture myPercent
  0-100 = "099.9%"
  other = "Wrong value"
  ;
run;

proc datasets lib=work nolist;
  modify have;
    format groupingVar $FormatForGroup.;
  run;
quit;



/* 9 */
%let labelStyle = size=10 family="Courier New" color=MidnightBlue weight=bold;
%let valuesStyle = size=8 family="Courier New" style=italic;

%beforePlot(9)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE, with 87 observations, two variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, raindropsize = 8px
, kernel_k = quadratic
, kernel_c = 0.99
, vscale = percent
, vscalemax = 60
, boxplot=1
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px

, XLABELS = ("Analyzed variable")
, XLABELPOS = CENTER
, XLABELATTRS = &labelStyle.
, XAXISVALUEATTRS = &valuesStyle.
, XAXISTICKSTYLE = ACROSS
, XBOTHAXIS = 0

, XAXISVALUES=(-10 to 10 by 2)
, XAXISVALUESFORMAT=F5.2 /* instead w.d format use Fw.d !! */
, XAXISOTHER=grid gridattrs=(thickness=0)
             minor minorgrid minorgridattrs=(color=cxefefef pattern=dot) 

, CATLABELS = ("Grouping variable with formated values")
, CATLABELPOS = TOP
, CATLABELATTRS = &labelStyle.
, CATAXISVALUEATTRS = &valuesStyle.
, FORMATED = 1

, Y2AXIS = 1
, Y2AXISLEVELS = 5
, Y2AXISVALUEATTRS = &valuesStyle.
, Y2AXISFORMAT = myPercent.
, Y2AXISLINES = 1
)
%afterPlot()




/* 10 */
%let labelStyle = size=10 family="Courier New" color=MidnightBlue weight=bold;
%let valuesStyle = size=8 family="Courier New" style=italic;

%beforePlot(10)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE, with 87 observations, two variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, raindropsize = 8px
, kernel_k = quadratic
, kernel_c = 0.99
, vscale = percent
, vscalemax = 60
, boxplot=1
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, xlabels = ("Analyzed variable")
, xlabelpos = CENTER
, xlabelattrs = &labelStyle.
, xaxisvalueattrs = &valuesStyle.
, xaxistickstyle = ACROSS
, xbothaxis = 0
, xaxisValues=(-8 to 8 by 2)
, xaxisValuesFormat=F5.2
, xaxisOther=GRID MINOR MINORGRID MINORGRIDATTRS=(color=CXeFeFeF pattern=dot) GRIDATTRS=(thickness=0)
, catlabels = ("Grouping variable with formated values")
, catlabelpos = TOP
, catlabelattrs = &labelStyle.
, cataxisvalueattrs = &valuesStyle.
, formated = 1
, y2axis = 1
, y2axislevels = 5
, y2axisvalueattrs = &valuesStyle.
, y2axisformat = myPercent.
, y2axislines = 1

, WIDTHPX = 1200
, HEIGHTPX = 300

, MINRANGE = -8
, MAXRANGE =  8
)
%afterPlot()


/* 11 */
%let labelStyle = size=10 family="Courier New" color=MidnightBlue weight=bold;
%let valuesStyle = size=8 family="Courier New" style=italic;

%beforePlot(11)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE, with 87 observations, two variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, raindropsize = 8px
, kernel_k = quadratic
, kernel_c = 0.99
, vscale = percent
, vscalemax = 60
, boxplot=1
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, xlabels = ("Analyzed variable")
, xlabelpos = CENTER
, xlabelattrs = &labelStyle.
, xaxisvalueattrs = &valuesStyle.
, xaxistickstyle = ACROSS
, xbothaxis = 0
, xaxisValues=(-8 to 8 by 2)
, xaxisValuesFormat=F5.2
, xaxisOther=GRID MINOR MINORGRID MINORGRIDATTRS=(color=CXeFeFeF pattern=dot) GRIDATTRS=(thickness=0)
, catlabels = ("Grouping variable with formated values")
, catlabelpos = TOP
, catlabelattrs = &labelStyle.
, cataxisvalueattrs = &valuesStyle.
, formated = 1
, y2axis = 1
, y2axislevels = 5
, y2axisvalueattrs = &valuesStyle.
, y2axisformat = myPercent.
, y2axislines = 1
, widthpx = 1200
, heightpx = 300
, minrange = -8
, maxrange =  8

, ODSGRAPHICSOPTIONS = NOBORDER
, SGPLOTOPTIONS = NOAUTOLEGEND NOBORDER NOWALL PAD=0

)
%afterPlot()



/* 12 */
%let labelStyle = size=10 family="Courier New" color=MidnightBlue weight=bold;
%let valuesStyle = size=8 family="Courier New" style=italic;

data WORK.IN_PROGRESS; 
  function="TEXT";      transparency=0.5; 
  textcolor="GOLD";     textweight="BOLD";
  widthunit="PERCENT";  drawspace="GRAPHPERCENT";
  width=500;


  label="*) will be ready for WUSS 2024";
  textsize=24; anchor="LEFT  ";
  x1=2; y1=3; rotate=0;
  output;

  label="Draft(*ESC*){sup '*'}";
  textsize=128; anchor="CENTER";
  x1=50; y1=50; rotate=30;
  output;
run; 


%beforePlot(12)
%rainCloudPlot(
  have
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE, with 87 observations, two variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, raindropsize = 8px
, kernel_k = quadratic
, kernel_c = 0.99
, vscale = percent
, vscalemax = 60
, boxplot=1
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, xlabels = ("Analyzed variable")
, xlabelpos = CENTER
, xlabelattrs = &labelStyle.
, xaxisvalueattrs = &valuesStyle.
, xaxistickstyle = ACROSS
, xbothaxis = 0
, xaxisValues=(-8 to 8 by 2)
, xaxisValuesFormat=F5.2
, xaxisOther=GRID MINOR MINORGRID MINORGRIDATTRS=(color=CXeFeFeF pattern=dot) GRIDATTRS=(thickness=0)
, catlabels = ("Grouping variable with formated values")
, catlabelpos = TOP
, catlabelattrs = &labelStyle.
, cataxisvalueattrs = &valuesStyle.
, formated = 1
, y2axis = 1
, y2axislevels = 5
, y2axisvalueattrs = &valuesStyle.
, y2axisformat = myPercent.
, y2axislines = 1
, widthpx = 1200
, heightpx = 300
, minrange = -8
, maxrange =  8
, odsgraphicsoptions = noborder
, sgplotoptions = noautolegend noborder nowall pad=0

, SGANNO = WORK.IN_PROGRESS
)
%afterPlot()




/* 13 */
%beforePlot(13)
%rainCloudPlot(
  have2
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot - vertical";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE2, with 87 observations, two variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, raindropsize = 8px
, kernel_k = quadratic
, kernel_c = 0.99
, vscale = percent
, vscalemax = 60
, boxplot=1
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, xlabels = ("Analyzed variable")
, xlabelpos = CENTER
, xlabelattrs = &labelStyle.
, xaxisvalueattrs = &valuesStyle.
, xaxistickstyle = ACROSS
, xbothaxis = 0
, xaxisValues=(-8 to 8 by 2)
, xaxisValuesFormat=F5.2
, xaxisOther=GRID MINOR MINORGRID MINORGRIDATTRS=(color=CXeFeFeF pattern=dot) GRIDATTRS=(thickness=0)
, catlabels = ("Grouping variable (formatted)")
, catlabelpos = CENTER
, catlabelattrs = &labelStyle.
, cataxisvalueattrs = &valuesStyle.
, formated = 1
, y2axis = 1
, y2axislevels = 5
, y2axisvalueattrs = &valuesStyle.
, y2axisformat = myPercent.
, y2axislines = 1
, widthpx = 1200
, heightpx = 300
, minrange = .
, maxrange = .
, odsgraphicsoptions = noborder
, sgplotoptions = noautolegend noborder nowall pad=0
, sganno = work.in_progress

, MEANSHIFTLINE=1
, MEANSHIFTSTEP=0.1
, MEANSHIFTCOLORS=Blue Green Red

)
%afterPlot()





resetline;
/* 14 */
data have2;
  set have;
  groupingVar2 = ifc(0=mod(_N_,2),"Even","Odd");
  analysisVar2 = rannor(42);
run;


%beforePlot(14)
%rainCloudPlot(
  have2
, groupingVar groupingVar2
, analysisVar analysisVar2
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot &gi. &xj.";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE2, with 87 observations, four variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, raindropsize = 8px
, kernel_k = quadratic
, kernel_c = 0.99
, vscale = percent
, vscalemax = 60
, boxplot=1
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, xlabels = ("First analyzed variable", "Second analyzed variable")
, xlabelpos = CENTER
, xlabelattrs = &labelStyle.
, xaxisvalueattrs = &valuesStyle.
, xaxistickstyle = ACROSS
, xbothaxis = 0
/*, xaxisValues=(-8 to 8 by 2)*/
, xaxisValuesFormat=F5.2
, xaxisOther=GRID MINOR MINORGRID MINORGRIDATTRS=(color=CXeFeFeF pattern=dot) GRIDATTRS=(thickness=0)
, catlabels = ("Grouping variable one", "Grouping variable two")
, catlabelpos = TOP
, catlabelattrs = &labelStyle.
, cataxisvalueattrs = &valuesStyle.
, formated = 1
, y2axis = 1
, y2axislevels = 5
, y2axisvalueattrs = &valuesStyle.
, y2axisformat = myPercent.
, y2axislines = 1
, widthpx = 1200
, heightpx = 300
, minrange = .
, maxrange = .
, odsgraphicsoptions = noborder
, sgplotoptions = noautolegend noborder nowall pad=0
, sganno = work.in_progress
, meanShiftLine =1
)
%afterPlot()


/* 15 */
%beforePlot(15,orientation=PORTRAIT)
%rainCloudPlot(
  have2
, groupingVar
, analysisVar
, title = %nrstr(title1 J=C HEIGHT=2 "The Rain Cloud Plot - vertical";
                 title2 J=C HEIGHT=1 "Plotting for groups: &list_g.";)
, footnote = %str(footnote1 J=R H=1 C=Gray 
                 "Data set HAVE2, with 87 observations, two variables.";)
, colorslist = CornflowerBlue OliveDrab IndianRed
, raindropsize = 8px
, kernel_k = quadratic
, kernel_c = 0.99
, vscale = percent
, vscalemax = 60
, boxplot=1
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, xlabels = ("Analyzed variable")
, xlabelpos = CENTER
, xlabelattrs = &labelStyle.
, xaxisvalueattrs = &valuesStyle.
, xaxistickstyle = ACROSS
, xbothaxis = 0
, xaxisValues=(-8 to 8 by 2)
, xaxisValuesFormat=F5.2
, xaxisOther=GRID MINOR MINORGRID MINORGRIDATTRS=(color=CXeFeFeF pattern=dot) GRIDATTRS=(thickness=0)
, catlabels = ("Grouping variable (formatted)")
, catlabelpos = CENTER
, catlabelattrs = &labelStyle.
, cataxisvalueattrs = &valuesStyle.
, formated = 1
, y2axis = 1
, y2axislevels = 5
, y2axisvalueattrs = &valuesStyle.
, y2axisformat = myPercent.
, y2axislines = 1
, widthpx = 1200
, heightpx = 300
, minrange = .
, maxrange = .
, odsgraphicsoptions = noborder
, sgplotoptions = noautolegend noborder nowall pad=0
, sganno = work.in_progress
, meanShiftLine=1
, meanShiftStep=0.05

, VERTICAL = 1
)
%afterPlot()






/*
%helpPackage(basePlus, RainCloudPlot)
*/

