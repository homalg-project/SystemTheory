#############################################################################
##
##  SingularTools.gi                                    SystemTheory package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for the rings provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( SystemTheoryMacrosForSingular,
        rec(
            
    _CAS_name := "Singular",
    
    _Identifier := "SystemTheory",
    
    )

);

##
UpdateMacrosOfCAS( SystemTheoryMacrosForSingular, SingularMacros );
UpdateMacrosOfLaunchedCASs( SystemTheoryMacrosForSingular );

##
InstallValue( SystemTheoryTableForSingularTools,
        
        rec(
               
        )
 );

## enrich the global homalg table for Singular:
AppendToAhomalgTable( CommonHomalgTableForSingularTools, SystemTheoryTableForSingularTools );
AppendTohomalgTablesOfCreatedExternalRings( SystemTheoryTableForSingularTools, IsHomalgExternalRingInSingularRep );
