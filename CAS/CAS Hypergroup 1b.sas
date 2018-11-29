cas casauto sessopts=(caslib="casuser");                        /*1*/

/*******************************************************/
/* Load the hyperGroup actionSet                       */
/*******************************************************/
proc cas;                                                        /*2*/
  builtins.loadactionset / 
    actionSet="hyperGroup";
run;

quit;

/*****************************************/
/* Start with a simple HyperGroup run:   */
/* Get the layout (Edges and Vertices)   */
/* Use the single default color.         */
/*****************************************/
proc cas;                                                       
hyperGroup.hypergroup /                                          /*3*/
 noColor   =true,                                                /*4*/
 table     ={name="arc0"},                                       /*5*/
 inputs    ={                                                    /*6*/
            {name="varA"},{name="varB"},
            {name="varC"},{name="varD"}},
 casOut    ={name="out",replace=true},                           /*7*/
 edges     ={name="Eout",replace=true},                          /*8*/
 vertices  ={name="Vout",replace=true}                           /*9*/
; 
run;
quit;

caslib _all_ assign;
