extends Node3D

@export var mouse_sensitivity: float = 0.50
## How much the spring arm attached to the camera moves per mouse wheel scroll.
@export var zoom_strength: float = 2.0

@export_category("Camera Bounds")
@export var upper_look_limit: float = 45
@export var lower_look_limit: float = 0
@export var max_arm_length: float = 25
@export var min_arm_length: float = 5

@onready var camera: Camera3D = %Camera3D
@onready var spring_arm: SpringArm3D = %SpringArm3D

## The length the camera's spring arm should be at, in effect controls zoom. 
var target_spring_arm_length: float = 10:
	set(value):
		target_spring_arm_length = clamp(value, min_arm_length, max_arm_length)
		
func _ready() -> void:
	# Lock mouse cursor. 
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Update camera zoom. 
	spring_arm.spring_length = target_spring_arm_length

func _input(event: InputEvent) -> void:
	# Move camera up and down. 
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		spring_arm.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(upper_look_limit *-1), deg_to_rad(lower_look_limit),)
	# Zoom camera in. 
	if event.is_action_pressed("zoom_in"):
		target_spring_arm_length -= zoom_strength
	# Zoom camera out. 
	elif event.is_action_pressed("zoom_out"):
		target_spring_arm_length += zoom_strength
