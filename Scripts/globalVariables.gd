extends Node

signal terrain_property_changed
signal sky_property_changed

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
