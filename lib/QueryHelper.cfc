component
	output = false
	hint = "I wrap around a query and provide high-level methods into that query."
	{


	// Initializes the query helper with the given query. If no query is provided, helper is 
	// initialized with an empty query.
	any function init( query data = queryNew( "" ) ) {

		target = data;

		return( this );

	}


	// ---
	// PUBLIC METHODS.
	// ---


	// I return the given column as an array.
	public array function getColumn( required string name ) {

		var values = [];

		for ( var i = 1 ; i <= target.recordCount ; i++ ) {

			arrayAppend( values, target[ name ][ i ] );

		}

		return( values );

	}


	// I return the underlying query.
	public query function getQuery() {

		return( target );

	}


	// ---
	// PRIVATE METHODS.
	// ---


}