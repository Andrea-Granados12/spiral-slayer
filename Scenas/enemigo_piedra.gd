extends CharacterBody2D

func _ready() -> void:
	add_to_group("enemigos") # importante para tus balas


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Jugador":
		body.recibir_danio() # Replace with function body.
