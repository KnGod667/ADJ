@tool
extends HBoxContainer

signal value_changed

@export var propertyName:String:
	set(v):
		propertyName=v
		if is_node_ready():
			update_property_name()
@export_enum("Integer","Float","Vector2","Color","Boolean","Rotation") var propertyType:int:
	set(v):
		propertyType = v
		if is_node_ready():
			update_property_type()

var value:
	set(v):
		value = v
		var c = find_child("PropertyValue",true,false)
		if(c!=null):
			match propertyType:
				0:
					if(value is int):
						c.text = String.num_int64(value)
				1:
					if(value is float):
						c.text = String.num(value)
				2:
					var x = c.find_child("x",true,false)
					var y = c.find_child("y",true,false)
					if value is Vector2:
						x.text = String.num(value.x)
						y.text = String.num(value.y)
				3:
					if value is Color:
						c.color = value
				4:
					if value is bool:
						c.button_pressed = value
				5:
					if value is Vector3 and value!=c.value:
						c.value = value
		value_changed.emit(name,value)
		pass

func _ready() -> void:
	update_property_name()
	update_property_type()

func update_property_name():
	$PropertyName.text=propertyName

func update_property_type():
	var c = find_child("PropertyValue",true,false)
	if c !=null:
		remove_child(c)
		c.queue_free()
	#here switch between the options and instantiate the node for the job
	match propertyType:
		0:
			if not (value is int):
				value = 0
			add_LineEdit(LineEdit.KEYBOARD_TYPE_NUMBER)
			pass
		1:
			if not (value is float):
				value = 0.0
			add_LineEdit(LineEdit.KEYBOARD_TYPE_NUMBER_DECIMAL)
			pass
		2:
			if not (value is Vector2):
				value = Vector2.ZERO
			add_vector_edit()
		3:
			if not (value is Color):
				value = Color.BLACK
			add_color_edit()
		4:
			if not value is bool:
				value = false
			add_bool_edit()
		5:
			if not value is Vector3:
				value = Vector3.ZERO
			add_rotation_edit()
	pass

func add_LineEdit(keyboardType:int):
	var le = LineEdit.new()
	le.name="PropertyValue"
	le.virtual_keyboard_type=keyboardType
	le.focus_exited.connect(on_focus_exited)
	le.text_submitted.connect(on_property_changed)
	if keyboardType == LineEdit.KEYBOARD_TYPE_NUMBER:
		le.text = String.num_int64(value)
	else:
		le.text = String.num(value)
	le.size_flags_horizontal = Control.SIZE_SHRINK_END
	add_child(le)

func add_vector_edit():
	var pv = VBoxContainer.new()
	pv.name="PropertyValue"
	var xle = LineEdit.new()
	xle.name="x"
	xle.virtual_keyboard_type=LineEdit.KEYBOARD_TYPE_NUMBER_DECIMAL
	xle.focus_exited.connect(on_focus_exited)
	xle.text_submitted.connect(on_property_changed)
	xle.text =  String.num(value.x)
	pv.add_child(xle)
	var yle = LineEdit.new()
	yle.name="y"
	yle.virtual_keyboard_type=LineEdit.KEYBOARD_TYPE_NUMBER_DECIMAL
	yle.focus_exited.connect(on_focus_exited)
	yle.text_submitted.connect(on_property_changed)
	yle.text = String.num(value.y)
	pv.add_child(yle)
	pv.size_flags_horizontal = Control.SIZE_SHRINK_END
	pv.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	add_child(pv)

func add_color_edit():
	var cc = ColorPickerButton.new()
	cc.name="PropertyValue"
	cc.color=value
	cc.focus_exited.connect(on_focus_exited)
	cc.color_changed.connect(on_property_changed)
	cc.size_flags_vertical=Control.SIZE_EXPAND_FILL
	cc.size_flags_horizontal=Control.SIZE_EXPAND_FILL
	add_child(cc)
	pass

func add_bool_edit():
	var cb = CheckBox.new()
	cb.name="PropertyValue"
	cb.button_pressed = value
	cb.toggled.connect(on_property_changed)
	add_child(cb)

func add_rotation_edit():
	var rs = preload("res://Scenes/UI/RotationSlider.tscn").instantiate()
	rs.name="PropertyValue"
	rs.value = value
	rs.connect("value_changed",on_property_changed)
	add_child(rs)

func on_focus_exited():
	on_property_changed(null)

func on_property_changed(_argument):
	var c = find_child("PropertyValue",true,false)
	match propertyType:
		0:
			if(c.text.is_valid_int()):
				value = int(c.text)
			else:
				c.text = String.num_int64(value) 
		1:
			if(c.text.is_valid_float()):
				value = float(c.text)
			else:
				c.text = String.num(value) 
		2:
			var x = c.find_child("x",true,false)
			var y = c.find_child("y",true,false)
			if x.text.is_valid_float() and y.text.is_valid_float():
				value = Vector2(float(x.text),float(y.text))
			else:
				x.text = String.num(value.x)
				y.text = String.num(value.y)
		3:
			value = c.color
		4:
			value = c.button_pressed
		5:
			value = c.value
