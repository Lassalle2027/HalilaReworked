extends Node2D

const DAMAGE := 1
const LOADER := 15
var can_shoot:= true
var can_reload:= true
var clip := 15
var bullet = preload("res://scenes/player/bullet.tscn")

func fire(input: Vector2) -> void:
	if !input :
		input = Vector2.RIGHT
	if 0 == clip and can_reload:
		reload()
	if can_shoot:
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = global_position
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.direction = input
		bullet_instance.damage = DAMAGE
		get_tree().get_root().add_child(bullet_instance)
		clip = clip - 1
		$fire_rate.start()
		can_shoot = false

func reload() -> void:
	can_shoot = false
	can_reload = false
	$reload_timer.start()

func _on_fire_rate_timeout() -> void:
	if $reload_timer.is_stopped():
		can_shoot = true


func _on_reload_timer_timeout() -> void:
	can_shoot = true
	can_reload = true
	clip = LOADER
