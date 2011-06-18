LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z" / "x^2+y^2+z^2-1";

m := HomalgMatrix( "[ x, y, z ]", 1, 3, R );

LoadPackage( "Modules" );

M := LeftPresentation( m );

Assert( 0, IsStablyFree( M ) );

Assert( 0, Rank( M ) = 2 );

Assert( 0, LargestMinimalNumberOfLocalGenerators( M ) = 2 );

LoadPackage( "SystemTheory" );

I := IdealDefiningNonTrivialEndomorphismIdempotents( M, 0 );

idem := NonTrivialEndomorphismIdempotents( M, 0 )[1];

DS := DirectSumDecomposition( idem );
