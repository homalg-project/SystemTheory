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
