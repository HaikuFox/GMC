extends Control


func _ready() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property($".", "modulate", Color(1, 1, 1, 1), 1)
	get_tree().create_timer(1)
	tween.tween_property($".", "modulate", Color(1, 1, 1, 0), 1)
	await tween.finished
	self.queue_free()
