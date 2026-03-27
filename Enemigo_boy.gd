extends CharacterBody2D

@export var speed: float = 80.0
@export var gravity: float = 900.0
@export var dano: int = 1

var jugador: Node = null
var jugador_en_rango: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_ataque: Area2D = $AreaAtaque
@onready var timer_ataque: Timer = $TimerAtaque

func _ready() -> void:
	area_ataque.body_entered.connect(_on_area_ataque_body_entered)
	area_ataque.body_exited.connect(_on_area_ataque_body_exited)
	timer_ataque.timeout.connect(_on_timer_ataque_timeout)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if jugador != null:
		var direccion = sign(jugador.global_position.x - global_position.x)
		velocity.x = direccion * speed

		if direccion > 0:
			animated_sprite.flip_h = false
		elif direccion < 0:
			animated_sprite.flip_h = true

		animated_sprite.play("walk")
	else:
		velocity.x = 0
		animated_sprite.play("idle")

	move_and_slide()

func _on_area_ataque_body_entered(body: Node) -> void:
	if body.is_in_group("jugador"):
		jugador = body
		jugador_en_rango = true

func _on_area_ataque_body_exited(body: Node) -> void:
	if body.is_in_group("jugador"):
		jugador = null
		jugador_en_rango = false

func _on_timer_ataque_timeout() -> void:
	if jugador_en_rango and jugador != null:
		if jugador.has_method("recibir_danio"):
			jugador.recibir_danio(dano)
		animated_sprite.play("attack")
