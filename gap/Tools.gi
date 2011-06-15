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
    
    A := R;
    
    r := [ ];
    
    for i in [ 1 .. n ] do
        
        s := Concatenation( "b_", String( i ), "_0..", String( m - 1 ) );
        
        # todo: better names for the bi: use the corresponding degree of the monomial
        A := A * s;
        
        indets := HomalgMatrix( RelativeIndeterminatesOfPolynomialRing( A ), 1, m, A );
        
        mat := A * mat;
        
        Add( r, GetEntryOfHomalgMatrix( indets * mat, 1, 1 ) );
        
    od;
    
    r := List( r, rr -> rr / A );
    
    return r;
    

end );
