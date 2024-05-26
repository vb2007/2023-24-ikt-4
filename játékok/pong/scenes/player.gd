extends StaticBody2D

var windowHeight : int
var paddleHeight : int

func _ready():
	windowHeight = get_viewport_rect().size.y
	paddleHeight = $ColorRect.get_size().y

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().paddleSpeed * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().paddleSpeed * delta
	# csak az ablak széléig engedi mozgatni a player csúszkát
	position.y = clamp(position.y, paddleHeight / 2, windowHeight - paddleHeight / 2)
