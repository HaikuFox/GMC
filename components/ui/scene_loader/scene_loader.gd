extends Node

#region Variables
var is_loading: bool = false
var progress: Array
var _thread: Thread

var scene_path: String

var loaded_scene: Node
var root_scene: Node
var destination: Node
#endregion

func _enter_tree() -> void:
	root_scene = get_node("../RootScene")
	_thread = Thread.new()
	var err := _thread.start(
		change_to_scene.bind(
			"res://components/ui/splash_screen/splash_screen.tscn", null
		),
		Thread.PRIORITY_LOW
	)
	assert(err == OK)


func change_to_scene(_scene_path: String, current_scene: Node,
	_destination: Node = root_scene) -> void:

	call_deferred("_load", _scene_path, _destination)
	call_deferred("close_scene", current_scene)


func _load(_scene_path: String, _destination: Node) -> void:
	if (
		_scene_path == null
		or _scene_path.is_empty()
		or _destination == null
	):
		push_error("Destination is null")
	
	is_loading = true
	ResourceLoader.load_threaded_request(_scene_path)
	
	scene_path = _scene_path
	destination = _destination


func close_scene(scene: Node) -> void:
	if scene:
		scene.queue_free()


func _process(_delta: float) -> void:
	if not is_loading:
		return
	
	var status := ResourceLoader.load_threaded_get_status(scene_path, progress)
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		pass
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene := ResourceLoader.load_threaded_get(scene_path)
		loaded_scene = scene.instantiate()
		destination.add_child(loaded_scene)
		is_loading = false
	else:
		push_error("Loading is failed")
		is_loading = false
