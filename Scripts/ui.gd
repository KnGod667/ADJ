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

func _ready() -> void:
	if not GlobalVariables.is_node_ready():
		await GlobalVariables.ready
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
	$TabContainer/Sky/SunPosition.value = GlobalVariables.SunPosition
	$TabContainer/Sky/MoonPosition.value = GlobalVariables.MoonPosition
	for x in $TabContainer.get_children():
		for n in x.get_children():
			if n is HBoxContainer:
				n.value_changed.connect(property_updated)
	pass
func property_updated(propertyName,new_value):
	GlobalVariables.set(propertyNamesDict[propertyName],new_value)
	pass
