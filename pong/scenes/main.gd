extends Sprite2D

var score := [0, 0] #array, 1. a player, 2. az enemy
const paddleSpeed : int = 500


func _on_ball_timer_timeout():
	$Ball.newBall()

#player pontszámát kezeli
func _on_score_right_body_entered(body):
	score[0] += 1 #növeli 1-el
	$HUD/PlayerScore.text = str(score[0]) #grafikailag is frissíti
	$BallTimer.start() #majd új labdát generál

#enemy pontszámát kezeli
func _on_score_left_body_entered(body):
	score[1] += 1 #növeli 1-el
	$HUD/EnemyScore.text = str(score[1]) #grafikailag is frissíti
	$BallTimer.start() #majd új labdát generál
