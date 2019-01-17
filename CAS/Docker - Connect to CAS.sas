options set=CASCLIENTDEBUG=1;

/*****************************************************************************/
/*  Set the options necessary for creating a connection to a CAS server.     */
/*  Once the options are set, the cas command connects the default session   */
/*  to the specified CAS server and CAS port, for example the default value  */
/*  is 5570.                                                                 */
/*  Remember may need to modify the _authinfo file                           */
/*****************************************************************************/
options cashost="localhost" casport=5570;
cas;

/*****************************************************************************/
/*  Create a default CAS session and create SAS librefs for existing caslibs */
/*  so that they are visible in the SAS Studio Libraries tree.               */
/*****************************************************************************/
caslib _all_ assign;