class_name  RotationSlider
extends Control

signal value_changed

@export var value :Vector3 = Vector3.ZERO:
	set(v):
		value = v
		if(not is_node_ready()):
			return
		$VBoxContainer/HBoxContainer/x.set_value_no_signal(value.x)
		$VBoxContainer/HBoxContainer2/y.set_value_no_signal(value.y)
		value_changed.emit(value)

func x_value_changed(v):
	value.x=v

func y_value_changed(v):
	value.y=v
