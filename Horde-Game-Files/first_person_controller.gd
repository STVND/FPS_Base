extends CharacterBody3D


@export var speed = 5
@export var fall_acceleration = 75
@export var jump_impulse = 15
@export var mouse_sensitivity = .01

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _input(event):
	if event is InputEventMouseMotion  and $game_session_menu.visible == false:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -PI/2, PI/2)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		$game_session_menu.visible = true
		

func _physics_process(delta):
	
	# Add the gravity.
	var direction = Vector3.ZERO
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if $game_session_menu.visible == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z

	if direction != Vector3.ZERO:
		direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_impulse

	move_and_slide()
