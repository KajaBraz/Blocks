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


func validate_row(board):
	
	for row in board:
		print(row)
		for i in range(0, len(row) - 1):
			print(i, ':', row[i], row[i+1])
	return
