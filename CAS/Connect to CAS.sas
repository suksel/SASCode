   /* Just so can see what is happening */
options set=CASCLIENTDEBUG=1;

 /* REMEMBER the LINUX BOX not the Windows frontend :) */
options cashost="172.28.235.173" casport=5570;


cas mysession;

/*****************************************************************************/
/* Create SAS librefs for existing caslibs                                   */
/* So that they are visible in the Libraries tree.                           */
/*****************************************************************************/

caslib _all_ assign;

/*****************************************************************************/
/*  Terminate the specified CAS session (mySession). No reconnect is possible*/
/*****************************************************************************/

*cas mysession terminate;