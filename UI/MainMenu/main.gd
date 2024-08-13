extends Node2D

@export var block: PackedScene
@export var hud: PackedScene

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

# hud vars
var new_hud: Control

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
	new_hud = hud.instantiate()
	new_hud.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	new_hud.position.x = 170
	new_hud.position.y = 340
	add_child(new_hud)
	
	SignalManager.connect("new_box_spawn", new_box_spawn_info)
	SignalManager.connect("change_color", change_color)
	SignalManager.connect("forward_one", forward_one)
	SignalManager.connect("forward_five", forward_five)
	SignalManager.connect("forward_ten", forward_ten)
	draw_block()
		
func forward_one() -> void:
	wait_one()
	
func forward_five() -> void:
	wait_five(0.45)
		
func forward_ten() -> void:
	wait_ten(0.45)

func wait_one() -> void:
	forward_1()
	
func wait_five(seconds: float) -> void:
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()

func wait_ten(seconds: float) -> void:
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
	forward_1()
	await get_tree().create_timer(seconds).timeout
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
	# modulate is the key to changing colors, not color oddly
	var inst: Object = instance_from_id(block_id)
	GlobalVars.block_number.append(block_number)
	GlobalVars.block_color.append(inst.modulate)
	GlobalVars.block_position.append(inst.position)
	GlobalVars.block_id.append(block_id)
	
	if inst.modulate == GlobalVars.gray:
		GlobalVars.block_on_off.append(2)
	elif inst.modulate == GlobalVars.white:
		GlobalVars.block_on_off.append(0)
	elif inst.modulate == GlobalVars.red:
		GlobalVars.block_on_off.append(1)

		
func change_color(block_id: int) -> void:
	# when clicked in area, changes color based on current area color
	var inst: Object = instance_from_id(block_id)
	
	var block_id_find: int = GlobalVars.block_id.find(block_id)
	
	var block_num: int = GlobalVars.block_number.find(block_id_find)
	
	if GlobalVars.block_on_off[block_id_find] == 0:
		inst.modulate = GlobalVars.red
		GlobalVars.block_color[block_id_find] = GlobalVars.red
		GlobalVars.block_on_off[block_id_find] = 1
		
	elif GlobalVars.block_on_off[block_id_find] == 1:
		inst.modulate = GlobalVars.white
		GlobalVars.block_on_off[block_id_find] = 0
		GlobalVars.block_color[block_id_find] = GlobalVars.white
		
	#print(block_id, "\t", block_id_find, "\t", block_num)
		
		
func forward_1() -> void:
	## TODO actualy program logic
	# need all squares surrounding; 8 variables 
	# current pos +1, -1, +9, -9, +10, -10, +11, -11
	# Oh my gawd it actually changes colors lawd in heaven
	# for skipping forward one step in time
	
	var block_on_off_temp: Array = []
	var count: int
	
	for i: int in range(0, 400):

		if i <= 20:
			block_on_off_temp.append(2)
			
		elif (count < 379
		&& !gray_blocks.has(count)):
			var alive_count: int
			# block being worked on
			var f1: int = GlobalVars.block_on_off[i + 1]
			var b1: int = GlobalVars.block_on_off[i - 1]
			
			var f19: int = GlobalVars.block_on_off[i + 19]
			var b19: int = GlobalVars.block_on_off[i - 19]
			
			var f20: int = GlobalVars.block_on_off[i + 20]
			var b20: int = GlobalVars.block_on_off[i - 20]
			
			var f21: int = GlobalVars.block_on_off[i + 21]
			var b21: int = GlobalVars.block_on_off[i - 21]
			
			#print(GlobalVars.block_number[i], "\t", GlobalVars.block_id[i], "\t", f1, "\t", b1, "\t", GlobalVars.block_on_off[i])
			
			if GlobalVars.block_on_off[i] == 1:
				if f1 == 1:
					alive_count += 1
				if b1 == 1:
					alive_count += 1
				if f19 == 1:
					alive_count += 1
				if b19 == 1:
					alive_count += 1
				if f20 == 1:
					alive_count += 1
				if b20 == 1:
					alive_count += 1
				if f21 == 1:
					alive_count += 1
				if b21 == 1:
					alive_count += 1
				
				if alive_count == 2 || alive_count == 3:
					block_on_off_temp.append(1)
	
				else:
					block_on_off_temp.append(0)
				alive_count = 0
			
			if GlobalVars.block_on_off[i] == 0:
				if f1 == 1:
					alive_count += 1
				if b1 == 1:
					alive_count += 1
				if f19 == 1:
					alive_count += 1
				if b19 == 1:
					alive_count += 1
				if f20 == 1:
					alive_count += 1
				if b20 == 1:
					alive_count += 1
				if f21 == 1:
					alive_count += 1
				if b21 == 1:
					alive_count += 1
				
				if alive_count == 3:
					block_on_off_temp.append(1)
	
				else:
					block_on_off_temp.append(0)
				alive_count = 0
			
				
		elif (count <= 379
		&& gray_blocks.has(count)):
			block_on_off_temp.append(2)
		elif count > 379:
			block_on_off_temp.append(2)
		
		count += 1
	
	GlobalVars.block_on_off = block_on_off_temp		
	for i: int in range(0, 400):
		var inst: Object = instance_from_id(GlobalVars.block_id[i])

		if GlobalVars.block_on_off[i] == 1:
			inst.modulate = GlobalVars.red
			GlobalVars.block_color[i] = GlobalVars.red
			
		if GlobalVars.block_on_off[i] == 0:
			inst.modulate = GlobalVars.white
			GlobalVars.block_color[i] = GlobalVars.white
			


