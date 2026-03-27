extends Area2D

@export var speed = 300.0
@export var max_distance = 150.0
@onready var sprite: Sprite2D = $Sprite2D

var direction = 1
var start_position: Vector2

func _ready() -> void:
	z_index = 10
	start_position = global_position
	if direction == -1:
		sprite.flip_h = true

func _physics_process(delta: float) -> void:
	global_position.x += speed * direction * delta

	if global_position.distance_to(start_position) >= max_distance:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemigos"):
		body.queue_free()
		queue_free()
	
	if body.is_in_group("escenario"):
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemigos"):
		area.queue_free()
		queue_free()
		
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
