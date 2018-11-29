/*****************************************/
/* Expand the simple HyperGroup run:     */
/* Get the layout, and add colors,       */
/* communities, and centralities.        */
/*****************************************/
proc cas;                                                      

hyperGroup.hypergroup /                                         /*1*/
 centrality  =true,                                             /*2*/
 community   =true,                                             /*3*/
 table       ={name="arc0"},                                    /*4*/
 inputs      ={                                                 /*5*/
              {name="varA"},{name="varB"},
              {name="varC"},{name="varD"}},
 casOut      ={name="out", replace=true},                       /*6*/
 edges       ={name="Eout",replace=true},                       /*7*/
 vertices    ={name="Vout",replace=true}                        /*8*/
; 
run;