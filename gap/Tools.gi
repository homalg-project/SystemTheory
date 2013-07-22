#############################################################################
##
##  Tools.gi                                            SystemTheory package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations of tool procedures.
##
#############################################################################

####################################
#
# global variables:
#
####################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( GeneralEndomorphism,
        "for a homalg module and an integer",
        [ IsHomalgModule, IsInt, IsList ],
        
  function( M, bound, l )
    local EndM, n, morphisms, R, i, A, indets, r, morphism_r, alpha, beta;
    
    if bound < 0 then
        Error( "the bound should be non-negative\n" );
    fi;
    
    EndM := End( M );
    
    ByASmallerPresentation( EndM );
    
    n := NrGenerators( EndM );
    
    morphisms := GetGenerators( EndM );
    
    R := HomalgRing( M );
    
    r := GeneralLinearCombination( R, bound, l, n );
    
    A := HomalgRing( r[1] );
    
    morphisms := List( morphisms, phi -> A * phi );
    
    morphism_r := List( [ 1 .. n ], i -> r[i] * morphisms[i] );
    
    alpha := morphism_r[1];
    
    for i in [ 2 .. n ] do
        
        alpha := alpha + morphism_r[i];
        
    od;
    
    ## check assertion
    Assert( 4, IsMorphism( alpha ) );
    
    SetIsMorphism( alpha, true );
    
    alpha!.AssociatedSourceModule := M;
    alpha!.AssociatedRangeModule := M;
    
    return alpha;
    
end );

## naive reduction (might be renamed in the future)
InstallMethod( \/,
        "for an ideal and a morphism",
        [ IsHomalgStaticMorphism, IsHomalgModule and ConstructedAsAnIdeal ],
        
  function( alpha, P )
    local A, S, T, R, gamma;
    
    A := HomalgRing( alpha );
    
    if not IsIdenticalObj( A, HomalgRing( P ) ) then
        Error( "the two rings must be identical\n" );
    fi;
    
    if IsBound( alpha!.AssociatedSourceModule ) then
        S := alpha!.AssociatedSourceModule;
    else
        S := Source( alpha );
    fi;
    
    if IsBound( alpha!.AssociatedRangeModule ) then
        T := alpha!.AssociatedRangeModule;
    else
        T := Range( alpha );
    fi;
    
    R := HomalgRing( S );
    
    gamma := HomalgMap(
                     R * DecideZero( MatrixOfMap( alpha ),
                             MatrixOfGenerators( P ) ),
                     S, T );
    
    if HasIsMorphism( alpha ) and IsMorphism( alpha ) then
        
        ## it is not safe to use the following commented out lines
        ## as the base change will set all indeterminates to zero,
        ## also an indeterminate b which satisfies a relation like b^2+1
        #Assert( 3, IsMorphism( gamma ) );
        
        #SetIsMorphism( gamma, true );
        
        IsMorphism( gamma );
        
    fi;
    
    return gamma;
    
end );
