##  <#GAPDoc Label="TankModel2">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( "alpha" ) * "d,delta";;
##  gap> m := HomalgMatrix( "[ \
##  > d, -d*delta^2, alpha*d^2*delta, \
##  > d*delta^2,-d,alpha*d^2*delta \
##  > ]", 2, 3, R );
##  <A 2 x 3 matrix over an external ring>
##  gap> M := LeftPresentation( m );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> idems := NonTrivialEndomorphismIdempotents( M, 0 );
##  [ <A nontrivial idempotent of a left module>, 
##    <A nontrivial idempotent of a left module>, 
##    <A nontrivial idempotent of a left module>, 
##    <A nontrivial idempotent of a left module>, 
##    <A nontrivial idempotent of a left module>, 
##    <A nontrivial idempotent of a left module>, 
##    <A nontrivial idempotent of a left module>, 
##    <A nontrivial idempotent of a left module> ]
##  gap> DSums := List( idems, DirectSumDecomposition );
##  [ <A rank 1 left module presented by 2 relations for 3 generators>, 
##    <A rank 1 left module presented by 2 relations for 3 generators>, 
##    <A rank 1 left module presented by 2 relations for 3 generators>, 
##    <A rank 1 left module presented by 2 relations for 3 generators>, 
##    <A rank 1 left module presented by 2 relations for 3 generators>, 
##    <A rank 1 left module presented by 2 relations for 3 generators>, 
##    <A rank 1 left module presented by 2 relations for 3 generators>, 
##    <A rank 1 left module presented by 2 relations for 3 generators> ]
##  gap> M;
##  <A rank 1 left module presented by 2 relations for 3 generators>
##  gap> Perform( DSums, Display );
##  d*delta^2-d,0,          0,                
##  0,          d*delta^2+d,(-alpha)*d^2*delta
##  
##  Cokernel of the map
##  
##  R^(1x2) --> R^(1x3), ( for R := Q(alpha)[d,delta] )
##  
##  currently represented by the above matrix
##  -d*delta^2-d,(alpha)*d^2*delta,0,         
##  0,           0,                d*delta^2-d
##  
##  Cokernel of the map
##  
##  R^(1x2) --> R^(1x3), ( for R := Q(alpha)[d,delta] )
##  
##  currently represented by the above matrix
##  d,0,          0,                                    
##  0,d*delta^4-d,(-alpha)*d^2*delta^3+(alpha)*d^2*delta
##  
##  Cokernel of the map
##  
##  R^(1x2) --> R^(1x3), ( for R := Q(alpha)[d,delta] )
##  
##  currently represented by the above matrix
##  d*delta^4-d,(-alpha)*d^2*delta^3+(alpha)*d^2*delta,0,
##  0,          0,                                     d 
##  
##  Cokernel of the map
##  
##  R^(1x2) --> R^(1x3), ( for R := Q(alpha)[d,delta] )
##  
##  currently represented by the above matrix
##  d*delta^4-d,(alpha)*d^2*delta^3+(-alpha)*d^2*delta,0,
##  0,          0,                                     d 
##  
##  Cokernel of the map
##  
##  R^(1x2) --> R^(1x3), ( for R := Q(alpha)[d,delta] )
##  
##  currently represented by the above matrix
##  d,0,          0,                                    
##  0,d*delta^4-d,(alpha)*d^2*delta^3+(-alpha)*d^2*delta
##  
##  Cokernel of the map
##  
##  R^(1x2) --> R^(1x3), ( for R := Q(alpha)[d,delta] )
##  
##  currently represented by the above matrix
##  d*delta^2-d,0,          0,                
##  0,          d*delta^2+d,(-alpha)*d^2*delta
##  
##  Cokernel of the map
##  
##  R^(1x2) --> R^(1x3), ( for R := Q(alpha)[d,delta] )
##  
##  currently represented by the above matrix
##  -d*delta^2-d,(alpha)*d^2*delta,0,         
##  0,           0,                d*delta^2-d
##  
##  Cokernel of the map
##  
##  R^(1x2) --> R^(1x3), ( for R := Q(alpha)[d,delta] )
##  
##  currently represented by the above matrix
##  ]]></Example>
##  <#/GAPDoc>
LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( "alpha" ) * "d,delta";

m := HomalgMatrix( "[d,-d*delta^2,alpha*d^2*delta,d*delta^2,-d,alpha*d^2*delta]", 2, 3, R );

LoadPackage( "Modules" );

M := LeftPresentation( m );

LoadPackage( "SystemTheory" );

M := LeftPresentation( m );

LoadPackage( "SystemTheory" );

idems := NonTrivialEndomorphismIdempotents( M, 0 );

#Perform( idems, Display );

DSums := List( idems, DirectSumDecomposition );

Perform( DSums, Display );
