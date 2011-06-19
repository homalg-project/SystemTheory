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
InstallMethod( IdealDefiningNonTrivialEndomorphismIdempotents,
        "for a homalg module",
        [ IsHomalgModule, IsInt, IsList ],
        
  function( M, bound, l )
    local R, indets, alpha, A, I0, indetsA, I1, beta, I;
    
    R := HomalgRing( M );
    
    indets := Indeterminates( R );
    
    alpha := GeneralEndomorphism( M, bound, l );
    
    A := HomalgRing( alpha );
    
    I0 := LeftSubmodule( RelativeIndeterminatesOfPolynomialRing( A ) );

    indetsA := List( indets, a -> a / A );
    
    I1 := IdealOfCoefficients( alpha - TheIdentityMorphism( Source( alpha ) ), indetsA );
    
    beta := alpha^2 - alpha;
    
    DecideZero( beta );
    
    I := IdealOfCoefficients( beta, indetsA );
    
    I := Saturate( I, I0 );
    
    I := Saturate( I, I1 );
    
    I!.GeneralEndomorphism := [ [ bound, l ], alpha ];
    
    return I;
    
end );

##
InstallMethod( IdealDefiningNonTrivialEndomorphismIdempotents,
        "for a homalg module",
        [ IsHomalgModule, IsInt ],
        
  function( M, bound )
    local n, l;
    
    n := Length( Indeterminates( HomalgRing( M ) ) );
    
    l := ListWithIdenticalEntries( n, 1 );
    
    return IdealDefiningNonTrivialEndomorphismIdempotents( M, bound, l );
    
end );

##  <#GAPDoc Label="NonTrivialEndomorphismIdempotent">
##  <ManSection>
##    <Oper Arg="M, bound[, l]" Name="NonTrivialEndomorphismIdempotent" Label="for a module and a nonnegative integer"/>
##    <Description>
##       This operation takes a module <A>M</A>, a nonnegative integer <A>bound</A>, and optionally a third list of weights <A>l</A>. It returns a nontrivial idempotent of the endomorphism ring of <A>M</A>.
##      <#Include Label="TankModel">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( NonTrivialEndomorphismIdempotent,
        "for a homalg module",
        [ IsHomalgModule, IsInt, IsList ],
        
  function( M, bound, l )
    local I, ass_max_codim, R, aleph, alpha, gamma;
    
    I := IdealDefiningNonTrivialEndomorphismIdempotents( M, bound, l );
    
    ass_max_codim := AssociatedPrimesOfMaximalCodimension( I );
    
    if ass_max_codim = [ ] then
        TryNextMethod( );
    fi;
    
    R := HomalgRing( M );
    
    if IsBound( I!.GeneralEndomorphism ) then
        
        aleph := I!.GeneralEndomorphism;
        
        if aleph[1] = [ bound, l ] then
            
            alpha := aleph[2];
            
        fi;
        
    fi;
    
    if not IsBound( alpha ) then
        
        ## recompute
        alpha := GeneralEndomorphism( M, bound, l );
        
        alpha := HomalgRing( I ) * alpha;
        
    fi;
    
    gamma := alpha / ass_max_codim[1];
    
    Assert( 1, IsIdempotent( gamma ) );
    
    SetIsIdempotent( gamma, true );
    
    Assert( 1, not IsZero( gamma ) );
    
    SetIsZero( gamma, false );
    
    Assert( 1, not IsOne( gamma ) );
    
    SetIsOne( gamma, false );
    
    return gamma;
    
end );

##
InstallMethod( NonTrivialEndomorphismIdempotent,
        "for a homalg module",
        [ IsHomalgModule, IsInt ],
        
  function( M, bound )
    local n, l;
    
    n := Length( Indeterminates( HomalgRing( M ) ) );
    
    l := ListWithIdenticalEntries( n, 1 );
    
    return NonTrivialEndomorphismIdempotent( M, bound, l );
    
end );

##  <#GAPDoc Label="ManyNonTrivialEndomorphismIdempotents">
##  <ManSection>
##    <Oper Arg="M, bound[, l]" Name="NonTrivialEndomorphismIdempotents" Label="for a module and a nonnegative integer"/>
##    <Description>
##       This operation takes a module <A>M</A>, a nonnegative integer <A>bound</A>, and optionally a third list of weights <A>l</A>. It returns nontrivial idempotents of the endomorphism ring of <A>M</A>.
##      <#Include Label="TankModel2">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( NonTrivialEndomorphismIdempotents,
        "for a homalg module",
        [ IsHomalgModule, IsInt, IsList ],
        
  function( M, bound, l )
    local I, P, R, aleph, alpha, gamma, idems, p;
    
    I := IdealDefiningNonTrivialEndomorphismIdempotents( M, bound, l );
    
    P := AssociatedPrimes( I );
    
    if P = [ ] then
        TryNextMethod( );
    fi;
    
    R := HomalgRing( M );
    
    if IsBound( I!.GeneralEndomorphism ) then
        
        aleph := I!.GeneralEndomorphism;
        
        if aleph[1] = [ bound, l ] then
            
            alpha := aleph[2];
            
        fi;
        
    fi;
    
    if not IsBound( alpha ) then
        
        ## recompute
        alpha := GeneralEndomorphism( M, bound, l );
        
        alpha := HomalgRing( I ) * alpha;
        
    fi;
    
    idems := [ ];
    
    for p in P do
        
        gamma := alpha / p;
        
        Assert( 1, IsIdempotent( gamma ) );
        
        SetIsIdempotent( gamma, true );
        
        Assert( 1, not IsZero( gamma ) );
        
        SetIsZero( gamma, false );
        
        Assert( 1, not IsOne( gamma ) );
        
        SetIsOne( gamma, false );
        
        Add( idems, gamma );
        
    od;
    
    return idems;
    
end );

##
InstallMethod( NonTrivialEndomorphismIdempotents,
        "for a homalg module",
        [ IsHomalgModule, IsInt ],
        
  function( M, bound )
    local n, l;
    
    n := Length( Indeterminates( HomalgRing( M ) ) );
    
    l := ListWithIdenticalEntries( n, 1 );
    
    return NonTrivialEndomorphismIdempotents( M, bound, l );
    
end );
