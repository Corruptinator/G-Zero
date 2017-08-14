extends Spatial

export var follow_speed = 2.0
export var turn_speed = 0.5
export var look_at_parent = true

var offset
var target
var up_dir

func _ready():
	target = get_parent()
	up_dir = target.get_global_transform().basis.y
	offset = get_transform().origin
	set_as_toplevel(true)
	set_process(true)
	
func _process(delta):
	
	# Calculate position to move into
	var new_pos = target.get_global_transform().origin
	new_pos += target.get_global_transform().xform(offset) - new_pos
	
	# Move to the position
	var cur_pos = get_global_transform().origin
	cur_pos -= (cur_pos-new_pos) * follow_speed * delta # <- smooth moving
	set_translation(cur_pos)
	
	# Rotation
	if(look_at_parent):
		# This is suitable for the camera
		up_dir -= (up_dir-target.get_global_transform().basis.y) * turn_speed * delta
		set_global_transform(get_global_transform().looking_at(target.get_global_transform().origin, up_dir))
	else:
		# This is suitable for the car
		var angle = Quat(get_global_transform().basis)
		var target_angle = Quat(target.get_global_transform().basis)
		angle = angle.slerp(target_angle, clamp(turn_speed * delta, 0.0, 1.0))
		set_global_transform(Transform(angle,cur_pos))
		
