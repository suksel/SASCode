/*****************************************************************************/
/*  Create a default CAS session and create SAS librefs for existing caslibs */
/*  so that they are visible in the SAS Studio Libraries tree.               */
/*****************************************************************************/

cas; 
caslib _all_ assign;

 
proc casutil;
   droptable casdata="SEL_HMEQ" incaslib="public" quiet;
run;


data public.SEL_HMEQ(promote=yes);
 set public.hmeq;
 label bad="1 = Client Defaulted 0 = Repaid"
       loan="Amount of Loan Requested"
       mortdue="Amount Due on Existing Mortage"
      value="Value of Current Property"
      reason="DebtCon = Debt Consolidation HomeImp = Home Improvement"
         job="Occupational Categories"
         yoj="Years at Present Job"
      derog="Number of Major Derogatory Reports"
      delinq="Number of Delinquent Credit Lines"
      clage="Age of Oldest Trade Line in Month"
       ninq="Number of Recent Credit Lines"
       clno="Number of Credit Lines"
debtinc="Debt-to-income Ratio"
;
run;

proc casutil;
    save casdata="SEL_HMEQ" incaslib="public" outcaslib="public"
	     casout="SEL_HMEQ" replace;
quit;


