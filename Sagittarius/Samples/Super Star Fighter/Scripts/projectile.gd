extends SProjectile


func _on_life_time_timeout():
	self.queue_free()
