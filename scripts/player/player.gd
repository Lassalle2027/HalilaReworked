class_name Player extends CharacterBody2D

const MAX_HEALTH := 5
const SPEED := 250
const DASH_SPEED := 1000
var input: Vector2
var last_input : Vector2
# Var dash 
var dashing := false
var can_dash := true
var dash_dir : Vector2
var health : int
# Var shoot
var shooting := false

func _ready():
	health = MAX_HEALTH

func _physics_process(delta: float) -> void:
	#gestion shoot
	if Input.is_action_just_pressed("shoot"):
		shooting = true
	if Input.is_action_just_released("shoot"):
		shooting = false
	if shooting :
		$weapon.fire(last_input if last_input else Vector2.ZERO)
		
	#Gestion mouvement
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		dash_dir = input
		$dash_timer.start()
		$dash_cooldown.start()
	input = Vector2.ZERO
	input = Input.get_vector("left","right","up","down")
	if input:
		last_input = input
		if dashing:
			velocity = dash_dir*DASH_SPEED
		else :
			velocity = input*SPEED
	else:
		velocity = input
	move_and_slide()


func _on_dash_timer_timeout() -> void:
	dashing =false


func _on_dash_cooldown_timeout() -> void:
	can_dash = true

func take_damage(dmg : int) -> void:
	health = health - dmg
	print(health)
	if health < 1 :
		kill()

func kill() -> void:
	get_tree().reload_current_scene()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "degat" in body.name :
		take_damage(1)

func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if "Degat" in area.name :
		take_damage(1)
