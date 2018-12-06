 /* From the Documentation this is Pre-Production */

proc template;                                                                  
   define style styles.mystyle;                                                 
   parent = styles.word;                                                        
   class pageno /                                                               
    content = "Page {PAGE} of {NUMPAGES}";                                                                            
   end;
run;
ods graphics on;

ods word file="c:\temp\pagexofy.docx" title="Page X of Y test" style=mystyle;
proc freq data=sashelp.class;                                                   
   tables age*sex/plots=freq;                                                   
run;
ods word close; 