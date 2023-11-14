extends CanvasLayer

# todo move to a common file with constants defintion
var STATE_LEN_X: int = 6
var STATE_LEN_Y: int = 12

var pressed: bool = false
var click_pos: Vector2 = Vector2()
var left: float
var right: float
var top: float
var bottom: float
var block_size: float

func _ready():
	print(transform.origin[0])
	print($Top.position)
	print($Bottom.position)
	print($Left.position)
	print($Right.position)
	left = transform.origin[0]
	top = transform.origin[1]
	right = left + scale[0] * $Right.position[0]
	bottom = top + scale[1] * $Bottom.position[1]
	block_size = (right - left) / STATE_LEN_X

#InputEventMouseButton: button_index=1, mods=none, pressed=true, canceled=false, position=((139, 256)), button_mask=1, double_click=false
#InputEventMouseButton: button_index=1, mods=none, pressed=false, canceled=false, position=((139, 256)), button_mask=0, double_click=false
func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		print("JEST CLICK ", event.position)
		var xy = to_state_coord(event.position[0], event.position[1])
		print("klik: ", xy)
		if event.pressed and xy[0] >= 0 and xy[0] < STATE_LEN_X and xy[1] >= 0 and xy[1] < STATE_LEN_Y:
			click_pos = event.position
		elif !event.pressed and click_pos != Vector2.ZERO:
			var angle = (click_pos - event.position).angle()
			if angle < 0:
				angle = 2 * PI + angle
			print("kat od ", click_pos, " do ", event.position)
			print(rad_to_deg(angle))
			
			angle = rad_to_deg(angle)
			var old_xy = to_state_coord(floor(click_pos[0]), floor(click_pos[1]))
			old_xy = Vector2i(old_xy[0], STATE_LEN_Y - 1 - old_xy[1])
			var new_xy = old_xy
			if angle <= 45 or angle >= 315:
				new_xy[0] -= 1
			elif angle >= 45 and angle <= 135:
				new_xy[1] += 1
			elif angle >= 135 and angle <= 225:
				new_xy[0] += 1
			else:
				new_xy[1] -= 1
			
			if new_xy[0] >= 0 and new_xy[0] < STATE_LEN_X and new_xy[1] >= 0 and new_xy[1] < STATE_LEN_Y:
				old_xy = Vector2i(old_xy[1], old_xy[0])
				new_xy = Vector2i(new_xy[1], new_xy[0])
				get_parent().swap(old_xy, new_xy)
			
			click_pos = Vector2.ZERO

func to_state_coord(screen_x: int, screen_y: int) -> Vector2i:
	return Vector2i(
		-1 if screen_x - left < 0 else (screen_x - left) / floor(block_size),
		-1 if screen_y - top < 0 else (screen_y - top) / floor(block_size)
	)
