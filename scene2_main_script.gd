extends Node3D

# todo move to a common file with constants defintion
var STATE_LEN_X: int = 6
var STATE_LEN_Y: int = 12
var STATE_ROTATION_SPEED = 10.0

var tiles = []
var rotation_containers = []

var do_rotation = 0

var colors = [
	Color(0.75, 0, 0, 1),
	Color(0, 0.75, 0, 1),
	Color(0, 0, 0.75, 1),
	Color(0.75, 0.75, 0, 1),
	Color(0.75, 0, 0.75, 1),
	Color(0, 0.75, 0.75, 1)
	]

func isBox(x):
	return x is CSGBox3D and x.name.contains("CSGBox3D")

# Called when the node enters the scene tree for the first time.
func _ready():
	print($CSGBox3D5.global_position)
	print($CSGBox3D5.position)
	tiles = get_children().filter(isBox)
	for t in tiles:
		t.material = StandardMaterial3D.new()
		t.material.albedo_color = colors.pick_random()
		remove_child(t)
	tiles = create_boxes()
	rotation_containers = create_rotation_containers()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for axis in range(2):
		for row in rotation_containers[axis]:
			for container_tuple in row:
				var container: Node3D = container_tuple[0]
				var is_rotating = container_tuple[1]
				if is_rotating != 0:
					container.rotation[(axis + 1) % 2] += is_rotating * STATE_ROTATION_SPEED * delta
					if abs(container.rotation[(axis + 1) % 2]) >= PI:
						container_tuple[1] = 0
						container.rotation = Vector3()
						var fst = container.get_child(0)
						var snd = container.get_child(1)
						change_parent(container, self, fst)
						change_parent(container, self, snd)
						var tmp_material = fst.material
						fst.material = snd.material
						snd.material = tmp_material

func change_parent(old_parent, new_parent, element):
	var old_transform = element.global_transform
	old_parent.remove_child(element)
	new_parent.add_child(element)
	element.global_transform = old_transform

func swap(first, second):
	print("swapping: " + str(first) + " " + str(second))
	var diff = second - first
	print(diff)
	var fy = first[0]
	var fx = first[1]
	var sy = second[0]
	var sx = second[1]
	var cont
	# swapping down <-> up
	if diff == Vector2i(1, 0):
		cont = rotation_containers[1][min(fy, sy)][fx]
		cont[1] = -1
	# swapping left <-> right
	elif diff == Vector2i(0, 1):
		cont = rotation_containers[0][fy][min(fx, sx)]
		cont[1] = 1
	# swapping up <-> down
	elif diff == Vector2i(-1, 0):
		cont = rotation_containers[1][min(fy, sy)][fx]
		cont[1] = 1
	# swapping right <-> left
	elif diff == Vector2i(0, -1):
		cont = rotation_containers[0][fy][min(fx, sx)]
		cont[1] = -1
	change_parent(self, cont[0], tiles[fy][fx])
	change_parent(self, cont[0], tiles[sy][sx])

func create_boxes():
	var result = []
	for y in range(STATE_LEN_Y):
		var row = []
		for x in range(STATE_LEN_X):
			var new_tile = CSGBox3D.new()
#			var new_tile = CSGSphere3D.new()
			new_tile.position = Vector3(x, y, 0)
			new_tile.material = StandardMaterial3D.new()
			new_tile.material.albedo_color = colors.pick_random()
			row.append(new_tile)
			add_child(new_tile)
		result.append(row)
	return result

func create_rotation_containers():
	var horizontal = []
	for y in range(STATE_LEN_Y):
		var row = []
		for x in range(STATE_LEN_X - 1):
			var container = Node3D.new()
			container.position = Vector3(x + 0.5, y, 0)
			row.append([container, 0])
			add_child(container)
		horizontal.append(row)
	var vertical = []
	for y in range(STATE_LEN_Y - 1):
		var row = []
		for x in range(STATE_LEN_X):
			var container = Node3D.new()
			container.position = Vector3(x, y + 0.5, 0)
			row.append([container, 0])
			add_child(container)
		vertical.append(row)
	return [horizontal, vertical]
