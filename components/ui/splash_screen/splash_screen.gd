extends Control

@export var screens: Array = ["res://components/ui/splash_screen/screens/haiku_dev.tscn", "res://components/ui/splash_screen/screens/nicos.tscn"]
var packed_screen
var current_screen: int = 0

func _process(_delta: float) -> void:
	if self.get_child_count() == 0:
		if not current_screen > screens.size() - 1:
			SceneLoader.change_to_scene(screens[current_screen], null, self)
			current_screen += 1
		else:
			SceneLoader.change_to_scene("res://components/ui/main_menu/main_menu.tscn", self)
