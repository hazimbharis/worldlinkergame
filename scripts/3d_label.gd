extends Sprite3D

const CHAR_READ_RATE = 0.1

@onready var viewport = $SubViewport
@onready var label = $SubViewport/Label
var text = "OUCH!"
var disappear = true
func _ready():
	hide_textbox()
	match disappear:
		true:
			add_text(text)
		false:
			add_text_remain(text)

func hide_textbox():
	label.text = ""
	#viewport.hide()

func show_textbox():
	#viewport.show()
	pass

func add_text(next_text):
	label.text = next_text
	show_textbox()
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)
	tween.tween_property(label, "modulate:a", 0.0, len(label.text) * CHAR_READ_RATE).set_delay(len(next_text) * CHAR_READ_RATE)
	
	await tween.finished
	
	queue_free()

func add_text_remain(next_text):
	label.text = next_text
	show_textbox()
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)
