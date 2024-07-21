class_name SpeedToFOV
extends Node

@export_range(0.001, 0.1) var up_speed: float = 0.001
@export_range(0.001, 1.0) var down_speed: float = 0.1
@export_range(1.0, 179.0) var max_fov: float = 80.0

var _owner: CharacterBody3D
var _camera: Camera3D
var default_fov: float


func _ready() -> void:
	setup_variables()


func _process(_delta: float) -> void:
	if _owner != null and _camera != null:
		adjust_fov()


func setup_variables():
	_owner = owner
	_camera = _owner.find_child("Camera")
	default_fov = _camera.fov
	

func adjust_fov() -> void:
	var vel: float = _owner.get_real_velocity().length()
	if vel != 0.0:
		_camera.fov = lerp(_camera.fov, max_fov, up_speed * vel)
		print(_camera.fov)
	else:
		_camera.fov = lerp(_camera.fov, default_fov, down_speed)
