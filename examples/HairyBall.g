##  <#GAPDoc Label="HairyBall">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z" / "x^2+y^2+z^2-1";;
##  gap> m := HomalgMatrix( "[ x, y, z ]", 1, 3, R );
##  <A 1 x 3 matrix over a residue class ring>
##  gap> M := LeftPresentation( m );
##  <A non-torsion left module presented by 1 relation for 3 generators>
##  gap> IsStablyFree( M );
##  true
##  gap> M;
##  <A stably free rank 2 left module presented by 2 relations for 3 generators>
##  gap> LargestMinimalNumberOfLocalGenerators( M );
##  2
##  gap> idem := NonTrivialGeneralEndomorphismIdempotent( M, 0 );
##  <A non-zero idempotent of a left module>
##  gap> Display( idem );
##  1/2,     -z*b_7_0,y*b_7_0, 
##  z*b_7_0, 1/2,     -x*b_7_0,
##  -y*b_7_0,x*b_7_0, 1/2      
##  
##  modulo [ b_6_0, b_5_0+b_7_0, b_4_0, b_3_0, b_2_0+b_7_0, 2*b_1_0-1, 4*b_7_0^2+1\
##  , x^2+y^2+z^2-1 ]
##  
##  the map is currently represented by the above 3 x 3 matrix
##  gap> M_ := Source( idem );
##  <A non-torsion left module presented by 2 relations for 3 generators>
##  gap> IsStablyFree( M_ );
##  true
##  gap> M_;
##  <A stably free rank 2 left module presented by 2 relations for 3 generators>
##  gap> DS := DirectSumDecomposition( idem );
##  <A stably free rank 2 left module presented by 8 relations for 4 generators>
##  gap> iso := DirectSumDecompositionIsomorphism( idem );
##  <A non-zero isomorphism of left modules>
##  gap> Display( last );
##  2*z*b_7_0,-2*y*b_7_0,-2*z*b_7_0,2*y*b_7_0,
##  1,        0,         1,         0,        
##  0,        1,         0,         1         
##  
##  modulo [ b_6_0, b_5_0+b_7_0, b_4_0, b_3_0, b_2_0+b_7_0, 2*b_1_0-1, 4*b_7_0^2+1\
##  , x^2+y^2+z^2-1 ]
##  
##  the map is currently represented by the above 3 x 4 matrix
##  gap> F1 := Range( EpiOnLeftFactor( DS ) );
##  <A non-zero projective left module presented by 4 relations for 2 generators>
##  gap> F2 := Range( EpiOnRightFactor( DS ) );
##  <A non-zero projective left module presented by 4 relations for 2 generators>
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z" / "x^2+y^2+z^2-1";

m := HomalgMatrix( "[ x, y, z ]", 1, 3, R );

LoadPackage( "Modules" );

M := LeftPresentation( m );

Assert( 0, IsStablyFree( M ) );

Assert( 0, Rank( M ) = 2 );

Assert( 0, LargestMinimalNumberOfLocalGenerators( M ) = 2 );

LoadPackage( "SystemTheory" );

idem := NonTrivialGeneralEndomorphismIdempotent( M, 0 );

M_ := Source( idem );

IsStablyFree( M_ );

DS := DirectSumDecomposition( idem );

iso := DirectSumDecompositionIsomorphism( idem );

F1 := Range( EpiOnLeftFactor( DS ) );
F2 := Range( EpiOnRightFactor( DS ) );
