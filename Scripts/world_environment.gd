#@tool
extends WorldEnvironment

@export_group("Sun")
@export var SunPosition : Vector3:
	set(s):
		SunPosition = s
		if is_node_ready():
			sun.rotation_degrees = SunPosition

@export var sun_color : Color:
	set(s):
		sun_color = s
		if is_node_ready():
			sun.light_color = sun_color

@export var sun_sunset_color : Color:
	set(s):
		sun_sunset_color = s
		shaderMat.set_shader_parameter("sun_sunset_color",sun_sunset_color)

@export var sun_size : float:
	set(s):
		sun_size = s
		shaderMat.set_shader_parameter("sun_size",sun_size)

@export var sun_blur : float:
	set(s):
		sun_blur = s
		shaderMat.set_shader_parameter("sun_blur",sun_blur)

@export_group("Moon")
@export var MoonPosition : Vector3:
	set(s):
		MoonPosition = s
		if is_node_ready():
			moon.rotation_degrees = MoonPosition

@export var moon_color : Color:
	set(s):
		moon_color = s
		shaderMat.set_shader_parameter("moon_color",moon_color)

@export var moon_size : float:
	set(s):
		moon_size = s
		shaderMat.set_shader_parameter("moon_size",moon_size)

@export var moon_blur : float:
	set(s):
		moon_blur = s
		shaderMat.set_shader_parameter("moon_blur",moon_blur)

@export_group("Sky")
@export var day_top_color : Color:
	set(s):
		day_top_color = s
		shaderMat.set_shader_parameter("day_top_color",day_top_color)

@export var day_bottom_color : Color:
	set(s):
		day_bottom_color = s
		shaderMat.set_shader_parameter("day_bottom_color",day_bottom_color)

@export var sunset_top_color : Color:
	set(s):
		sunset_top_color = s
		shaderMat.set_shader_parameter("sunset_top_color",sunset_top_color)

@export var sunset_bottom_color : Color:
	set(s):
		sunset_bottom_color = s
		shaderMat.set_shader_parameter("sunset_bottom_color",sunset_bottom_color)

@export var night_top_color : Color:
	set(s):
		night_top_color = s
		shaderMat.set_shader_parameter("night_top_color",night_top_color)

@export var night_bottom_color : Color:
	set(s):
		night_bottom_color = s
		shaderMat.set_shader_parameter("night_bottom_color",night_bottom_color)
@export_group("Horizon")
@export var horizon_color : Color:
	set(s):
		horizon_color = s
		shaderMat.set_shader_parameter("horizon_color",horizon_color)

@export var horizon_blur : float:
	set(s):
		horizon_blur = s
		shaderMat.set_shader_parameter("horizon_blur",horizon_blur)

@export_group("Clouds")
@export var clouds_edge_color : Color:
	set(s):
		clouds_edge_color = s
		shaderMat.set_shader_parameter("clouds_edge_color",clouds_edge_color)

@export var clouds_top_color : Color:
	set(s):
		clouds_top_color = s
		shaderMat.set_shader_parameter("clouds_top_color",clouds_top_color)

@export var clouds_middle_color : Color:
	set(s):
		clouds_middle_color = s
		shaderMat.set_shader_parameter("clouds_middle_color",clouds_middle_color)

@export var clouds_bottom_color : Color:
	set(s):
		clouds_bottom_color = s
		shaderMat.set_shader_parameter("clouds_bottom_color",clouds_bottom_color)

@export var clouds_speed : float:
	set(s):
		clouds_speed = s
		shaderMat.set_shader_parameter("clouds_speed",clouds_speed)

@export var clouds_direction : float:
	set(s):
		clouds_direction = s
		shaderMat.set_shader_parameter("clouds_direction",clouds_direction)

@export var clouds_scale : float:
	set(s):
		clouds_scale = s
		shaderMat.set_shader_parameter("clouds_scale",clouds_scale)

@export var clouds_cutoff : float:
	set(s):
		clouds_cutoff = s
		shaderMat.set_shader_parameter("clouds_cutoff",clouds_cutoff)

@export var clouds_fuzziness : float:
	set(s):
		clouds_fuzziness = s
		shaderMat.set_shader_parameter("clouds_fuzziness",clouds_fuzziness)

@export var clouds_weight : float:
	set(s):
		clouds_weight = s
		shaderMat.set_shader_parameter("clouds_weight",clouds_weight)

@export var clouds_blur : float:
	set(s):
		clouds_blur = s
		shaderMat.set_shader_parameter("clouds_blur",clouds_blur)

@export_group("Stars")
@export var stars_speed : float:
	set(s):
		stars_speed = s
		shaderMat.set_shader_parameter("stars_speed",stars_speed)

@onready var sun = $"../Sun"
@onready var moon = $"../Moon"
var shaderMat : ShaderMaterial = preload("res://resources/Sky_material.tres")

func _ready() -> void:
	sun.rotation_degrees = SunPosition
	sun.light_color = sun_color
	moon.rotation_degrees = MoonPosition
	GlobalVariables.SunPosition = SunPosition
	GlobalVariables.sun_color = sun_color
	GlobalVariables.sun_sunset_color = sun_sunset_color
	GlobalVariables.sun_size = sun_size
	GlobalVariables.sun_blur = sun_blur
	GlobalVariables.MoonPosition = MoonPosition
	GlobalVariables.moon_color = moon_color
	GlobalVariables.moon_size = moon_size
	GlobalVariables.moon_blur = moon_blur
	GlobalVariables.day_top_color = day_top_color
	GlobalVariables.day_bottom_color = day_bottom_color
	GlobalVariables.sunset_top_color = sunset_top_color
	GlobalVariables.sunset_bottom_color = sunset_bottom_color
	GlobalVariables.night_top_color = night_top_color
	GlobalVariables.night_bottom_color = night_bottom_color
	GlobalVariables.horizon_color = horizon_color
	GlobalVariables.horizon_blur = horizon_blur
	GlobalVariables.clouds_edge_color = clouds_edge_color
	GlobalVariables.clouds_top_color = clouds_top_color
	GlobalVariables.clouds_middle_color = clouds_middle_color
	GlobalVariables.clouds_bottom_color = clouds_bottom_color
	GlobalVariables.clouds_speed = clouds_speed
	GlobalVariables.clouds_direction = clouds_direction
	GlobalVariables.clouds_scale = clouds_scale
	GlobalVariables.clouds_cutoff = clouds_cutoff
	GlobalVariables.clouds_fuzziness = clouds_fuzziness
	GlobalVariables.clouds_weight = clouds_weight
	GlobalVariables.clouds_blur = clouds_blur
	GlobalVariables.stars_speed = stars_speed
	GlobalVariables.sky_property_changed.connect(on_sky_property_change)
	GlobalVariables.setup_finished.emit()


func on_sky_property_change(propName, value):
	set(propName,value)
	pass
