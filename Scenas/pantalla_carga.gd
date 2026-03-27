extends Control

@export var siguiente_escena := "res://personajes/escenario_3.tscn"

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var progreso := 0

func _ready() -> void:
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	progress_bar.value = 0
	label.text = "Cargando."
	timer.start()

func _on_timer_timeout() -> void:
	progreso += 20
	progress_bar.value = progreso

	if progreso < 40:
		label.text = "Cargando."
	elif progreso < 70:
		label.text = "Cargando.."
	elif progreso < 100:
		label.text = "Cargando..."
	else:
		label.text = "¡Juguemos!"
		timer.stop()
		await get_tree().create_timer(0.3).timeout
		get_tree().change_scene_to_file(siguiente_escena)
