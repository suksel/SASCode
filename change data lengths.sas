libname bp 'C:\Public\BP';

%macro change(dsn);                                         
                                                            
data _null_;                                                
  set &dsn;                                                 
  array qqq(*) _character_;                                 
  call symput('siz',put(dim(qqq),5.-L));                    
  stop;                                                     
run;                                                        
                                                            
data _null_;                                                
  set &dsn end=done;                                        
  array qqq(&siz) _character_;                              
  array www(&siz.);                                         
  if _n_=1 then do i= 1 to dim(www);                        
    www(i)=0;                                               
  end;                                                      
  do i = 1 to &siz.;                                        
    www(i)=max(www(i),length(qqq(i)));                      
  end;                                                      
  retain _all_;                                             
  if done then do;                                          
    do i = 1 to &siz.;                                      
      length vvv $50;                                       
      vvv=catx(' ','length',vname(qqq(i)),'$',www(i),';');  
      fff=catx(' ','format ',vname(qqq(i))||' '||           
          compress('$'||put(www(i),3.)||'.;'),' ');         
      call symput('lll'||put(i,3.-L),vvv) ;                 
      call symput('fff'||put(i,3.-L),fff) ;                 
    end;                                                    
  end;                                                      
run;                                                        
                                                            
data &dsn._;                                                
  %do i = 1 %to &siz.;                                      
    &&lll&i                                                 
    &&fff&i                                                 
  %end;                                                     
  set &dsn;                                                 
run;                                                        
                                                            
%mend;                                                      
      /* Note one of the tables _azer needs renaming to get under 32 characters !*/  
%change(bp.Permit_hazards_and_controls_ns);
%change(bp.Permit_hazards_and_controls_mex);
%change(bp.Permit_hazards_and_controls_az); 
%change(bp.Permit_hazards_and_controls_t);  

data bp.full;
 set bp.Permit_hazards_and_controls_ns_ 
     bp.Permit_hazards_and_controls_mex_
	 bp.Permit_hazards_and_controls_az_
	 bp.Permit_hazards_and_controls_t_
	 ;
run;
