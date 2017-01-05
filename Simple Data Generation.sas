/* Libraries point to the location of the Formats and the Final destination table */
libname library 'c:\temp';
libname out 'c:\temp';

/* Generates a Format called PROD and another called REGION
Prod has 3 values - hence i loop below is 1 to 3
Region has 7 values - hence r loop below is 1 to 7
*/
proc format ;
    value prod 1='Current Account' 2='Debit Account' 3='Credit Cards';
    value region 1='Northern Ireland' 2='Scotland' 3='North West' 
        4='North East' 5='South West' 6='Midlands' 7='South East';
run;

/* Table called CARDS will be created in the c:\temp folder */
data out.cards;
    /* Setting a length for the prodc and regionc variables this must be larger than the
    length of the longest string in the corresponding format - but not too large or you waste
    space in memory */
    length prodc $16 regionc $18;

    /* Data will be generated from the 01Jan2008 to 01November2014 by 1s i.e every day */
    do date='01Jan2008'd to '01Nov2014'd;

        /* PRODUCT LOOP */
        do i=1 to 3;

            /* REGION LOOP */
            do r=1 to 7;

                /* Creates PRODC and REGION by using the numbers and looping through
                the PROD and REGION Format */
                prodc=put(i, $prod.);
                regionc=put(r, $region.);

                /* Premium is then randomly created between 1 and 100 - the int makes it an INTEGER 
                   If you use (0) as the seed the numbers will change every time. */
                premium=int(ranuni(2)*100);

                /* Not surprisingly OUTPUT writes records out to the Table called CARDS - it is needed
                because of the DO Loops - if you put it elsewhere you will get different number of
                records */
                output;
            end;
        end;
    end;

    /* Puts nice labels on the variables */
    label prodc='Product' regionc='Region' premium='Premium' date='Date';

    /* i and r are the loop counters you dont need them so could just drop them - or use them in
    other formulas? - remove the star to uncomment */
    *drop i r;

    /* Format statement makes the numeric data field show up as a text string like JAN08 - but because its
    a number you can do all sorts of nice calculations on it */
    format date monyy.;
run;