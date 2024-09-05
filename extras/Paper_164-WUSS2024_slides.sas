/* WUSS 2024 Paper 164 */
/* "Here Comes the Rain (Cloud Plot) Again" */
/* by Bartosz Jablonski */

/* Rain Cloud Plots - PART 2 - Presentation Plots */

/*
   See:
  
   Rain Cloud Plots - PART 1 - Article Plots (file: Paper_164-WUSS2024.sas)

   for details about the setup. 
*/



data have;
  call streaminit(64);
  vertical = 42;
  do j = 1 to 42;
    horizontal = rand("uniform", 24, 42);
    output;
  end;
  drop i j;
run;
data have;
  set have;
  horizontal = horizontal - 13;
run;
proc print;
run;



/* 101 */
%beforePlot(101)
%rainCloudPlot(
  have
, vertical
, horizontal
, TITLE = %str(
          title1 H=2 J=C "Here Come The Rain Again";
          title2 H=1 J=C "Bartosz Jablonski";
          )
, FOOTNOTE = 
, vscale = percent
, vscalemax = 42
, y2axislevels = 1
, BOXPLOT=1
, BOXPLOTFILL = 0.5
, RAINDROPSIZE = 8px
, COLORSLIST=CX222222
, BOXPLOTLINESIZE = 2pt
, MINRANGE = 0
, MAXRANGE =  42
, xaxistickstyle = ACROSS
, xbothaxis = 0
, xaxisValues=(0 to 42 by 42)
, xaxisValuesFormat=F3.0
, xaxisOther=MINOR 
, widthpx = 1200
, heightpx = 800
)
%afterPlot()


%beforePlot(102)
%rainCloudPlot(sashelp.cars, origin, invoice)
%afterPlot()

%beforePlot(103)
%rainCloudPlot(sashelp.class, sex, height)
%afterPlot()







%beforePlot(104)
%rainCloudPlot(sashelp.cars(where=(origin in: ("E" "U"))), origin, invoice
, TITLE = %nrstr(title1 J=C HEIGHT=2 "Distribution of cars prices";
                 title2 J=C HEIGHT=1 COLOR=DarkGrey "Europe vs. US";
                )
, FOOTNOTE = %str(footnote1 J=l H=1 C=Gray "1%) Data from SASHELP.CARS";) /*"*/
)
%afterPlot() /*"*/


%beforePlot(105)
%rainCloudPlot(sashelp.cars(where=(origin in: ("E" "U"))), origin, invoice
, title = %nrstr(title1 J=C HEIGHT=2 "Distribution of cars prices";
                 title2 J=C HEIGHT=1 COLOR=DarkGrey "Europe vs. US";
                )
, footnote = %str(footnote1 J=l H=1 C=Gray "1%) Data from SASHELP.CARS";) /*"*/

, COLORSLIST = OrangeRed OliveDrab
, BOXPLOTFILL = 0.5
, BOXPLOTLINESIZE = 2px
, BOXPLOTSYMBOLSIZE = 12px 8px
)
%afterPlot() 



%beforePlot(106)
%rainCloudPlot(sashelp.cars(where=(origin in: ("E" "U"))), origin, invoice
, title = %nrstr(title1 J=C HEIGHT=2 "Distribution of cars prices";
                 title2 J=C HEIGHT=1 COLOR=DarkGrey "Europe vs. US";
                )
, footnote = %str(footnote1 J=l H=1 C=Gray "1%) Data from SASHELP.CARS";) /*"*/
, colorslist = OrangeRed OliveDrab
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, RAINDROPSIZE = 3px
, KERNEL_K = triangular
, KERNEL_C = 0.99
, VSCALE = Percent
, VSCALEmax = 75
)
%afterPlot() 

%beforePlot(107)
%let labelStyle = size=10 family="Courier New" color=MidnightBlue weight=bold;
%let valuesStyle = size=8 family="Courier New" style=italic;
%rainCloudPlot(sashelp.cars(where=(origin in: ("E" "U"))), origin, invoice
, title = %nrstr(title1 J=C HEIGHT=2 "Distribution of cars prices";
                 title2 J=C HEIGHT=1 COLOR=DarkGrey "Europe vs. US";
                )
, footnote = %str(footnote1 J=l H=1 C=Gray "1%) Data from SASHELP.CARS";) /*"*/
, colorslist = OrangeRed OliveDrab
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, raindropsize = 3px
, kernel_k = triangular
, kernel_c = 0.99
, vscale = percent
, vscalemax = 75

, XLABELS = ("Analyzed variable")
, XLABELPOS = CENTER
, XLABELATTRS = &labelStyle.
, XAXISVALUEATTRS = &valuesStyle.
, XAXISTICKSTYLE = ACROSS
, XBOTHAXIS = 0

, XAXISVALUES=(1e4 to 18e4 by 1e4)
, XAXISVALUESFORMAT=dollar12.2
, XAXISOTHER=grid gridattrs=(thickness=0)
             minor minorgrid minorgridattrs=(color=cxefefef pattern=dot) 

, CATLABELS = ("Grouping variable")
, CATLABELPOS = TOP
, CATLABELATTRS = &labelStyle.
, CATAXISVALUEATTRS = &valuesStyle.
, FORMATED = 1

, Y2AXIS = 1
, Y2AXISLEVELS = 5
, Y2AXISVALUEATTRS = &valuesStyle.
, Y2AXISFORMAT = F5.2
, Y2AXISLINES = 1

, WIDTHPX = 1200
, HEIGHTPX = 350
)
%afterPlot() 



data WORK.AT_WUSS; 
  function="TEXT"; transparency=0.3; 
  textcolor="CornflowerBlue"; textweight="BOLD";
  widthunit="PERCENT"; drawspace="GRAPHPERCENT";
  width=500;

  label="WUSS(*ESC*){sup '*'}";
  textsize=96; anchor="CENTER";
  textfont="Courier New";
  x1=75; y1=20; rotate=0;
  output;
run;

%beforePlot(108)
%let labelStyle = size=10 family="Courier New" color=MidnightBlue weight=bold;
%let valuesStyle = size=8 family="Courier New" style=italic;
%rainCloudPlot(sashelp.cars(where=(origin in: ("E" "U"))), origin, invoice
, title = %nrstr(title1 J=C HEIGHT=2 "Distribution of cars prices";
                 title2 J=C HEIGHT=1 COLOR=DarkGrey "Europe vs. US";
                )
, footnote = %str(footnote1 J=l H=1 C=Gray "1%) Data from SASHELP.CARS";) /*"*/
, colorslist = OrangeRed OliveDrab
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, raindropsize = 3px
, kernel_k = triangular
, kernel_c = 0.99
, vscale = percent
, vscalemax = 75
, xlabels = ("Analyzed variable")
, xlabelpos = center
, xlabelattrs = &labelstyle.
, xaxisvalueattrs = &valuesstyle.
, xaxistickstyle = across
, xbothaxis = 0
, xaxisvalues=(1e4 to 18e4 by 1e4)
, xaxisvaluesformat=dollar12.2
, xaxisother=grid gridattrs=(thickness=0)
             minor minorgrid minorgridattrs=(color=cxefefef pattern=dot) 
, catlabels = ("Grouping variable")
, catlabelpos = top
, catlabelattrs = &labelstyle.
, cataxisvalueattrs = &valuesstyle.
, formated = 1
, y2axis = 1
, y2axislevels = 5
, y2axisvalueattrs = &valuesstyle.
, y2axisformat = f5.2
, y2axislines = 1
, widthpx = 1200
, heightpx = 350

, SGANNO = WORK.AT_WUSS
, MEANSHIFTLINE=1
, MEANSHIFTSTEP=0.01
, MEANSHIFTCOLORS=gold blue
)
%afterPlot() 





data WORK.AT_WUSS2; 
  function="TEXT"; transparency=0.3; 
  textcolor="CornflowerBlue"; textweight="BOLD";
  widthunit="PERCENT"; drawspace="GRAPHPERCENT";
  width=500;

  label="WUSS(*ESC*){sup '2'}";
  textsize=96; anchor="CENTER";
  textfont="Courier New";
  x1=60; y1=70; rotate=0;
  output;
run;

%beforePlot(109,orientation=PORTRAIT)
%let labelStyle = size=10 family="Courier New" color=MidnightBlue weight=bold;
%let valuesStyle = size=8 family="Courier New" style=italic;
%rainCloudPlot(sashelp.cars(where=(origin in: ("E" "U"))), origin, invoice
, title = %nrstr(title1 J=C HEIGHT=2 "Distribution of cars prices";
                 title2 J=C HEIGHT=1 COLOR=DarkGrey "Europe vs. US";
                )
, footnote = %str(footnote1 J=l H=1 C=Gray "1%) Data from SASHELP.CARS";) /*"*/
, colorslist = OrangeRed OliveDrab
, boxplotfill = 0.5
, boxplotlinesize = 2px
, boxplotsymbolsize = 12px 8px
, raindropsize = 3px
, kernel_k = triangular
, kernel_c = 0.99
, vscale = percent
, vscalemax = 75
, xlabels = ("Analyzed variable")
, xlabelpos = top
, xlabelattrs = &labelstyle.
, xaxisvalueattrs = &valuesstyle.
, xaxistickstyle = across
, xbothaxis = 0
, xaxisvalues=(1e4 to 18e4 by 1e4)
, xaxisvaluesformat=dollar12.2
, xaxisother=grid gridattrs=(thickness=0)
             minor minorgrid minorgridattrs=(color=cxefefef pattern=dot) 
, catlabels = ("Grouping variable")
, catlabelpos = center
, catlabelattrs = &labelstyle.
, cataxisvalueattrs = &valuesstyle.
, formated = 1
, y2axis = 1
, y2axislevels = 5
, y2axisvalueattrs = &valuesstyle.
, y2axisformat = f5.2
, y2axislines = 1
, widthpx = 1200
, heightpx = 400
, sganno = WORK.AT_WUSS2
, meanshiftline=1
, meanshiftstep=0.01
, meanshiftcolors=gold blue

, VERTICAL = 1
, ODSGRAPHICSOPTIONS = NOBORDER
, SGPLOTOPTIONS = NOAUTOLEGEND NOBORDER NOWALL PAD=0
)
%afterPlot() 
