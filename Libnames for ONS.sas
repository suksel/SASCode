/* Libnames we will use - this could become part of autoexec file */

libname ons_sas '~/data/ONS_CTK_API/sasdata';
libname task_sas '~/data/ONS_CTK_API/taskR';

/* Move to LIBNAMES.sas once working this is for CPIH - the aggregate values  */
libname aggr_out '~/data/ONS_CTK_API/aggR';

/* Filename only exists temporarily it will have the return from the HTTP call */

/* Used to get the available Datasets */
filename resp temp; 
/* Used to get the returned values from chosen Dataset */
filename resp1 temp;
/* Spare can be used */
filename resp2 temp;

