extends Camera3D

@export_category("Input")
@export_range(0.001, 1, 0.01) var vertical_sensitivity: float = 0.02
@export_range(0.001, 1, 0.01) var horizontal_sensitivity: float = 0.02
@export var is_input_enabled: bool = true
@export var is_sensitivity_synced: bool = true
@export_category("Other")
@export var is_mouse_visible: bool = false

var _owner: Node3D

func _ready() -> void:
	setup_mouse_visibility()
	sync_sensitivity()
	set_owner_var()


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.MOUSE_MODE_CAPTURED:
		rotate_camera(event)


func rotate_camera(mouse_position: InputEventMouseMotion) -> void:
	_owner.rotate_y(-mouse_position.relative.x * horizontal_sensitivity)
	rotate_x(-mouse_position.relative.y * vertical_sensitivity)
	rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

func set_owner_var():
	_owner = owner

func sync_sensitivity():
	if is_sensitivity_synced:
		vertical_sensitivity = horizontal_sensitivity

func setup_mouse_visibility():
	if is_mouse_visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
