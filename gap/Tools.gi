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
InstallMethod( GeneralLinearCombination,
        "for a homalg ring, an integer, a list and an integer",
        [ IsHomalgRing, IsInt, IsList, IsInt ],
        
  function( R, bound, l, n )
    local mat, m, A, r, i, s, indets;
    
    mat := MonomialMatrixWeighted( 0, R, l );
    
    for i in [ 1 .. bound ] do
        
        mat := UnionOfRows( mat, MonomialMatrixWeighted( i, R, l ) );
        
    od;
    
    m := NrRows( mat );
    
    # todo: better names for the bi: use the corresponding degree of the monomial
    s := List( [ 1 .. n ], i -> Concatenation( "b_", String( i ), "_0..", String( m - 1 ) ) );
    
    s := JoinStringsWithSeparator( s );
    
    A := R * s;
    
    indets := RelativeIndeterminatesOfPolynomialRing( A );
    
    indets := ListToListList( indets, n, m );
    
    indets := List( indets, l -> HomalgMatrix( l, 1, m, A ) );
    
    mat := A * mat;
    
    r := List( indets, i -> GetEntryOfHomalgMatrix( i * mat, 1, 1 ) );
    
    return List( r, rr -> rr / A );
    
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
    Assert( 2, IsMorphism( alpha ) );
    
    SetIsMorphism( alpha, true );
    
    alpha!.AssociatedSourceModule := M;
    alpha!.AssociatedRangeModule := M;
    
    return alpha;
    
end );

##
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
        
        Assert( 1, IsMorphism( gamma ) );
        
        SetIsMorphism( gamma, true );
        
    fi;
    
    return gamma;
    
end );
