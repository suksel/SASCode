cas s;
libname cas cas;

data cas.a;
	x=42;
	format x f8.2;
	y=2021;
	format y roman12.;
run;

proc cas;
	fetch/table='a', format=true;
	columninfo result=r / table='a';
	cols={};

	do row over r.ColumnInfo;
		cols=cols + {{name=row.Column, format=""}};
	end;
	altertable / table='a', columns=cols;
	fetch/table='a', format=true;
quit;