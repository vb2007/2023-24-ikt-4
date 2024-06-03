extends StaticBody2D

var player_script: GDScript

var ballPosition : Vector2 #mivel kell tudnia a labda helyzetét, hogy felé mozogjon...
var distance : int
var moveBy : int #milyen messze mozoghat...
var windowHeight : int
var paddleHeight : int

func _ready():
	windowHeight = get_viewport_rect().size.y
	paddleHeight = $ColorRect.get_size().y

#mozgatja az enemyt a labda felé
func _process(delta):
	ballPosition = $"../Ball".position
	distance = position.y - ballPosition.y
	
	if abs(distance) > get_parent().paddleSpeed * delta:
		moveBy = get_parent().paddleSpeed * delta * (distance / abs(distance))
	else:
		moveBy = distance
	
	position.y -= moveBy
	
	position.y = clamp(position.y, paddleHeight / 2, windowHeight - paddleHeight / 2)

func get_random_color():
	return Color(randf(), randf(), randf())
