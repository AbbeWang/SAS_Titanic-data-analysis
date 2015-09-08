
/*--Q1. Importing dataset--*/
PROC import DBMS=csv out=train REPLACE
	DATAFILE= "/folders/myfolders/train.csv";
	DELIMITER= ",";
	GETNAMES= YES;
RUN;
/*--Q1. Ends--*/




/*--Q2. Population distribution based on Cabin--*/
DATA WORK.TRAIN;
	SET WORK.TRAIN;
	IF MISSING(Cabin) OR Cabin = "T"  THEN Cabin= "U";
RUN;

/*Visualizing the table*/
TITLE 'Q2. Population Distribution Based on Cabin';
ODS graphics / reset width=30in height=8in imagemap;

PROC SGPLOT data=WORK.TRAIN;
	VBAR Cabin / FILLATTRS=(color=CX4c60a2);
	yaxis GRID;
RUN;
/*--Q2. Ends--*/




/*--Q3. Class distribution by Cabin--*/
PROC FREQ DATA=WORK.TRAIN;
	TITLE 'Q3. Table of Cabin by Pclass';
	TABLES Cabin*Pclass;
RUN;

/*Visualizing the table*/
TITLE 'Q3. Class Distribution by Cabin';
ODS graphics / reset width=30in height=8in imagemap;

PROC SGPLOT data=WORK.TRAIN;
	VBAR Cabin/ GROUP=Pclass groupdisplay=Cluster;
	yaxis GRID;
RUN;
/*--Q3. Ends--*/




/*--Q4. Survival rate based on Cabin--*/
/*Updating "Survived" column for better readability*/
DATA WORK.TRAIN;
	LENGTH Survived $ 3;
	SET WORK.TRAIN (RENAME=(Survived=Survival));
	IF Survival = 0 THEN Survived = "No";
	ELSE Survived = "Yes";
RUN;

ODS NOPROCTITLE;
PROC FREQ DATA=WORK.TRAIN;
	TITLE 'Q4. Table of Cabin by Survived';
	TABLES Cabin*Survived / NOROW NOPERCENT;
RUN;

/*Visualizing the table*/
TITLE 'Q4. Survival Rate Distribution by Cabin';
ODS graphics / reset width=30in height=8in imagemap;

PROC SGPLOT data=WORK.TRAIN;
	VBAR Cabin / GROUP=Survived groupdisplay=Cluster;
	yaxis GRID;
RUN;
/*--Q4. Ends--*/




/*--Q5. Correlation between survival rate and traveling with family or not--*/
/*Adding a new column "IsAlone" to illustrate if people were travelling alone*/
DATA WORK.TRAIN;
	SET WORK.TRAIN;
	LENGTH IsAlone $ 12;
	IF SibSp + Parch > 0 THEN IsAlone = "With Family";
	ELSE IsAlone = "Alone";
RUN;

ODS NOPROCTITLE;
PROC FREQ DATA=WORK.TRAIN;
	TITLE 'Q5. Table of IsAlone by Survived';
	TABLES IsAlone*Survived / NOROW NOPERCENT;
RUN;

/*Visualizing the table*/
TITLE 'Q5. Survival Rate Distribution by Traveling with Family or not';
ODS graphics / reset width=4in height=4in imagemap;

PROC SGPLOT data=WORK.TRAIN;
	VBAR IsAlone / GROUP=Survived groupdisplay=Cluster;
	yaxis GRID;
RUN;
/*--Q5. Ends--*/


/*--Based on the output, it is likely that having a family member increase the odds of surviving the crash.--*/








