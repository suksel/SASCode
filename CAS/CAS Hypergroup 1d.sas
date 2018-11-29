/***************************************************************/
/* Continue to expand the simple run. Get layout, colors,      */
/* communities, and centralities. Create structural graphs for */
/* both colors and communities. Maxnodes property is specified */
/* as 6.0 to ensure more than one color is used. Since there   */
/* is only one community, the edges3 table will have no rows.  */
/***************************************************************/

proc cas;                                                       

hyperGroup.hypergroup /                                               /*1*/
 centrality    =true,                                                 /*2*/
 community     =true,                                                 /*3*/
 maxNodes      =6.0,                                                  /*4*/
 structural    ="BOTH",                                               /*5*/
 table         ={name="arc0"},                                        /*6*/  
 inputs        ={
                {name="varA"},{name="varB"},
                {name="varC"},{name="varD"}},                         /*7*/
 casOut        ={name="out", replace=true},                           /*8*/
 edges         ={name="Eout", replace=true},                          /*9*/
 edges2        ={name="EColorStrl",replace=true},                     /*10*/
 edges3        ={name="ECommStrl", replace=true},                     /*11*/
 vertices      ={name="Vout", replace=true},                          /*12*/
 vertices2     ={name="VColorStrl", replace=true},                    /*13*/
 vertices3     ={name="VCommStrl", replace=true}                      /*14*/
;
run;
