##  <#GAPDoc Label="TankModel">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "d,delta";;
##  gap> m := HomalgMatrix( "[delta^2,1,-2*d*delta,1,delta^2,-2*d*delta]", 2, 3, R );
##  <A 2 x 3 matrix over an external ring>
##  gap> M := LeftPresentation( m );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> idem := NonTrivialEndomorphismIdempotent( M, 0 );
##  <A non-zero idempotent of a left module>
##  gap> DS := DirectSumDecomposition( idem );
##  <A rank 1 left module presented by 2 relations for 3 generators>
##  gap> M;
##  <A rank 1 left module presented by 1 relation for 2 generators>
##  gap> Display( DS );
##  delta^2-1,0,         0,       
##  0,        -delta^2-1,2*d*delta
##  
##  Cokernel of the map
##  
##  R^(1x2) --> R^(1x3), ( for R := Q[d,delta] )
##  
##  currently represented by the above matrix
##  gap> DSiso := DirectSumDecompositionIsomorphism( idem );
##  <A non-zero isomorphism of left modules>
##  gap> Display( last );
##  -1,1,0,
##  0, 0,1 
##  
##  the map is currently represented by the above 2 x 3 matrix
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "d,delta";

m := HomalgMatrix( "[delta^2,1,-2*d*delta,1,delta^2,-2*d*delta]", 2, 3, R );

LoadPackage( "Modules" );

M := LeftPresentation( m );

LoadPackage( "SystemTheory" );

idem := NonTrivialEndomorphismIdempotent( M, 0 );

DS := DirectSumDecomposition( idem );

