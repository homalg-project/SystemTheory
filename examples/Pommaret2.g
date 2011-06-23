##  <#GAPDoc Label="Pommaret2">
##  <Subsection Label="Pommaret2">
##  <Heading>Pommaret2</Heading>
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "d1,d2,d3";;
##  gap> m := HomalgMatrix( "[ \
##  > 0,-2*d1,d3-2*d2-d1,-1,\
##  > 0,d3-2*d1,2*d2-3*d1,1,\
##  > d3,-6*d1,-2*d2-5*d1,-1,\
##  > 0,d2-d1,d2-d1,0,\
##  > d2,-d1,-d2-d1,0,\
##  > d1,-d1,-2*d1,0 \
##  > ]", 6, 4, R );
##  <A 6 x 4 matrix over an external ring>
##  gap> M := LeftPresentation( m );
##  <A left module presented by 6 relations for 4 generators>
##  gap> idems0 := NonTrivialEndomorphismIdempotents( M, 0 );
##  [ <A nontrivial idempotent of a left module>,
##    <A nontrivial idempotent of a left module>,
##    <A nontrivial idempotent of a left module>,
##    <A nontrivial idempotent of a left module>,
##    <A nontrivial idempotent of a left module> ]
##  gap> DS := List( idems0, DirectSumDecomposition );
##  [ <A non-zero left module presented by 5 relations for 3 generators>,
##    <A non-zero left module presented by 5 relations for 3 generators>,
##    <A non-zero left module presented by 5 relations for 3 generators>,
##    <A non-zero left module presented by 5 relations for 3 generators>,
##    <A non-zero left module presented by 5 relations for 3 generators> ]
##  gap> Display(DS[1]);
##  d3,d3,0,      
##  d2,d2,0,      
##  d1,d1,0,      
##  0, 0, 4*d2-d3,
##  0, 0, 4*d1-d3 
##  
##  Cokernel of the map
##  
##  R^(1x5) --> R^(1x3), ( for R := Q[d1,d2,d3] )
##  
##  currently represented by the above matrix
##  gap> Display(DS[2]);
##  d3,     4*d3, 0,
##  4*d2-d3,0,    0,
##  d3,     16*d2,0,
##  4*d1-d3,0,    0,
##  d3,     16*d1,0 
##  
##  Cokernel of the map
##  
##  R^(1x5) --> R^(1x3), ( for R := Q[d1,d2,d3] )
##  
##  currently represented by the above matrix
##  gap> Display(DS[5]);
##  4*d2-d3,4*d2-d3,0, 
##  4*d1-d3,4*d1-d3,0, 
##  0,      0,      d3,
##  0,      0,      d2,
##  0,      0,      d1 
##  
##  Cokernel of the map
##  
##  R^(1x5) --> R^(1x3), ( for R := Q[d1,d2,d3] )
##  
##  currently represented by the above matrix
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "d1,d2,d3";

m := HomalgMatrix( "[ \
0,-2*d1,d3-2*d2-d1,-1,\
0,d3-2*d1,2*d2-3*d1,1,\
d3,-6*d1,-2*d2-5*d1,-1,\
0,d2-d1,d2-d1,0,\
d2,-d1,-d2-d1,0,\
d1,-d1,-2*d1,0 \
]", 6, 4, R );

LoadPackage( "Modules" );

M := LeftPresentation( m );

LoadPackage( "SystemTheory" );

idems0 := NonTrivialEndomorphismIdempotents( M, 0 );

DS := List( idems0, DirectSumDecomposition );
