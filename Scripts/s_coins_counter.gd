class_name SCoinsCounter
extends Node2D


func coins_updated(new_value):
	$CoinsLabel.text = "Coins: " + str(new_value)
	print("Coins labal updated!")
