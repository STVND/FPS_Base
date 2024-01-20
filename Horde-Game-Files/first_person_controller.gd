extends CharacterBody3D

@export var speed: float = 10
@export var fall_acceleration: int = 50
@export var jump_impulse: int = 15
@export var mouse_sensitivity: float = .005
@export var sprint_multiplier: float = 1.4
@export var total_speed: float = 0

@onready var cam = $Camera3D



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _input(event):
	if event is InputEventMouseMotion and $game_session_menu.visible == false:
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
	if Input.is_action_just_pressed("left_click"):
		var projectile: Bullet = preload("res://bullet.tscn").instantiate()
		projectile.position = cam.global_position - Vector3(0, .3, 0)
		projectile.transform.basis = cam.global_transform.basis
		get_parent().add_child(projectile)

		pass
		
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
		
	if Input.is_action_pressed("sprint"):
		total_speed = speed * sprint_multiplier
	else:
		total_speed = speed

	velocity.x = direction.x * total_speed
	velocity.z = direction.z * total_speed
	velocity.y -= fall_acceleration * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_impulse

	move_and_slide()
