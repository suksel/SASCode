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

/*****************************************************************************/
/*  Terminate the specified CAS session (mySession). No reconnect is possible*/
/*****************************************************************************/

*cas mysession terminate;


