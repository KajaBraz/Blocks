extends CSGBox3D

var time = 0.0
var my_rotate = false
var moving = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ooo")
	print(1.0/60)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if my_rotate == true:
		rotate(Vector3(0,1,0),0.02)
	position[0] += 0.05 * moving
	
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
	print(event)
	print(event.as_text())
	print("*")
	
#	if event is InputEventMouseButton:
#		print(event.position)

	if event.is_action_pressed("ui_left"):
		moving = -1
	elif event.is_action_pressed("ui_right"):
		moving = 1
	elif event.is_action_released("ui_left") or event.is_action_released("ui_right"):
		moving = 0
	
	if event.is_action_pressed("ui_up"):
		my_rotate = true
	elif event.is_action_released("ui_up"):
		my_rotate = false
		
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().quit()
