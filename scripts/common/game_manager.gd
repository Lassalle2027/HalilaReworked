class_name GameManager extends Node

@export var world_2d : Node2D
@export var hud : Control

var _current_2d_scene : Node2D
var _current_hud_scene : Control

func _ready() -> void:
	Global.game_manager = self

func change_2d_scene(new_scene_path: String, delete: bool = true, keep_running: bool = false) -> void:
	if _current_2d_scene == null:
		printerr("No current 2d scene loaded")
		return

	if delete:
		_current_2d_scene.queue_free()
	elif keep_running:
		_current_2d_scene.visible = false
	else:
		world_2d.remove_child(_current_2d_scene)

	var new = load(new_scene_path).instantiate()
	world_2d.add_child(new)
	_current_2d_scene = new


func change_hud_scene(new_scene_path : String, delete:bool = true, keep_running:bool = false) -> void:
	if _current_hud_scene == null:
		printerr("No current hud scene loaded")
		return

	if delete:
		_current_hud_scene.queue_free()
	elif keep_running:
		_current_hud_scene.visible = false
	else:
		hud.remove_child(_current_hud_scene)

	var new = load(new_scene_path).instantiate()
	hud.add_child(new)
	_current_hud_scene = new
