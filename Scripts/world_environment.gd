extends WorldEnvironment

@export var SunPosition : Vector3:
	set(s):
		SunPosition = s
		$"../Sun".rotation_degrees = SunPosition
@export var MoonPosition : Vector3:
	set(s):
		MoonPosition = s
		$"../Moon".rotation_degrees = MoonPosition

var shaderMat : ShaderMaterial = load("res://resources/Sky_material.tres")

func _ready() -> void:
	SunPosition = $"../Sun".rotation_degrees
	MoonPosition = $"../Moon".rotation_degrees
	GlobalVariables.SunPosition = SunPosition
	GlobalVariables.MoonPosition = MoonPosition
	GlobalVariables.sky_property_changed.connect(on_sky_property_change)


func on_sky_property_change(propName, value):
	set(propName,value)
	pass
