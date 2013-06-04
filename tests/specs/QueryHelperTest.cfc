component
	extends = "TestCase"
	output = false
	hint = "I test the QueryHelper component."
	{


	// --- 
	// LIFECYCLE METHODS.
	// ---


	// I get called before each test method.
	public void function setup() {

		queryHelper = new lib.QueryHelper( buildFriendsQuery() );

	}


	// I get called after each test method.
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

		// Just make sure we get the expected failure.
		assertFalse(
			arrayEquals( ids, [ 5, 4, 3, 2, 1 ] )	
		);

	}


	public void function testThatTheQueryCanBeConvertedToArray() {

		var expectedArray = [
			{ id = 1, name = "Sarah" },
			{ id = 2, name = "Joanna" },
			{ id = 3, name = "Kim" },
			{ id = 4, name = "Heather" },
			{ id = 5, name = "Tricia" }
		];

		assert(
			arrayEquals( expectedArray, queryHelper.toArray() )
		);

	}


	public void function testThatSortWorksAsc() {

		var friends = queryHelper.sort( "name" )
			.getQuery()
		;

		assert( friends.name[ 1 ] == "Heather" );
		assert( friends.name[ 2 ] == "Joanna" );
		assert( friends.name[ 3 ] == "Kim" );
		assert( friends.name[ 4 ] == "Sarah" );
		assert( friends.name[ 5 ] == "Tricia" );

	}


	public void function testThatSortWorksDesc() {

		var friends = queryHelper.sort( "name", "desc" )
			.getQuery()
		;

		assert( friends.name[ 1 ] == "Tricia" );
		assert( friends.name[ 2 ] == "Sarah" );
		assert( friends.name[ 3 ] == "Kim" );
		assert( friends.name[ 4 ] == "Joanna" );
		assert( friends.name[ 5 ] == "Heather" );

	}


	public void function testGettingMaxValueOfColumn() {

		assert( queryHelper.max( "id" ) == 5 );

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