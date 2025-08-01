@tool
class_name TerrainNode extends Node3D
@onready var mesh = $MeshChunk

func updateMesh(mesh_size:float, mesh_definition:int):
	mesh.mesh.size = Vector2(mesh_size,mesh_size)
	mesh.mesh.subdivide_width = mesh_definition
	mesh.mesh.subdivide_depth = mesh_definition
	pass

func setMaterial(mat:Material):
	mesh.mesh.material=mat
	pass
