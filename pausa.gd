extends CanvasLayer

func _ready():
	visible = false

func mostrar():
	visible = true
	get_tree().paused = true

func ocultar():
	visible = false
	get_tree().paused = false

func _on_button_pressed() -> void:
	ocultar() # Replace with function body.
