extends Node3D

var tiles = []
var do_rotation = 0

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
	print($CSGBox3D5.global_position)
	print($CSGBox3D5.position)
#	Basis.from_euler()
	tiles = get_children().filter(isBox)
	for t in tiles:
		t.material.albedo_color = colors.pick_random()
	$Container2/CSGBox3D7.material.albedo_color = colors.pick_random()
	$Container2/CSGBox3D8.material.albedo_color = colors.pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	$CSGBox3D5.rotate_object_local(Vector3(1, 0, 0), 1.5 * delta)
#	$CSGBox3D5.position = Vector3(2, 0, 0)
#	$CSGBox3D5.rotate(Vector3(1, 0, 0), 1.5 * delta)
	if do_rotation != 0:
#		$Container2.rotate_y(do_rotation * 10.0 * delta)
		$Container2.rotation[1] += do_rotation * 10.0 * delta
		if abs($Container2.rotation[1]) >= PI:
			do_rotation = 0
			$Container2.rotation[1] = 0
			var temp = $Container2/CSGBox3D7.material
			$Container2/CSGBox3D7.material = $Container2/CSGBox3D8.material
			$Container2/CSGBox3D8.material = temp

func _input(event):
	if event is InputEventKey:
		print(event)
		if event.keycode == KEY_LEFT and event.pressed and !event.echo:
			do_rotation = -1
		elif event.keycode == KEY_RIGHT and event.pressed and !event.echo:
			do_rotation = 1
	if event is InputEventMouseButton:
		print(event)
		if event.button_index == 1 and event.pressed == true:
			var box2: CSGBox3D = $CSGBox3D4
			box2.material.albedo_color = colors.pick_random()
