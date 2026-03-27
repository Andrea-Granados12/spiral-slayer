extends CharacterBody2D

@export var speed_x: float = 120.0
@export var speed_y: float = 160.0
@export var distancia_ataque: float = 220.0

var jugador: Node2D = null
var detectado: bool = false
var posicion_inicial: Vector2

func _ready() -> void:
	add_to_group("enemigos")
	posicion_inicial = global_position

func _physics_process(delta: float) -> void:
	if detectado and jugador != null:
		var dx = jugador.global_position.x - global_position.x
		var dy = jugador.global_position.y - global_position.y

		velocity.x = sign(dx) * speed_x

		# Si el jugador está abajo, baja hacia él
		if dy > 10:
			velocity.y = speed_y
		# Si está muy arriba, puede subir un poco
		elif dy < -10:
			velocity.y = -speed_y * 0.5
		else:
			velocity.y = 0
	else:
		# vuelve a su lugar
		var regreso = posicion_inicial - global_position

		if regreso.length() > 5:
			velocity = regreso.normalized() * 80.0
		else:
			velocity = Vector2.ZERO

	move_and_slide()

	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0

func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("jugador"):
		jugador = body as Node2D
		detectado = true

func _on_area_2d_body_exited(body: Node) -> void:
	if body.is_in_group("jugador"):
		detectado = false
		jugador = null
