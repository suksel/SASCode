/* Just so can see what is happening */
options set=CASCLIENTDEBUG=1;

*options cashost="esp-server-d1.uksales.sashq-d.openstack.sas.com" casport=5570;
options cashost="viya-uks.uksales.sashq-r.openstack.sas.com" casport=5570;

cas mysession;

/*****************************************************************************/
/* Create SAS librefs for existing caslibs                                   */
/* So that they are visible in the SAS Studio Libraries tree.               */
/*****************************************************************************/

caslib _all_ assign;


/*******************************************************/                    
/* This code loads the client side table               */
/* arc0.csv into casuser as an in-memory table named   */
/* casuser.arc0.                                       */
/*******************************************************/

/*******************************************************/                     
/*If not already done, create session casauto.         */
/* Specify the host and port info for your session.    */ 
/*                                                     */
/* options cashost="cloud.example.com" casport=nnnn;  */
/*******************************************************/  

cas casauto;                                         
                      

proc casutil;                                                                
  load file="C:\Users\suksel\OneDrive - SAS Institute Inc\Working On\Current Projects\Hypergroup\arc0.csv" 
  casout="arc0"                                                              
  replace;
run;
quit;

/*******************************************************/
/* You can run the same table information and table    */
/* details commands to see that you get the same table */
/* whether you generate it or upload the .csv file.    */
/*******************************************************/

proc cas;
table.tableInfo /                                                           
  table="arc0";
run;

table.tableDetails /                                                         
  table="arc0";
run;
quit;