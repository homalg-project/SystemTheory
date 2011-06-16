##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/SystemTheory.bib" );
WriteBibXMLextFile( "doc/SystemTheoryBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "SystemTheory" )[1].Version );

MakeGAPDocDoc( "doc", "SystemTheoryForHomalg", list, "SystemTheoryForHomalg" );

GAPDocManualLab("SystemTheory");

quit;

