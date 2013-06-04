component
	output = false
	hint = "I wrap around a query and provide high-level methods into that query."
	{


	// Initializes the query helper with the given query. If no query is provided, the helper 
	// is initialized with an empty query.
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


	// I sort the query on the given column name. THIS Is returned as a short-cut.
	public any function sort(
		required string columnName,
		string direction = "asc"
		) {

		var sortedQuery = new Query(
			sql = "SELECT * FROM target ORDER BY #columnName# #direction#",
			dbtype = "query",
			target = target
		);

		target = sortedQuery.execute().getResult();

		return( this );

	}


	// I return the query as an array of structs.
	public array function toArray(
		numeric startIndex = 1,
		numeric endIndex = target.recordCount
		) {

		var rows = [];

		for ( var i = startIndex ; i <= endIndex ; i++ ) {

			arrayAppend( rows, toStruct( i ) );

		}

		return( rows );

	}


	// I return the given row as a struct, in which each column is a key. If no row is provided,
	// it will default to the first row.
	public struct function toStruct( numeric index = 1 ) {

		var row = {};

		for ( var columnName in listToArray( target.columnList ) ) {

			row[ columnName ] = target[ columnName ][ index ];

		}

		return( row );

	}


	// ---
	// PRIVATE METHODS.
	// ---


}