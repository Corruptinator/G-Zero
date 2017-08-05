extends RigidBody

# TODO: Fix the gravity, Fix the Rotation, Fix controls.

export var player = false
export var camera = false
var g = 1

func _ready():
	# We set up our physics and the current camera for the scene.
	if camera == true:
		get_node("Position/Rotation/Camera").make_current()
		pass
	elif camera == false:
		get_node("Position/Rotation/Camera").clear_current()
		pass
	else:
		pass
	set_fixed_process(true)
	set_gravity_scale(0)
	pass

func _fixed_process(delta):
	
	#This part is where the raycast detects where the collision point is in order to re-allign the
	#"Position" to aim at the ground to allow the object to fall towards its own gravity straight into
	#the road beheath. Unfortunately the code is broken and I am still figuring out how "Look_At()" works.
	#If you like to improve/help in this code feel free to do so! Contributions are welcome!
	var ray = get_node("Position/RayCast")
	var a = ray.get_collision_point()
	var b = self.get_global_transform().origin
	#a.z = 0
	#b.z = 0
	#a.y = 0
	#b.y = 0
	var calculate = Vector3(a-b).normalized()
	
	#The code snippet below determines if the variable "ray" is detecting the ground, if it is then this
	#is where the look_at() is put to use to rotate/aim the "Position" node towards the ground, depending on
	#what the "RayCast"'s get_collision_point() says. If the ground is not detected in the "ray" then the
	#"Position" node is reset towards the default rotation at Vector3(0,0,0).
	
	if ray.is_colliding() == true:
		get_node("Position").look_at(calculate,Vector3(0,1,0))
		print(calculate)
		#g = -.05
		pass
	else:
		print("off")
		#get_node("Position").look_at(Vector3(0,-1,0),Vector3(0,1,0))
		get_node("Position").rotate_x(get_rotation().x*-1)
		get_node("Position").rotate_y(get_rotation().y*-1)
		get_node("Position").rotate_z(get_rotation().z*-1)
		rotate_x(get_rotation().x*-1)
		rotate_y(get_rotation().y*-1)
		rotate_z(get_rotation().z*-1)
		#g = .05
		pass
	pass

#Where artificial gravity is implemented after using the "Raycast" and utilizing the "Gravity" node that is
#the child of the "Position" node.

#The Gravity Node allows the vehicle itself to fall towards into an another direction rather than the usual
#default "Gravity Scale" Property, which is set to '0'.

func _integrate_forces(state):

	var thruster = self.get_node("Position/Gravity")
	var driver = self.get_node("Position/Rotation/Driver")
	var drive_vector = driver.get_global_transform().basis.x
	var drive_pos = driver.get_global_transform().origin
	var force_vector = thruster.get_global_transform().basis.y
	var force_pos = thruster.get_global_transform().origin

#	if (Input.is_action_pressed("ui_up")):
#		#get_global_transform().basis.z
#		state.add_force(drive_vector*1, Vector3(0,0,0))
#	elif (Input.is_action_pressed("ui_down")):
#		state.add_force(-drive_vector*1, Vector3(0,0,0))
#	else:
#		pass
#
#	if (Input.is_action_pressed("ui_left")):
#		state.set_angular_velocity(Vector3(0,1,0))
#	elif (Input.is_action_pressed("ui_right")):
#		state.set_angular_velocity(Vector3(0,-1,0))
#	else:
#		state.set_angular_velocity(Vector3(0,0,0))

	state.add_force(-force_vector*10*g, Vector3(0,0,0))


	pass