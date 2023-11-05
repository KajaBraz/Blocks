extends Node3D

var tiles = []

var colors = [
	Color(1, 0, 0, 1),
	Color(0, 1, 0, 1),
	Color(0, 0, 1, 1),
	Color(1, 1, 0, 1),
	Color(1, 0, 1, 1),
	Color(0, 1, 1, 1)
	]

func isBox(x):
	return x is CSGBox3D and x.name.contains("CSGBox3D")

# Called when the node enters the scene tree for the first time.
func _ready():
	tiles = get_children().filter(isBox)
	for t in tiles:
		t.material.albedo_color = colors.pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		print(event)
		print(event.to_string())
		print("*")
		if event.button_index == 1 and event.pressed == true:
			var box2: CSGBox3D = $CSGBox3D4
			box2.material.albedo_color = colors.pick_random()
