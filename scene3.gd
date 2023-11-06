extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
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
