 /* Using SAS Studio to load data */

libname toy 'C:\Users\suksel\OneDrive - SAS Institute Inc\Working On\M\Manufacturing\Insight Toy';

 /* Removes Global Table if there */
proc casutil ;
 droptable incaslib="G_CAS" casdata="toy_party_bead" quiet;
run;

 /* Creates new Global Table */
data G_CAS.Toy_Party_Bead(promote=yes);
 set toy.toydata;
 
 if ProductMake = 'Party Bead';
 
 NewOrderTotal = OrderTotal*1.10;
 
 keep ProductMake OrderTotal NewOrderTotal;
run;
