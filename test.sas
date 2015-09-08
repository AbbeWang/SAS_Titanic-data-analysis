PROC import DBMS=csv out=train REPLACE
	DATAFILE= "/folders/myfolders/train.csv";
	DELIMITER= ",";
	GETNAMES= YES;
RUN;


/*--Q2. Population distribution based on deck/Cabin--*/
DATA WORK.TRAIN;
	SET WORK.TRAIN;
	IF MISSING(Cabin) OR Cabin = "T"  THEN Cabin= "U";
RUN;
