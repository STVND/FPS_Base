extends Node3D
class_name Bullet

@export var damage: int = 10
@export var lifetime: int = 10
@export var sphere_diameter: float = 1


@onready var bullet_body = $MeshInstance3D/Area3D/CollisionShape3D
@onready var direction: Vector3 = Vector3.ZERO
@onready var current_life : int = 0
#@onready var speed: float = 20	

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var hit_object
@onready var crosshair_target = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	
	if ray.is_colliding():
		mesh.visible = false
		if ray.get_collider().is_in_group("destructible"):
			var incident_vector:Vector3 = global_rotation.normalized()
			var collision_normal:Vector3 = ray.get_collision_normal()
			var reflect_vector:Vector3 = -2 * (incident_vector.dot(collision_normal)) * collision_normal + incident_vector
			
			reflect_vector.x = (reflect_vector.x + collision_normal.x)/2
			reflect_vector.y = (reflect_vector.y + collision_normal.y)/2
			reflect_vector.z = (reflect_vector.z + collision_normal.z)/2
			
			ray.get_collider().hit(reflect_vector, 1)
		queue_free()
	
	current_life += 1
	
	if current_life > lifetime:
		queue_free()


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
