extends CharacterBody2D

var windowSize : Vector2
const startSpeed : int = 500
const acceleration : int = 50
var speed : int 
var direction : Vector2
const maxYVector : float = 0.6

#amint a labda "létre lesz hozva", futtatjuk ezt a cuccot
func _ready():
	windowSize = get_viewport_rect().size

#találat esetén visszarakja középre a labdát, és random indulási irányt ad neki
#(BallTimer fogja meghívni)
func newBall():
	position.x = windowSize.x / 2
	position.y = randi_range(200, windowSize.y - 200)
	speed = startSpeed
	direction = randomDirection()

#random indulást kalkuláló függvény
func randomDirection():
	var newDirection := Vector2()
	newDirection.x = [1, -1].pick_random() #vagy jobbra, vagy balra...
	newDirection.y = randf_range(-1, 1)
	return newDirection.normalized()

#labda mozgásának kezelése
#(+deltaTime, framerate independentség, blablabla...)
func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	var collider
	
	if collision:
		collider = collision.get_collider()
		#ha a labda csúszkát ér...
		if collider == $"../Player" or collider == $"../Enemy":
			#gyorsulással visszapattan, "új irányt kap"
			speed += acceleration
			direction = newDirection(collider)
		#ha a labda falat ér
		else:
			#gyorsulás nélkül visszapattan
			direction = direction.bounce(collision.get_normal())

#labda új irányát (visszaütés után) kalkulálja
func newDirection(collider):
	var ballY = position.y
	var paddleY = collider.position.y
	var distance = ballY - paddleY
	var newDirection := Vector2()
	
	if direction.x > 0:
		newDirection.x = -1
	else:
		newDirection.x = 1
	
	newDirection.y = (distance / (collider.paddleHeight / 2)) * maxYVector
	
	return newDirection.normalized()
