extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	print('Create board')
	var new_board = initialise_board(6, 5, [1,2,3,4,5,6])
	print(new_board)
	
	print('\nSwap')
	var t1 = [0,0,0]
	var t2 = [5,5,5]
	print(swap_horizontally(t1, t2))
	print(swap_vertically(t1, t2))
	
	print('\nVerify rows')
	var remove_row_tiles1 = find_consecutive_in_rows(new_board)
	print(remove_row_tiles1)
	var remove_row_tiles2 = find_consecutive_in_rows([[1,2,3,3,3,4],[1,2,2,2,2,3],[3,3,3,3,3,3],[1,2,2,3,3,3],[2,2,2,3,3,3],[2,2,2,1,3,3]])
	print(remove_row_tiles2)
	var remove_row_tiles3 = find_consecutive_in_rows([[1,4,2,6,6],[2,2,3,4,6]])
	print(remove_row_tiles3)
	
	print('\nVerify columns')
	var remove_column_tiles1 = find_consecutive_in_columns(new_board)
	print(remove_column_tiles1)
	var remove_column_tiles2 = find_consecutive_in_columns([
		[1,2,3,3,3,3],
		[1,2,3,2,3,3],
		[3,3,3,3,3,3],
		[1,2,2,3,3,3],
		[2,2,2,3,2,3],
		[2,2,2,1,3,3]])
	print(remove_column_tiles2)
	var remove_column_tiles3 = find_consecutive_in_columns([
		[1,1,1],
		[1,1,1],
		[1,1,1]])
	print(remove_column_tiles3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func swap_tiles(coords_a, coords_b, direction):
	var a = coords_a[direction]
	var b = coords_b[direction]
	coords_a[direction] = b
	coords_b[direction] = a
	return [coords_a, coords_b]


func swap_horizontally(coords_a, coords_b):
	return swap_tiles(coords_a, coords_b, 0)

	
func swap_vertically(coords_a, coords_b):
	return swap_tiles(coords_a, coords_b, 1)


func initialise_board(n_rows: int, n_columns: int, available_tiles: Array):
	## Create a board composed of tiles randomly chosen out of the specified values
	
	var board: Array = []
	
	for i in range(n_rows):
		board = add_row(board, n_columns, available_tiles)
	
	return board


func generate_row(n_columns: int, available_tiles: Array):
	## Generate an array of random tiles
	
	var new_row: Array = []
	var tile: int
	
	for i in range(n_columns):	
		tile = available_tiles[randi_range(0, len(available_tiles) - 1)]
		new_row.append(tile)
	
	return new_row


func add_row(board: Array, n_columns: int, available_tiles: Array):
	## Add a new row to the board
	
	board.append(generate_row(n_columns, available_tiles))
	return board


func find_consecutive_in_rows(board: Array) -> Dictionary:
	## Go over the board's rows and check if there are any three or more consecutive tiles
	## Return a dictionary in which:
	## - keys are rows' indices (rows with no consecutive tiles are excluded)
	## - values are arrays containing Vectors with tiles indices 
	
	var to_remove: Dictionary = {}
	var consecutive_tiles: Array = []
	
	for i in range(len(board)):
		consecutive_tiles = find_consecutive(board[i])
		
		if consecutive_tiles:
			to_remove[i] = consecutive_tiles
	
	return to_remove


func find_consecutive_in_columns(board: Array) -> Dictionary:
	## Go over the board's columns and check if there are any three or more consecutive tiles
	## Return a dictionary in which:
	## - keys are columns' indices (columns with no consecutive tiles are excluded)
	## - values are arrays containing Vectors with rows indices 
	
	var to_remove: Dictionary = {}
	var column: Array = []
	var consecutive_tiles: Array = []
	
	for i in range(len(board[0])):
		column = []
		
		for row in board:
			column.append(row[i])
		
		consecutive_tiles = find_consecutive(column)
		
		if consecutive_tiles:
			to_remove[i] = consecutive_tiles

	return to_remove


func find_consecutive(tiles_array:Array):
	## Check if any three or more consecutive items in an array have the same values
	## Return the start and end indices of such groups
	
	var common: int = 0
	var common_tiles: Array = []
	
	for i in range(len(tiles_array) - 1):
		if tiles_array[i] == tiles_array[i+1]:
			common = 2 if common == 0 else common + 1
			if i + 2 == len(tiles_array) and common >= 3:
				common_tiles.append(Vector2i(i + 2 - common, i + 1))
		else:
			if common >= 3:
				common_tiles.append(Vector2i(i - common + 1, i))
			common = 0
	
	return common_tiles
