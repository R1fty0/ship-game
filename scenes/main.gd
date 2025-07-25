extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	print("FPS: " + str(Engine.get_frames_per_second()))
