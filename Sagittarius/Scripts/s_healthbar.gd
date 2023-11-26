class_name SHealthBar
extends ProgressBar


func init(max_health, current_health):
	max_value = max_health
	value = current_health


func health_changed(new_health):
	value = new_health
