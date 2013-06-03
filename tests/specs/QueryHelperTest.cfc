component
	extends = "TestCase"
	output = false
	hint = "I test the QueryHelper component."
	{


	// --- 
	// LIFECYCLE METHODS.
	// ---


	public void function setup() {

		queryHelper = new lib.QueryHelper( buildFriendsQuery() );

	}


	public void function teardown() {
		
		// ...

	}


	// ---
	// TEST METHODS.
	// ---


	public void function testThatQueryHelperCanBeInitialized() {

		var queryHelper = new lib.QueryHelper();

	}


	public void function testThatQueryHelperCanBeInitializedWithQuery() {

		// NOTE: Assumes the use of "setup()" to build query.
		assert( isQuery( queryHelper.getQuery() ) );

	}


	public void function testThatQueryInMatchesQueryOut() {

		var friendsIn = buildFriendsQuery();
		var queryHelper = new lib.QueryHelper( friendsIn );

		assert(
			queryEquals( friendsIn, queryHelper.getQuery() )
		);

	}


	public void function testThatGetColumnReturnsValues() {

		var ids = queryHelper.getColumn( "id" );

		assert(
			arrayEquals( ids, [ 1, 2, 3, 4, 5 ] )
		);

	}


	// ---
	// PRIVATE METHODS.
	// ---


	private boolean function arrayEquals(
		required array a,
		required array b
		) {

		return(
			complexObjectEquals( a, b )
		);

	}


	private query function buildFriendsQuery() {

		var friends = queryNew( "" );

		queryAddColumn( 
			friends,
			"id",
			"cf_sql_integer",
			[ 1, 2, 3, 4, 5 ]
		);

		queryAddColumn(
			friends,
			"name",
			"cf_sql_varchar",
			[ "Sarah", "Joanna", "Kim", "Heather", "Tricia" ]
		);

		return( friends );

	}


	private boolean function complexObjectEquals(
		required any a,
		required any b
		) {

		aData = serializeJSON( a );
		bData = serializeJSON( b );

		return( lcase( aData ) == lcase( bData ) );

	}


	private boolean function queryEquals(
		required query a,
		required query b
		) {

		return(
			complexObjectEquals( a, b )
		);

	}


}