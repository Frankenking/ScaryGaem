extends CharacterBody3D

const GRAVITY = 9.81
const SPEED = 5.0
const SPRINT_MULTIPLIER = 1.4

@onready var camera := $"."/CollisionShape3D/MeshInstance3D/pivot/Camera3D
@onready var pivot := $"."/CollisionShape3D/MeshInstance3D/pivot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func get_input():
	pass

func is_sprinting():
	if Input.is_action_pressed("lshift"):
		return true
	else:
		return false
		
func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		
		if event is InputEventMouseMotion:
			pivot.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, -1.5, 1.5)
			
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	

