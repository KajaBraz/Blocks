extends CSGBox3D

var time = 0.0
var my_rotate = false


# Called when the node enters the scene tree for the first time.
func _ready():
	print("ooo")
	print(1.0/60)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if my_rotate == true:
		rotate(Vector3(0,1,0),0.02)
	
#	time += delta
#	if time > 1.0:
#		time -= 1.0
#		print(delta)
#		print(position)
	
#	position[0] += 0.001
#	position[1] += 0.001
#	position[2] += 0.001
	pass
	
	
func _input(event):
	if event is InputEventMouseButton:
		print(event.position)
#	print(event.is_action_pressed("ui_left"))
#	print(event.as_text())
	if event.is_action_pressed("ui_left"):
		position[0] -= 0.1
	elif event.is_action_pressed("ui_right"):
		position[0] += 0.1
	if event.is_action_pressed("ui_up"):
		my_rotate = true
	if event.is_action_released("ui_up"):
		my_rotate = false

	
