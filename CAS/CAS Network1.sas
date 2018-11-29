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

 /* Removes Global Table if there */
proc casutil ;
 droptable incaslib="G_CAS" casdata="LinkSetInTerror911" quiet;
run;


data G_CAS.LinkSetInTerror911(promote=yes);
   input from & $32. to & $32.;
   datalines;
Abu Zubeida                Djamal Beghal
Jean-Marc Grandvisir       Djamal Beghal
Nizar Trabelsi             Djamal Beghal
Abu Walid                  Djamal Beghal
Abu Qatada                 Djamal Beghal
Zacarias Moussaoui         Djamal Beghal
Jerome Courtaillier        Djamal Beghal
Kamel Daoudi               Djamal Beghal
Abu Walid                  Kamel Daoudi
Abu Walid                  Abu Qatada
Kamel Daoudi               Zacarias Moussaoui
Kamel Daoudi               Jerome Courtaillier
Jerome Courtaillier        Zacarias Moussaoui
Jerome Courtaillier        David Courtaillier
Zacarias Moussaoui         David Courtaillier
Zacarias Moussaoui         Ahmed Ressam
Zacarias Moussaoui         Abu Qatada
Zacarias Moussaoui         Ramzi Bin al-Shibh
Zacarias Moussaoui         Mahamed Atta
Ahmed Ressam               Haydar Abu Doha
Mehdi Khammoun             Haydar Abu Doha
Essid Sami Ben Khemais     Haydar Abu Doha
Mehdi Khammoun             Essid Sami Ben Khemais
Mehdi Khammoun             Mohamed Bensakhria
;
run;

proc network
   links    = G_CAS.LinkSetInTerror911
   outNodes = G_CAS.NodeSetOut;
   biconnectedComponents;
run;

 /* The output data table mycas.ArtPoints contains members of the network who are articulation points. 
    By focusing on cutting off these particular members, 
    investigators could have significantly disrupted the terrorists’ ability to communicate when planning the attack. */
data G_CAS.ArtPoints;
   set   G_CAS.NodeSetOut;
   where artpoint=1;
run;