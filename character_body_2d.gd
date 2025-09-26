extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 200
const JUMP_POWER = -350.0
var gravity = 900

var weapon_equip: bool = false
var is_attacking: bool = false


func _ready():
	# Connecter le signal animation_finished
	animated_sprite.animation_finished.connect(_on_animation_finished)


func _physics_process(delta):
	# appliquer gravité
	if not is_on_floor():
		velocity.y += gravity * delta

	# saut (désactivé pendant attaque)
	if Input.is_action_just_pressed("jump") and is_on_floor() and !is_attacking:
		velocity.y = JUMP_POWER

	var direction = Input.get_axis("left", "right")

	# si attaque → bloquer déplacement
	if is_attacking:
		velocity.x = 0
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# gérer animations
	handle_input(direction)


func handle_input(dir):
	# Attaque
	if Input.is_action_just_pressed("attack") and !is_attacking:
		is_attacking = true
		if weapon_equip:
			animated_sprite.play("weapon_attack")
		else:
			animated_sprite.play("attack")
		toggle_flip_sprite(dir)
		return

	# Sinon → animations normales
	if !is_attacking:
		handle_movement_animation(dir)


func handle_movement_animation(dir):
	if !weapon_equip:
		if is_on_floor():
			if velocity.x == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
				toggle_flip_sprite(dir)
		else:
			if velocity.y < 0:
				animated_sprite.play("jump")  # monte
			else:
				animated_sprite.play("fall")  # descend
	else:
		if is_on_floor():
			if velocity.x == 0:
				animated_sprite.play("weapon_idle")
			else:
				animated_sprite.play("weapon_run")
				toggle_flip_sprite(dir)
		else:
			if velocity.y < 0:
				animated_sprite.play("weapon_jump")
			else:
				animated_sprite.play("weapon_fall")


func toggle_flip_sprite(dir):
	if dir == -1:
		animated_sprite.flip_h = false
	elif dir == 1:
		animated_sprite.flip_h = true


func _on_animation_finished():
	# Fin d'attaque → retour normal
	if animated_sprite.animation in ["attack", "weapon_attack"]:
		is_attacking = false
