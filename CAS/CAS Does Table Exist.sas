*****************************************************************
* Returns O for not there                                       *
*         1 for session table                                   *
*         2 for global table                                    *
*****************************************************************;

%macro util_tableExists (in_table_nm =  , in_lib = , session = );
                  
proc cas;
      %IF .&session ne . %THEN session &session %str(;);
      table.tableExists result = r  /
      caslib= "&in_lib." name= "&in_table_nm." ;
      tableExists = r.exists;
      print r.exists;
      call symputx ("tableExists_macro" , tableExists);
run;
quit;
 
%mend;

%util_tableExists(in_table_nm=ALCOHOL_DEMAND_2017, in_lib=PUBLIC, session=CASAUTO);
 
