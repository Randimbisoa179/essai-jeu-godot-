extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 200
const JUMP_POWER = -350.0
var gravity = 900

var weapon_equip: bool = false
var is_attacking: bool = false
var is_hurt: bool = false
var is_finished: bool = false  # fin du parcours

# seuil de vitesse pour activer "hurt"
const HURT_SPEED_THRESHOLD = 150
const KNOCKBACK_FORCE = 200  


func _ready():
	animated_sprite.animation_finished.connect(_on_animation_finished)


func _physics_process(delta):
	if is_finished:
		velocity = Vector2.ZERO
		return  # joueur immobile à la fin

	# appliquer gravité
	if not is_on_floor():
		velocity.y += gravity * delta

	# saut
	if Input.is_action_just_pressed("jump") and is_on_floor() and !is_attacking and !is_hurt:
		velocity.y = JUMP_POWER

	var direction = Input.get_axis("left", "right")

	# bloquer déplacement si attaque ou hurt
	if is_attacking or is_hurt:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# déplacement
	move_and_slide()

	# détection mur
	if is_on_wall() and abs(velocity.x) > HURT_SPEED_THRESHOLD and !is_attacking and !is_hurt:
		_trigger_hurt()
		return

	# animations normales
	handle_input(direction)


func handle_input(dir):
	if is_finished:  # plus de contrôle
		return

	if Input.is_action_just_pressed("attack") and !is_attacking and !is_hurt:
		is_attacking = true
		if weapon_equip:
			animated_sprite.play("weapon_attack")
		else:
			animated_sprite.play("attack")
		toggle_flip_sprite(dir)
		return

	if !is_attacking and !is_hurt:
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
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
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
	if animated_sprite.animation in ["attack", "weapon_attack"]:
		is_attacking = false
	if animated_sprite.animation == "hurt":
		is_hurt = false
	if animated_sprite.animation == "finish":
		is_finished = true


# --- Hurt + knockback ---
func _trigger_hurt():
	is_hurt = true
	animated_sprite.play("hurt")
	if velocity.x > 0:
		velocity.x = -KNOCKBACK_FORCE
	elif velocity.x < 0:
		velocity.x = KNOCKBACK_FORCE


# --- Signal FinishArea ---
func _on_FinishArea_body_entered(body):
	if body == self and !is_finished:
		is_finished = true
		animated_sprite.play("finish")
		velocity = Vector2.ZERO


func _on_finished_area_body_entered(body: Node2D) -> void:
	# Replace with function body.
	if body == self and !is_finished:
		is_finished = true
		animated_sprite.play("finish")
		velocity = Vector2.ZERO
		print("Le joueur a atteint la fin !")	
		
