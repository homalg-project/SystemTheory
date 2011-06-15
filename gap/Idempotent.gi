#############################################################################
##
##  Idempotent.gi                                     SystemTheory package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( NonTrivialEndomorphismIdempotents,
        "for a homalg module",
        [ IsHomalgModule ],
  
  function( M )
  local R, indets, alpha, A, indetsA, beta, I, res;
    
    R := HomalgRing( M );
    
    indets := Indeterminates( R );
    
    alpha := GeneralEndomorphism( M, 0, List( [ 1 .. Length( indets ) ], i -> 1 ) );
    
    A := HomalgRing( alpha );
    
    indetsA := List( indets, a -> a / A );
    
    beta := alpha^2 - alpha;
    
    DecideZero( beta );
    
    I := IdealOfCoefficients( MatrixOfMap( beta ), indetsA );
    
    res := APoint( I );
    
    Error("test");
    
    
end );

##
InstallMethod( GeneralEndomorphism,
        "for a homalg module and an integer",
        [ IsHomalgModule, IsInt, IsList ],
    
  function( M, bound, l )
    local EndM, n, morphisms, R, i, A, indets, r, morphism_r, alpha, beta;
    
    if bound < 0 then
        Error( "the bound should be non-negative\n" );
    fi;
    
    EndM := Hom( M, M );
    
    ByASmallerPresentation( EndM );
    
    n := NrGenerators( EndM );
    
    morphisms := List( [ 1 .. n ], i -> GetGenerators( EndM, i ) );
    
    morphisms := List( morphisms, m -> HomalgMap( m, M, M ) );
    
    R := HomalgRing( M );
    
    r := GeneralLinearCombination( R, bound, l, n );
    
    A := HomalgRing( r[1] );
    
    morphisms := List( morphisms, phi -> A * phi );
    
    morphism_r := List( [ 1 .. n ], i -> r[i] * morphisms[i] );
    
    alpha := morphism_r[1];
    
    for i in [ 2 .. n ] do
        
        alpha := alpha + morphism_r[i];
        
    od;
    
    return alpha;
    
end );
