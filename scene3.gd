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
		[1,2,2,2,3,3],
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


func initialise_board(n_rows, n_columns, available_tiles):
	var board = []
	for i in range(n_rows):
		board = add_row(board, n_columns, available_tiles)
	return board


func generate_row(n_columns, available_tiles):
	var new_row = []
	for i in range(n_columns):	
		var tile = available_tiles[randi_range(0, len(available_tiles) - 1)]
		new_row.append(tile)
	return new_row


func add_row(board, n_columns, available_tiles):
	board.append(generate_row(n_columns, available_tiles))
	return board


func find_consecutive_in_rows(board: Array) -> Dictionary:
	## Go over the board's rows and check if there are any three or more consecutive tiles
	## Return a dictionary in which:
	## - keys are rows' indices (rows with no consecutive tiles are excluded)
	## - values are arrays containing Vectors with tiles indices 
	
	var to_remove: Dictionary = {}
	
	for i in range(len(board)):
		var common: int = 0
		var row: Array = board[i]
		
		for j in range(len(row) - 1):
			if row[j] == row[j+1]:
				common = 2 if common == 0 else common + 1
				if j + 2 == len(row) and common >= 3:
					update_array_in_dict_val(i, Vector2i(j + 2 - common, j + 1), to_remove)
			else:
				if common >= 3:
					update_array_in_dict_val(i, Vector2i(j - common + 1, j), to_remove)
				common = 0
	return to_remove


func find_consecutive_in_columns(board: Array) -> Dictionary:
	var to_remove: Dictionary = {}
	
	for i in range(len(board[0])):
		var common: int = 0
		
		for j in range(len(board) - 1):
			if board[j][i] == board[j+1][i]:
				common = 2 if common == 0 else common + 1
				if j + 2 == len(board) and common >= 3:
					update_array_in_dict_val(i, Vector2i(j + 2 - common, j + 1), to_remove)
			else:
				if common >= 3:
					update_array_in_dict_val(i, Vector2i(j - common + 1, j), to_remove)
				common = 0
	return to_remove


func update_array_in_dict_val(k: int, v: Vector2i, d: Dictionary) -> Dictionary:
	## Update the dictionary with a new key-value pair
	## The dictionary's values are arrays containing Vectors
	
	if k in d:
		d[k].append(v)
	else:
		d[k] = [v]
	return d

