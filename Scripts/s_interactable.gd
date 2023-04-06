class_name SInteractable
extends Node2D

signal got_interacted


func interact():
	print("Got interacted")
	emit_signal("got_interacted")


func can_interact():
	return true
