extends CharacterBody2D

var gravity = 800
var speed = 50
var direction = 1

func _ready() -> void:
	$AnimationPlayer.play("walk")

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = speed * direction

	move_and_slide()

	if is_on_wall():
		direction *= -1
		$Sprite2D.flip_h = direction < 0

func _on_area_2d_body_entered(body: Node) -> void:
	if body.name == "Jugador":
		body.recibir_danio()
