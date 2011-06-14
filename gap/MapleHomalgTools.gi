#############################################################################
##
##  MapleHomalgTools.gi                                 SystemTheory package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for the rings provided by the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( SystemTheoryHomalgTableForMapleHomalgTools,
        
        rec(
            
        )
 );

## enrich the global homalg table for MapleHomalg:
AppendToAhomalgTable( CommonHomalgTableForMapleHomalgTools, SystemTheoryHomalgTableForMapleHomalgTools );
