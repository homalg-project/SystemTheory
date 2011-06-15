#############################################################################
##
##  SystemTheory.gi                                     SystemTheory package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for k-points.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( SpecializationToCoimage,
        "for homalg morphisms",
        [ IsHomalgMorphism ],
    
  function( phi )
    
    if not IsMonomorphism( phi ) then
    
        return ImageObjectEpi( phi );
    
    else
    
        return fail;
    
    fi;
    
end );