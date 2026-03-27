extends CharacterBody2D

@export var speed = 150
@export var jump = -380
@export var limite_caida = 500
@export var bala_scene: PackedScene

var vidas = 3
var gravity = 980
var invulnerable = false
var posicion_inicial: Vector2
var mirando_derecha = true
var punto_disparo_x_original = 0.0
var punto_disparo_y_original = 0.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var punto_disparo: Marker2D = $PuntoDisparo
@onready var heart_1: TextureRect = $"../CanvasLayer2/HBoxContainer/Heart1"
@onready var heart_2: TextureRect = $"../CanvasLayer2/HBoxContainer/Heart2"
@onready var heart_3: TextureRect = $"../CanvasLayer2/HBoxContainer/Heart3"

@onready var pausa = $"../Pausa"

func _process(delta):
	if Input.is_action_just_pressed("pausa"):
		if get_tree().paused:
			pausa.ocultar()
		else:
			pausa.mostrar()

func _ready() -> void:
	posicion_inicial = global_position
	punto_disparo_x_original = abs(punto_disparo.position.x)
	punto_disparo_y_original = punto_disparo.position.y
	actualizar_corazones()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump

	var direction := Input.get_axis("move_left", "move_right")

	if direction < 0:
		animated_sprite_2d.flip_h = true
		mirando_derecha = false
		punto_disparo.position.x = punto_disparo_x_original
		punto_disparo.position.y = punto_disparo_y_original
	elif direction > 0:
		animated_sprite_2d.flip_h = false
		mirando_derecha = true
		punto_disparo.position.y = punto_disparo_y_original
		punto_disparo.position.x = punto_disparo_x_original
		

	if Input.is_action_just_pressed("shoot"):
		disparar()

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

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

	if global_position.y > limite_caida:
		recibir_danio()

func disparar() -> void:
	if bala_scene == null:
		print("No hay escena de bala asignada")
		return

	var bala = bala_scene.instantiate()
	bala.global_position = punto_disparo.global_position

	if mirando_derecha:
		bala.direction = 1
		#bala.scale.x = abs(bala.scale.x)
	else:
		bala.direction = -1
		#bala.scale.x = -abs(bala.scale.x)

	get_tree().current_scene.add_child(bala)
	print("Bala creada en: ", bala.global_position)

func recibir_danio() -> void:
	vidas -= 1
	print("Vidas restantes: ", vidas)
	actualizar_corazones()

	if vidas <= 0:
		game_over()
	else:
		reiniciar_posicion()

func reiniciar_posicion() -> void:
	global_position = posicion_inicial
	velocity = Vector2.ZERO

func actualizar_corazones() -> void:
	heart_1.visible = vidas >= 1
	heart_2.visible = vidas >= 2
	heart_3.visible = vidas >= 3

func recibir_dano(cantidad: int) -> void:
	if invulnerable:
		return
	
	vidas -= cantidad
	print("Vidas:", vidas)
	
	if vidas <= 0:
		morir()
	else:
		invulnerabilidad_temporal()

func invulnerabilidad_temporal() -> void:
	invulnerable = true
	await get_tree().create_timer(1.0).timeout
	invulnerable = false

func morir() -> void:
	queue_free()
	# O puedes reiniciar escena:
	# get_tree().reload_current_scene()

func game_over() -> void:
	get_tree().change_scene_to_file("res://personajes/game_over.tscn")
