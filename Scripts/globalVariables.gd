extends Node

signal terrain_property_changed
signal sky_property_changed
signal setup_finished

var generationRadius : int = 2:
	set(s):
		generationRadius = s
		terrain_property_changed.emit("generationRadius",generationRadius)
var meshSize : float = 10.0:
	set(s):
		meshSize = s
		terrain_property_changed.emit("meshSize",meshSize)
var detail : int = 200:
	set(s):
		detail = s
		terrain_property_changed.emit("detail",detail)
var globalNoiseOffset : Vector2 = Vector2.ZERO:
	set(s):
		globalNoiseOffset = s
		terrain_property_changed.emit("globalNoiseOffset",globalNoiseOffset)
var noiseSeed : int = 0:
	set(s):
		noiseSeed = s
		terrain_property_changed.emit("noiseSeed",noiseSeed)
var noiseScale : float = 1.0:
	set(s):
		noiseScale = s
		terrain_property_changed.emit("noiseScale",noiseScale)
var gradientRotation : float = 0.0:
	set(s):
		gradientRotation = s
		terrain_property_changed.emit("gradientRotation",gradientRotation)
var lacunarity : float = 1.0:
	set(s):
		lacunarity = s
		terrain_property_changed.emit("lacunarity",lacunarity)
var initialAmplitude : float = 1.0:
	set(s):
		initialAmplitude = s
		terrain_property_changed.emit("initialAmplitude",initialAmplitude)
var angularVariance : Vector2 = Vector2.ZERO:
	set(s):
		angularVariance = s
		terrain_property_changed.emit("angularVariance",angularVariance)
var noiseRotation : float = 0.0:
	set(s):
		noiseRotation = s
		terrain_property_changed.emit("noiseRotation",noiseRotation)
var octaves : int = 4:
	set(s):
		octaves = s
		terrain_property_changed.emit("octaves",octaves)
var amplitudeDecay : float = 0.5:
	set(s):
		amplitudeDecay = s
		terrain_property_changed.emit("amplitudeDecay",amplitudeDecay)
var frequencyVarianceLower : float = 0.0:
	set(s):
		frequencyVarianceLower = s
		terrain_property_changed.emit("frequencyVarianceLower",frequencyVarianceLower)
var frequencyVarianceUpper : float = 1.0:
	set(s):
		frequencyVarianceUpper = s
		terrain_property_changed.emit("frequencyVarianceUpper",frequencyVarianceUpper)
var terrainHeight : float = 1.0:
	set(s):
		terrainHeight = s
		terrain_property_changed.emit("terrainHeight",terrainHeight)
var offset : Vector2 = Vector2.ZERO:
	set(s):
		offset = s
		terrain_property_changed.emit("offset",offset)
var slopeDamping : float = 1.0:
	set(s):
		slopeDamping = s
		terrain_property_changed.emit("slopeDamping",slopeDamping)
var slopeRange : Vector2 = Vector2.ONE:
	set(s):
		slopeRange = s
		terrain_property_changed.emit("slopeRange",slopeRange)
var lowSlopeColor : Color = Color.GREEN:
	set(s):
		lowSlopeColor = s
		terrain_property_changed.emit("lowSlopeColor",lowSlopeColor)
var highSlopeColor : Color = Color.SADDLE_BROWN:
	set(s):
		highSlopeColor = s
		terrain_property_changed.emit("highSlopeColor",highSlopeColor)
		
var RaymarchedShadows : bool = false:
	set(s):
		RaymarchedShadows = s
		terrain_property_changed.emit("RaymarchedShadows",RaymarchedShadows)
		pass
var specularPower : float = 64.0:
	set(s):
		specularPower = s
		terrain_property_changed.emit("specularPower",specularPower)
var shadowPrecision : int = 12:
	set(s):
		shadowPrecision = s
		terrain_property_changed.emit("shadowPrecision",shadowPrecision)
var shadowStep : float = 0.1:
	set(s):
		shadowStep = s
		terrain_property_changed.emit("shadowStep",shadowStep)
var shadowPenumbra : float = 0.1:
	set(s):
		shadowPenumbra = s
		terrain_property_changed.emit("shadowPenumbra",shadowPenumbra)

var SunPosition : Vector3 = Vector3.ZERO:
	set(s):
		SunPosition = s
		sky_property_changed.emit("SunPosition",SunPosition)
var MoonPosition : Vector3 = Vector3.ZERO:
	set(s):
		MoonPosition = s
		sky_property_changed.emit("MoonPosition",MoonPosition)

var sun_color :Color:
	set(s):
		sun_color = s
		sky_property_changed.emit("sun_color",sun_color)

var sun_sunset_color : Color:
	set(s):
		sun_sunset_color = s
		sky_property_changed.emit("sun_sunset_color",sun_sunset_color)

var sun_size : float:
	set(s):
		sun_size = s
		sky_property_changed.emit("sun_size",sun_size)

var sun_blur : float:
	set(s):
		sun_blur = s
		sky_property_changed.emit("sun_blur",sun_blur)

var moon_color : Color:
	set(s):
		moon_color = s
		sky_property_changed.emit("moon_color",moon_color)

var moon_size : float:
	set(s):
		moon_size = s
		sky_property_changed.emit("moon_size",moon_size)

var moon_blur : float:
	set(s):
		moon_blur = s
		sky_property_changed.emit("moon_blur",moon_blur)

var day_top_color : Color:
	set(s):
		day_top_color = s
		sky_property_changed.emit("day_top_color",day_top_color)

var day_bottom_color : Color:
	set(s):
		day_bottom_color = s
		sky_property_changed.emit("day_bottom_color",day_bottom_color)

var sunset_top_color : Color:
	set(s):
		sunset_top_color = s
		sky_property_changed.emit("sunset_top_color",sunset_top_color)

var sunset_bottom_color : Color:
	set(s):
		sunset_bottom_color = s
		sky_property_changed.emit("sunset_bottom_color",sunset_bottom_color)

var night_top_color : Color:
	set(s):
		night_top_color = s
		sky_property_changed.emit("night_top_color",night_top_color)

var night_bottom_color : Color:
	set(s):
		night_bottom_color = s
		sky_property_changed.emit("night_bottom_color",night_bottom_color)

var horizon_color : Color:
	set(s):
		horizon_color = s
		sky_property_changed.emit("horizon_color",horizon_color)

var horizon_blur : float:
	set(s):
		horizon_blur = s
		sky_property_changed.emit("horizon_blur",horizon_blur)

var clouds_edge_color : Color:
	set(s):
		clouds_edge_color = s
		sky_property_changed.emit("clouds_edge_color",clouds_edge_color)

var clouds_top_color : Color:
	set(s):
		clouds_top_color = s
		sky_property_changed.emit("clouds_top_color",clouds_top_color)

var clouds_middle_color : Color:
	set(s):
		clouds_middle_color = s
		sky_property_changed.emit("clouds_middle_color",clouds_middle_color)

var clouds_bottom_color : Color:
	set(s):
		clouds_bottom_color = s
		sky_property_changed.emit("clouds_bottom_color",clouds_bottom_color)

var clouds_speed : float:
	set(s):
		clouds_speed = s
		sky_property_changed.emit("clouds_speed",clouds_speed)

var clouds_direction : float:
	set(s):
		clouds_direction = s
		sky_property_changed.emit("clouds_direction",clouds_direction)

var clouds_scale : float:
	set(s):
		clouds_scale = s
		sky_property_changed.emit("clouds_scale",clouds_scale)

var clouds_cutoff : float:
	set(s):
		clouds_cutoff = s
		sky_property_changed.emit("clouds_cutoff",clouds_cutoff)

var clouds_fuzziness : float:
	set(s):
		clouds_fuzziness = s
		sky_property_changed.emit("clouds_fuzziness",clouds_fuzziness)

var clouds_weight : float:
	set(s):
		clouds_weight = s
		sky_property_changed.emit("clouds_weight",clouds_weight)

var clouds_blur : float:
	set(s):
		clouds_blur = s
		sky_property_changed.emit("clouds_blur",clouds_blur)

var stars_speed : float:
	set(s):
		stars_speed = s
		sky_property_changed.emit("stars_speed",stars_speed)
