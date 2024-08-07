extends Node2D

@export var block: PackedScene

# spawn positions
var spawn_position_x: Array[int] = [
	1, 18, 35, 52, 69, 
	86, 103, 120, 137, 154,
	171, 188, 205, 222, 239, 
	256, 273, 290, 307, 324
	]
	
var spawn_position_y: Array[int] = [1]
var spawn_count_x: int = 0
var spawn_count_y: int = 0
var block_number: int

# block variables
var new_block: ColorRect

var gray_blocks: Array[int] = [
	20, 39, 40, 59,
	60, 79,	80, 99,
	100, 119, 120, 139,
	140, 159, 160, 179,
	180, 199, 200, 219,
	220, 239, 240, 259, 
	260, 279, 280, 299,
	300, 319, 320, 339,
	340, 359, 360, 379,
	]
	
func _ready() -> void:
	SignalManager.connect("new_box_spawn", new_box_spawn_info)
	SignalManager.connect("change_color", change_color)
	draw_block()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("step_1"):
		forward_1()

	
func draw_block() -> void:
	for i in range(400):

		new_block = block.instantiate()
		
		new_block.position.x = spawn_position_x[spawn_count_x]
		new_block.position.y = spawn_position_y[-1]
		
		spawn_count_x += 1
		spawn_count_y += 1
		
		if spawn_count_x == 20:
			spawn_count_x = 0
		if spawn_count_y == 20:
			spawn_count_y = 0
			spawn_position_y.append(spawn_position_y[-1] + 17)
		
		if (i <= 19 || i >= 380):
			new_block.modulate = GlobalVars.gray
		
		if block_number in gray_blocks:
			new_block.modulate = GlobalVars.gray

		add_child(new_block)

		block_number += 1	
		
func new_box_spawn_info(block_id: int) -> void:
	var inst: Object = instance_from_id(block_id)
	GlobalVars.block_number_dict[block_id] = block_number
	GlobalVars.block_color_dict[block_id] = inst.modulate
	GlobalVars.block_position_dict[block_id] = inst.position
	#print(
	#	block_id, "\t",
	#	GlobalVars.block_color_dict[block_id], "\t",
	#	GlobalVars.block_number_dict[block_id], "\t",
	#	GlobalVars.block_position_dict[block_id], "\t",
	#)	
		
func change_color(block_id: int) -> void:
	var inst: Object = instance_from_id(block_id)

	if inst.modulate == GlobalVars.white:
		inst.modulate = GlobalVars.red
	elif inst.modulate == GlobalVars.red:
		inst.modulate = GlobalVars.white
		
func forward_1() -> void:
	var temp_number_dict: Dictionary = GlobalVars.block_number_dict.duplicate()
	var temp_color_dict: Dictionary = GlobalVars.block_color_dict.duplicate()
	var temp_position_dict: Dictionary = GlobalVars.block_number_dict.duplicate()
	
	for key: int in temp_color_dict:
		var value: Color = temp_color_dict[key]
		if value == GlobalVars.white:
			value = GlobalVars.red
			
	## TODO well, I have change, but it changes it to all white. bedtime
	for key: int in GlobalVars.block_color_dict:
		var value: Color = temp_color_dict[key]
		var inst: Object = instance_from_id(key)
		inst.modulate = value



	
