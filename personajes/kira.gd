extends CharacterBody2D

@export var speed = 150
@export var jump = -380
@export var limite_caida = 400

var gravity = 980
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Agregar gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Manejamos el salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump

	# Esto nos devuelve la dirección del jugador ---> -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	#invertir sprite
	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false
		
	#Maneja animaciones
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	else:
		if velocity.y < 0:
			animated_sprite_2d.play("hurt")
		else:
			animated_sprite_2d.play("die")
	#Agregar movimiento

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	if global_position.y > limite_caida:
		game_over()

func game_over() -> void:
	get_tree().change_scene_to_file("res://personajes/game_over.tscn")
