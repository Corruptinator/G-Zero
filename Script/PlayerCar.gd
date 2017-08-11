extends RigidBody




# Initial values
var gravity_dir = Vector3(0,-1,0)
var turn_force = 0.0

func _ready():
	set_fixed_process(true)

func upd_turning():
	
	# Steer left/right
	if (Input.is_action_pressed("ui_left")):
		turn_force += 0.01
	if (Input.is_action_pressed("ui_right")):
		turn_force -= 0.01
	
	# Rotate around y-axis
	rotate(get_global_transform().basis.y,turn_force)
	
	# Dampen turning
	turn_force *= 0.8
	
func upd_driving():
	
	var forward_vector = get_global_transform().basis.z
	var l_vel = get_linear_velocity()
	
	# Drive forward
	if (Input.is_action_pressed("ui_up")):
		l_vel += forward_vector
		
	# Brake / reverse
	if (Input.is_action_pressed("ui_down")):
		l_vel -= forward_vector
		
	set_linear_velocity(l_vel)
	
func upd_gravity():
	
	# Gravity direction is always down from the car.
	# The car will align itself to the ground on collision automatically,
	# without any extra work.
	gravity_dir = -get_global_transform().basis.y
	
	# Apply gravity
	var l_vel = get_linear_velocity()
	l_vel += gravity_dir / 5
	set_linear_velocity(l_vel)
	
func _fixed_process(delta):
	upd_turning()
	upd_driving()
	upd_gravity()
	