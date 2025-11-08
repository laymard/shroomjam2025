extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

@export_category("Camera")
@export var camera_sensitivity = 0.05

var target_velocity = Vector3.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	var deltaTime = get_process_delta_time()
	if event is InputEventMouseMotion:
		$CameraPivot_rotateY.rotate_y(-event.relative.x * camera_sensitivity * deltaTime)
		%CameraPivot_rotateX.rotate_x(event.relative.y * camera_sensitivity * deltaTime)
		var angle:float = %CameraPivot_rotateX.basis.get_euler().x
		angle = clamp(angle, deg_to_rad(-90), deg_to_rad(90))
		%CameraPivot_rotateX.rotation.x = angle
		print("Camera rotation",%CameraPivot_rotateX.basis.get_euler())
		#%CameraPivot_rotateX.transform.global_rotation.x = clampf($CameraPivot_rotateX.transform.global_rotation.x, -180,180)
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	var cameraBasis: Basis = %Camera3D.get_global_transform_interpolated().basis
	var cameraEuler:Vector3 = cameraBasis.get_euler()
	direction = direction.rotated(Vector3.UP,cameraEuler.y)
	direction.y = 0
	direction = direction.normalized()
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node.
		$Pivot.basis = Basis.looking_at(-direction)
	
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (75*delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()

		
	
