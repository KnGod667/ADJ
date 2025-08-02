extends ScrollContainer

var propertyNamesDict = {"GenerationRadius":"generationRadius","MeshSize":"meshSize",
						"MeshDetail":"detail","NoiseOffset":"globalNoiseOffset",
						"NoiseSeed":"noiseSeed","NoiseScale":"noiseScale",
						"GradientRotation":"gradientRotation","Lacunarity":"lacunarity",
						"InitialAmplitude":"initialAmplitude","AngularVariance":"angularVariance",
						"NoiseRotation":"noiseRotation","Octaves":"octaves","AmplitudeDecay":"amplitudeDecay",
						"FrequencyVarianceL":"frequencyVarianceLower","FrequencyVarianceU":"frequencyVarianceUpper",
						"TerrainHeight":"terrainHeight","TerrainOffset":"offset","SlopeDamping":"slopeDamping",
						"SlopeRange":"slopeRange","LowSlopeColor":"lowSlopeColor","HighSlopeColor":"highSlopeColor",
						"RaymarchedShadows":"RaymarchedShadows","SpecularPower":"specularPower","ShadowPrecision":"shadowPrecision","ShadowStep":"shadowStep",
						"ShadowPenumbra":"shadowPenumbra","SunPosition":"SunPosition","MoonPosition":"MoonPosition"}
@onready var tabContainer = $TabContainer
func _ready() -> void:
	if not GlobalVariables.is_node_ready():
		await GlobalVariables.ready
	on_setup_finished()
	GlobalVariables.setup_finished.connect(on_setup_finished)
	connect_children(tabContainer)

func connect_children(node:Node):
	if node is HBoxContainer:
		node.value_changed.connect(property_updated)
		return
	for n in node.get_children():
		connect_children(n)

func property_updated(propertyName,new_value):
	var propName = propertyName
	if propertyNamesDict.has(propName):
		propName = propertyNamesDict[propName]
	GlobalVariables.set(propName,new_value)
	pass

func on_setup_finished():
	$TabContainer/Mesh/GenerationRadius.value = GlobalVariables.generationRadius
	$TabContainer/Mesh/MeshSize.value = GlobalVariables.meshSize
	$TabContainer/Mesh/MeshDetail.value = GlobalVariables.detail
	$TabContainer/Noise/NoiseOffset.value = GlobalVariables.globalNoiseOffset
	$TabContainer/Noise/NoiseSeed.value = GlobalVariables.noiseSeed
	$TabContainer/Noise/NoiseScale.value = GlobalVariables.noiseScale
	$TabContainer/Noise/GradientRotation.value = GlobalVariables.gradientRotation
	$TabContainer/Noise/Lacunarity.value = GlobalVariables.lacunarity
	$TabContainer/Noise/InitialAmplitude.value = GlobalVariables.initialAmplitude
	$TabContainer/Noise/AngularVariance.value = GlobalVariables.angularVariance
	$TabContainer/Noise/NoiseRotation.value = GlobalVariables.noiseRotation
	$TabContainer/Noise/Octaves.value = GlobalVariables.octaves
	$TabContainer/Noise/AmplitudeDecay.value = GlobalVariables.amplitudeDecay
	$TabContainer/Noise/FrequencyVarianceL.value = GlobalVariables.frequencyVarianceLower
	$TabContainer/Noise/FrequencyVarianceU.value = GlobalVariables.frequencyVarianceUpper
	$TabContainer/Terrain/TerrainHeight.value = GlobalVariables.terrainHeight
	$TabContainer/Terrain/TerrainOffset.value = GlobalVariables.offset
	$TabContainer/Terrain/SlopeDamping.value = GlobalVariables.slopeDamping
	$TabContainer/Terrain/SlopeRange.value = GlobalVariables.slopeRange
	$TabContainer/Terrain/LowSlopeColor.value = GlobalVariables.lowSlopeColor
	$TabContainer/Terrain/HighSlopeColor.value = GlobalVariables.highSlopeColor
	$TabContainer/Light/RaymarchedShadows.value = GlobalVariables.RaymarchedShadows
	$TabContainer/Light/SpecularPower.value = GlobalVariables.specularPower
	$TabContainer/Light/ShadowPrecision.value = GlobalVariables.shadowPrecision
	$TabContainer/Light/ShadowStep.value = GlobalVariables.shadowStep
	$TabContainer/Light/ShadowPenumbra.value = GlobalVariables.shadowPenumbra
	$TabContainer/Sky/TabContainer/Sun/SunPosition.value = GlobalVariables.SunPosition
	$TabContainer/Sky/TabContainer/Sun/sun_color.value = GlobalVariables.sun_color
	$TabContainer/Sky/TabContainer/Sun/sun_sunset_color.value = GlobalVariables.sun_sunset_color
	$TabContainer/Sky/TabContainer/Sun/sun_size.value = GlobalVariables.sun_size
	$TabContainer/Sky/TabContainer/Sun/sun_blur.value = GlobalVariables.sun_blur
	$TabContainer/Sky/TabContainer/Moon/MoonPosition.value = GlobalVariables.MoonPosition
	$TabContainer/Sky/TabContainer/Moon/moon_color.value = GlobalVariables.moon_color
	$TabContainer/Sky/TabContainer/Moon/moon_size.value = GlobalVariables.moon_size
	$TabContainer/Sky/TabContainer/Moon/moon_blur.value = GlobalVariables.moon_blur
	$TabContainer/Sky/TabContainer/Sky/day_top_color.value = GlobalVariables.day_top_color
	$TabContainer/Sky/TabContainer/Sky/day_bottom_color.value = GlobalVariables.day_bottom_color
	$TabContainer/Sky/TabContainer/Sky/sunset_top_color.value = GlobalVariables.sunset_top_color
	$TabContainer/Sky/TabContainer/Sky/sunset_bottom_color.value = GlobalVariables.sunset_bottom_color
	$TabContainer/Sky/TabContainer/Sky/night_top_color.value = GlobalVariables.night_top_color
	$TabContainer/Sky/TabContainer/Sky/night_bottom_color.value = GlobalVariables.night_bottom_color
	$TabContainer/Sky/TabContainer/Horizon/horizon_color.value = GlobalVariables.horizon_color
	$TabContainer/Sky/TabContainer/Horizon/horizon_blur.value = GlobalVariables.horizon_blur
	$TabContainer/Sky/TabContainer/Clouds/clouds_edge_color.value = GlobalVariables.clouds_edge_color
	$TabContainer/Sky/TabContainer/Clouds/clouds_top_color.value = GlobalVariables.clouds_top_color
	$TabContainer/Sky/TabContainer/Clouds/clouds_middle_color.value = GlobalVariables.clouds_middle_color
	$TabContainer/Sky/TabContainer/Clouds/clouds_bottom_color.value = GlobalVariables.clouds_bottom_color
	$TabContainer/Sky/TabContainer/Clouds/clouds_speed.value = GlobalVariables.clouds_speed
	$TabContainer/Sky/TabContainer/Clouds/clouds_direction.value = GlobalVariables.clouds_direction
	$TabContainer/Sky/TabContainer/Clouds/clouds_scale.value = GlobalVariables.clouds_scale
	$TabContainer/Sky/TabContainer/Clouds/clouds_cutoff.value = GlobalVariables.clouds_cutoff
	$TabContainer/Sky/TabContainer/Clouds/clouds_fuzziness.value = GlobalVariables.clouds_fuzziness
	$TabContainer/Sky/TabContainer/Clouds/clouds_weight.value = GlobalVariables.clouds_weight
	$TabContainer/Sky/TabContainer/Clouds/clouds_blur.value = GlobalVariables.clouds_blur
	$TabContainer/Sky/TabContainer/Stars/stars_speed.value = GlobalVariables.stars_speed
