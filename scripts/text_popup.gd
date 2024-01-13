extends Control

const CHAR_READ_RATE = 0.1

@onready var text_container = $CenteredTextContainer
@onready var label = $CenteredTextContainer/Label

func _ready():
	hide_textbox()
	add_text("PLANET CONNECTED!")

func hide_textbox():
	label.text = ""
	text_container.hide()

func show_textbox():
	text_container.show()

func add_text(next_text):
	label.text = next_text
	show_textbox()
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate:a", 0.0, len(label.text) * CHAR_READ_RATE)
	tween.connect("finished", on_2nd_tween_finished)

func on_2nd_tween_finished():
	queue_free()
