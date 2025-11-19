extends Area2D

const SPEED = 2000
var direction = Vector2.RIGHT
var damage = 1

func _physics_process(delta):
	var velocity = direction * SPEED * delta
	global_position = global_position + velocity
