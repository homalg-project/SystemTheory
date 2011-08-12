##  <#GAPDoc Label="Dirac">
##  <Subsection Label="Dirac">
##  <Heading>Dirac</Heading>
##  <Example><![CDATA[
##  gap> C := HomalgFieldOfRationalsInDefaultCAS( "i", "i^2+1" );
##  Q[i]/(i^2+1)
##  gap> R := C * "d1,d2,d3,d4";
##  (Q[i]/(i^2+1))[d1,d2,d3,d4]
##  gap> m := HomalgMatrix( "[ \
##  > d4,0,-i*d3,-(i*d1+d2),\
##  > 0,d4,-i*d1+d2,i*d3,\
##  > i*d3,i*d1+d2,-d4,0,\
##  > i*d1-d2,-i*d3,0,-d4\
##  > ]", 4, 4, R );
##  <A 4 x 4 matrix over an external ring>
##  gap> M := LeftPresentation( m );
##  <A left module presented by 4 relations for 4 generators>
##  gap> idem := NonTrivialEndomorphismIdempotent( M, 0 );
##  <A nontrivial idempotent of a left module>
##  gap> Display( idem );
##  1/2,0,  1/2,0,  
##  0,  1/2,0,  1/2,
##  1/2,0,  1/2,0,  
##  0,  1/2,0,  1/2 
##  
##  the map is currently represented by the above 4 x 4 matrix
##  gap> DS := DirectSumDecomposition( idem );
##  <A non-zero torsion left module presented by 4 relations for 4 generators>
##  gap> M;
##  <A non-zero torsion left module presented by 4 relations for 4 generators>
##  gap> Display( DS );
##  (-i)*d1+d2,(i)*d3-d4, 0,        0,         
##  (-i)*d3-d4,(-i)*d1-d2,0,        0,         
##  0,         0,         d1+(i)*d2,-d3+(i)*d4,
##  0,         0,         d3+(i)*d4,d1+(-i)*d2 
##  
##  Cokernel of the map
##  
##  R^(1x4) --> R^(1x4), ( for R := (Q[i]/(i^2+1))[d1,d2,d3,d4] )
##  
##  currently represented by the above matrix
##  gap> DSiso := DirectSumDecompositionIsomorphism( idem );
##  <A non-zero isomorphism of left modules>
##  gap> Display( last );
##  -1,0, 1,0,
##  0, -1,0,1,
##  1, 0, 1,0,
##  0, 1, 0,1 
##  
##  the map is currently represented by the above 4 x 4 matrix
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

C := HomalgFieldOfRationalsInDefaultCAS( "i", "i^2+1" );

R := C * "d1,d2,d3,d4";

m := HomalgMatrix( "[ \
d4,0,-i*d3,-(i*d1+d2),\
0,d4,-i*d1+d2,i*d3,\
i*d3,i*d1+d2,-d4,0,\
i*d1-d2,-i*d3,0,-d4\
]", 4, 4, R );

LoadPackage( "Modules" );

M := LeftPresentation( m );

LoadPackage( "SystemTheory" );

idem := NonTrivialEndomorphismIdempotent( M, 0 );

DS := DirectSumDecomposition( idem );

DSiso := DirectSumDecompositionIsomorphism( idem );
