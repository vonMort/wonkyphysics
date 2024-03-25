extends CharacterBody2D

var ziel_position = Vector2()

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pass
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			ziel_position = get_global_mouse_position()

func _process(delta):
	if position.distance_to(ziel_position) > 1:
		position = position.move_toward(ziel_position, 100 * delta)

func _on_body_entered(body):
	if "baum" in body.get_groups():
		body.get_parent().baum_entfernen(body)
