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

## saturating I0 and I1 guarantees getting rid of these two maxmimal ideals
## from the list of minimal associated primes BUT NOT from the support!!!
## so the name IdealDefiningNonTrivialEndomorphismIdempotents
## is not entirely justified as constructed idempotents
## might still be trivial, i.e. zero or one.
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
    
    ## see the above comment
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

##  <#GAPDoc Label="GeneralNonTrivialEndomorphismIdempotent">
##  <ManSection>
##    <Oper Arg="M, bound[, l]" Name="GeneralNonTrivialEndomorphismIdempotent" Label="for a module and a nonnegative integer"/>
##    <Description>
##       This operation takes a module <A>M</A>, a nonnegative integer <A>bound</A>, and optionally a third list of weights <A>l</A>. It returns a nontrivial general idempotent of the endomorphism ring of <A>M</A>.
##      <#Include Label="HairyBall">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( NonTrivialGeneralEndomorphismIdempotent,
        "for a homalg module",
        [ IsHomalgModule, IsInt, IsList ],
        
  function( M, bound, l )
    local I, aleph, alpha, gamma;
    
    I := IdealDefiningNonTrivialEndomorphismIdempotents( M, bound, l );
    
    if I = HomalgRing( I ) then
        return false;
    fi;
    
    if IsBound( I!.GeneralEndomorphism ) then
        
        aleph := I!.GeneralEndomorphism;
        
        if aleph[1] = [ bound, l ] then
            
            alpha := aleph[2];
            
        fi;
        
    fi;
    
    if not IsBound( alpha ) then
        
        ## recompute
        alpha := GeneralEndomorphism( M, bound, l );
        
        ## the redefined alpha over the ambient ring
        ## might even fail to be a morphism
        alpha := HomalgRing( I ) * alpha;
        
    fi;
    
    gamma := ( HomalgRing( alpha ) / I ) * alpha;
    
    DecideZero( gamma );
    
    Assert( 1, IsMorphism( gamma ) );
    
    SetIsMorphism( gamma, true );
    
    Assert( 1, IsIdempotent( gamma ) );
    
    SetIsIdempotent( gamma, true );
    
    Assert( 1, not IsZero( gamma ) );
    
    SetIsZero( gamma, false );
    
    Assert( 1, not IsOne( gamma ) );
    
    SetIsOne( gamma, false );
    
    gamma!.IdealDefiningNonTrivialEndomorphismIdempotents := I;
    
    return gamma;
    
end );

##
InstallMethod( NonTrivialGeneralEndomorphismIdempotent,
        "for a homalg module",
        [ IsHomalgModule, IsInt ],
        
  function( M, bound )
    local n, l;
    
    n := Length( Indeterminates( HomalgRing( M ) ) );
    
    l := ListWithIdenticalEntries( n, 1 );
    
    return NonTrivialGeneralEndomorphismIdempotent( M, bound, l );
    
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
    local I, ass_max_codim, R, aleph, alpha, p, gamma;
    
    I := IdealDefiningNonTrivialEndomorphismIdempotents( M, bound, l );
    
    if I = HomalgRing( I ) then
        return false;
    fi;
    
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
        
        ## the redefined alpha over the ambient ring
        ## might even fail to be a morphism
        alpha := HomalgRing( I ) * alpha;
        
    fi;
    
    for p in ass_max_codim do
        
        gamma := alpha / p;	## naive reduction (see Tools.gi)
        
        if IsMorphism( gamma ) and
           not IsZero( gamma ) and
           not IsOne( gamma ) and
           IsIdempotent( gamma ) then
            
            return gamma;
            
        fi;
        
    od;
    
    ## it is not safe to use the following commented out lines;
    ## see the comment in the naive reduction method in Tools.gi
    ## and the comment in IdealDefiningNonTrivialEndomorphismIdempotents
    
    #Assert( 1, IsIdempotent( gamma ) );
    
    #SetIsIdempotent( gamma, true );
    
    #Assert( 1, not IsZero( gamma ) );
    
    #SetIsZero( gamma, false );
    
    #Assert( 1, not IsOne( gamma ) );
    
    #SetIsOne( gamma, false );
    
    #return gamma;
    
    Info( InfoWarning, HOMALG_SystemTheory.InfoWarningForNonTrivialEndomorphismIdempotent,
          "non of the computed naive reductions (of the general endomorphism) ",
          "modulo the associated ideals of maximal codimension produced ",
          "a nontrivial idempotent, please try NonTrivialGeneralEndomorphismIdempotent"
          );
    
    return fail;
    
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
    
    if I = HomalgRing( I ) then
        return false;
    fi;
    
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
        
        ## the redefined alpha over the ambient ring
        ## might even fail to be a morphism
        alpha := HomalgRing( I ) * alpha;
        
    fi;
    
    idems := [ ];
    
    for p in P do
        
        gamma := alpha / p;	## naive reduction (see Tools.gi)
        
	## it is not safe to use the following commented out lines;
        ## see the comment in the naive reduction method in Tools.gi
        ## and the comment in IdealDefiningNonTrivialEndomorphismIdempotents
	
        #Assert( 1, IsIdempotent( gamma ) );
        
        #SetIsIdempotent( gamma, true );
        
        #Assert( 1, not IsZero( gamma ) );
        
        #SetIsZero( gamma, false );
        
        #Assert( 1, not IsOne( gamma ) );
        
        #SetIsOne( gamma, false );
        
        #Add( idems, gamma );
        
        if IsMorphism( gamma ) and
           not IsZero( gamma ) and
           not IsOne( gamma ) and
           IsIdempotent( gamma ) then
            
            Add( idems, gamma );
            
        fi;
        
    od;
    
    if idems = [ ] then
        Info( InfoWarning, HOMALG_SystemTheory.InfoWarningForNonTrivialEndomorphismIdempotent,
              "non of the computed naive reductions (of the general endomorphism) ",
              "modulo the associated ideals produced a nontrivial idempotent, ",
              "please try NonTrivialGeneralEndomorphismIdempotent"
              );
        
        return fail;
    fi;
    
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
