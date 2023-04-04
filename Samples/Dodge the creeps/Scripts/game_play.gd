extends SGamePlayLevel

var score = 0

func _add_health_bar():
	pass


func _on_ScoreTimer_timeout():
	score += 1
	$ScoreLabel.text = str(score)
