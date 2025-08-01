@tool
extends Node3D
@export var remoteTransform : Node3D:
	set(s):
		remoteTransform = s
		position.x = remoteTransform.position.x
		position.z = remoteTransform.position.z
@export var generationRadius : int = 2:
	set(s):
		generationRadius = s
		update_generation_radius()
@export_group("mesh")
@export var meshSize : float = 10.0:
	set(s):
		meshSize = s
		updateMesh()
@export var detail : int = 200:
	set(s):
		detail = s
		updateMesh()
@export_group("noise")
@export var globalNoiseOffset : Vector2 = Vector2.ZERO:
	set(s):
		globalNoiseOffset = s
		shaderMat.set_shader_parameter("global_noise_offset",s)
@export var noiseSeed : int = 0:
	set(s):
		noiseSeed = s
		shaderMat.set_shader_parameter("_Seed",noiseSeed)
@export var noiseScale : float = 1.0:
	set(s):
		noiseScale = s
		shaderMat.set_shader_parameter("_Scale",noiseScale)
@export var gradientRotation : float = 0.0:
	set(s):
		gradientRotation = s
		shaderMat.set_shader_parameter("_GradientRotation",gradientRotation)
@export var lacunarity : float = 1.0:
	set(s):
		lacunarity = s
		shaderMat.set_shader_parameter("_Lacunarity",lacunarity)
@export var initialAmplitude : float = 1.0:
	set(s):
		initialAmplitude = s
		shaderMat.set_shader_parameter("_InitialAmplitude",initialAmplitude)
@export var angularVariance : Vector2 = Vector2.ZERO:
	set(s):
		angularVariance = s
		shaderMat.set_shader_parameter("_AngularVariance",angularVariance)
@export var noiseRotation : float = 0.0:
	set(s):
		noiseRotation = s
		shaderMat.set_shader_parameter("_NoiseRotation",noiseRotation)
@export var octaves : int = 4:
	set(s):
		octaves = s
		shaderMat.set_shader_parameter("_Octaves",octaves)
@export var amplitudeDecay : float = 0.5:
	set(s):
		amplitudeDecay = s
		shaderMat.set_shader_parameter("_AmplitudeDecay",amplitudeDecay)
@export var frequencyVarianceLower : float = 0.0:
	set(s):
		frequencyVarianceLower = s
		shaderMat.set_shader_parameter("_FrequencyVarianceLowerBound",s)
@export var frequencyVarianceUpper : float = 1.0:
	set(s):
		frequencyVarianceUpper = s
		shaderMat.set_shader_parameter("_FrequencyVarianceUpperBound",s)
@export_group("terrain")
@export var terrainHeight : float = 1.0:
	set(s):
		terrainHeight = s
		shaderMat.set_shader_parameter("_TerrainHeight",terrainHeight)
@export var offset : Vector2 = Vector2.ZERO:
	set(s):
		offset = s
		shaderMat.set_shader_parameter("_Offset",offset)
@export var slopeDamping : float = 1.0:
	set(s):
		slopeDamping = s
		shaderMat.set_shader_parameter("_SlopeDamping",slopeDamping)
@export var slopeRange : Vector2 = Vector2.ONE:
	set(s):
		slopeRange = s
		shaderMat.set_shader_parameter("_SlopeRange",slopeRange)
@export var lowSlopeColor : Color = Color.GREEN:
	set(s):
		lowSlopeColor = s
		shaderMat.set_shader_parameter("_LowSlopeColor",lowSlopeColor)
@export var highSlopeColor : Color = Color.SADDLE_BROWN:
	set(s):
		highSlopeColor = s
		shaderMat.set_shader_parameter("_HighSlopeColor",highSlopeColor)
@export_group("light")
@export var RaymarchedShadows : bool = false:
	set(s):
		RaymarchedShadows = s
		shaderMat.set_shader_parameter("enable_raymarched_shadows",RaymarchedShadows)
		pass
@export var specularPower : float = 64.0:
	set(s):
		specularPower = s
		shaderMat.set_shader_parameter("specular_power",specularPower)
@export var shadowPrecision : int = 12:
	set(s):
		shadowPrecision = s
		shaderMat.set_shader_parameter("shadow_precision",shadowPrecision)
@export var shadowStep : float = 0.1:
	set(s):
		shadowStep = s
		shaderMat.set_shader_parameter("shadow_step",shadowStep)
@export var shadowPenumbra : float = 0.1:
	set(s):
		shadowPenumbra = s
		shaderMat.set_shader_parameter("shadow_penumbra",shadowPenumbra)

var shaderMat : ShaderMaterial = preload("res://resources/Procedural material.tres")
var terrainNode : PackedScene = preload("res://Scenes/Terrain Node.tscn")



func _ready() -> void:
	update_uniforms()
	update_global_state()
	update_generation_radius()
	GlobalVariables.connect("terrain_property_changed",on_global_state_changed)

func _process(delta: float) -> void:
	if remoteTransform != null:
		position.x = remoteTransform.position.x
		position.z = remoteTransform.position.z

func update_generation_radius():
	var area = pow(2*generationRadius+1,2)
	var children = get_children()
	if(children.size()>area):
		for i in children.size()-area:
			remove_child(children[i])
			children[i].queue_free()
	else:
		for i in area-children.size():
			var instance = terrainNode.instantiate()
			add_child.call_deferred(instance)
			if(not instance.is_node_ready()):
				await instance.ready
			instance.setMaterial(shaderMat)
	updateMesh()

func updateMesh():
	if not is_node_ready():
		return
	var children = get_children()
	for x in generationRadius*2+1:
		for y in generationRadius*2+1:
			var i = y*x
			children[i].updateMesh(meshSize,detail)
	centerGrid()

func update_uniforms():
	shaderMat.set_shader_parameter("global_noise_offset",globalNoiseOffset)
	shaderMat.set_shader_parameter("_Seed",noiseSeed)
	shaderMat.set_shader_parameter("_Scale",noiseScale)
	shaderMat.set_shader_parameter("_GradientRotation",gradientRotation)
	shaderMat.set_shader_parameter("_Lacunarity",lacunarity)
	shaderMat.set_shader_parameter("_InitialAmplitude",initialAmplitude)
	shaderMat.set_shader_parameter("_AngularVariance",angularVariance)
	shaderMat.set_shader_parameter("_NoiseRotation",noiseRotation)
	shaderMat.set_shader_parameter("_Octaves",octaves)
	shaderMat.set_shader_parameter("_AmplitudeDecay",amplitudeDecay)
	shaderMat.set_shader_parameter("_FrequencyVarianceLowerBound",frequencyVarianceLower)
	shaderMat.set_shader_parameter("_FrequencyVarianceUpperBound",frequencyVarianceUpper)
	
	shaderMat.set_shader_parameter("_TerrainHeight",terrainHeight)
	shaderMat.set_shader_parameter("_Offset",offset)
	shaderMat.set_shader_parameter("_SlopeDamping",slopeDamping)
	shaderMat.set_shader_parameter("_SlopeRange",slopeRange)
	shaderMat.set_shader_parameter("_LowSlopeColor",lowSlopeColor)
	shaderMat.set_shader_parameter("_HighSlopeColor",highSlopeColor)
	
	shaderMat.set_shader_parameter("enable_raymarched_shadows",RaymarchedShadows)
	shaderMat.set_shader_parameter("specular_power",specularPower)
	shaderMat.set_shader_parameter("shadow_precision",shadowPrecision)
	shaderMat.set_shader_parameter("shadow_step",shadowStep)
	shaderMat.set_shader_parameter("shadow_penumbra",shadowPenumbra)
	pass

func update_global_state():
	GlobalVariables.amplitudeDecay = amplitudeDecay
	GlobalVariables.angularVariance = angularVariance
	GlobalVariables.detail = detail
	GlobalVariables.frequencyVarianceLower = frequencyVarianceLower
	GlobalVariables.frequencyVarianceUpper = frequencyVarianceUpper
	GlobalVariables.generationRadius = generationRadius
	GlobalVariables.globalNoiseOffset = globalNoiseOffset
	GlobalVariables.gradientRotation = gradientRotation
	GlobalVariables.highSlopeColor = highSlopeColor
	GlobalVariables.initialAmplitude = initialAmplitude
	GlobalVariables.lacunarity = lacunarity
	GlobalVariables.lowSlopeColor = lowSlopeColor
	GlobalVariables.meshSize = meshSize
	GlobalVariables.noiseRotation = noiseRotation
	GlobalVariables.noiseScale = noiseScale
	GlobalVariables.noiseSeed = noiseSeed
	GlobalVariables.octaves = octaves
	GlobalVariables.offset = offset
	GlobalVariables.RaymarchedShadows = RaymarchedShadows
	GlobalVariables.shadowPenumbra = shadowPenumbra
	GlobalVariables.shadowPrecision = shadowPrecision
	GlobalVariables.shadowStep = shadowStep
	GlobalVariables.slopeDamping = slopeDamping
	GlobalVariables.slopeRange = slopeRange
	GlobalVariables.specularPower = specularPower
	GlobalVariables.terrainHeight = terrainHeight

func on_global_state_changed(propertyName,propertyValue):
	set(propertyName,propertyValue)
	pass

func centerGrid():
	var children = get_children()
	for x in generationRadius*2+1:
		for y in generationRadius*2+1:
			var i = (generationRadius*2+1)*y+x
			var pos = (Vector2(x,y)-Vector2(generationRadius,generationRadius))*meshSize
			children[i].position=Vector3(pos.x,children[i].position.y, pos.y)
	pass
