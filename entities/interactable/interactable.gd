extends Area2D
class_name Interactable

signal interacted;

@export var is_interactable: bool = true;

func interact():
	emit_signal("interacted");
