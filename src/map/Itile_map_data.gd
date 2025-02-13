extends Node2D
class_name ITileMapData


var _data: Dictionary = {}
var selected_tile_id: int

func get_all_tiles(tile_id: int, deep: int) -> Array[TileInterface]:
	var child_tiles = get_all_child_tiles(tile_id, deep)
	var parent_tiles = get_all_parent_tiles(tile_id, deep)
	
	var target: Array[TileInterface] = []
	
	parent_tiles.reverse()
	target.append_array(parent_tiles)
	
	if child_tiles.size() <= 1:
		return target
	
	for child_tile in child_tiles.slice(1, child_tiles.size()):
		target.push_back(child_tile)
	
	return target

func add_tile_by_tile_id(tile_id: int, tile: TileInterface) -> ITileData:
	var tile_data: ITileData = _data.get(tile_id)
	if tile_data == null:
		return
	var new_tile_data := self.add_tile(tile)
	tile_data.tile_children_ids.push_back(new_tile_data.get_tile_id())
	new_tile_data.tile_parent_ids.push_back(tile_data.get_tile_id())
	 
	return new_tile_data


func get_all_child_tiles(tile_id: int, deep: int) -> Array[TileInterface]:
	var tile = get_tile(tile_id)
	if tile == null:
		return []
	
	if deep <= 0:
		return [tile]
	
	var tiles : Array[TileInterface] = [tile]
	
	for tile_children in get_child_tiles(tile_id):
		var tmp = get_all_child_tiles(tile_children.get_tile_id(), deep -1)
		tiles.append_array(tmp)
	
	return tiles


func get_all_parent_tiles(tile_id: int, deep: int) -> Array[TileInterface]:
	var tile = get_tile(tile_id)
	if tile == null:
		return []
	
	if deep <= 0:
		return [tile]
	
	var tiles : Array[TileInterface] = [tile]
	
	for parent_tile in get_parent_tiles(tile_id):
		var tmp = get_all_parent_tiles(parent_tile.get_tile_id(), deep -1)
		tiles.append_array(tmp)
	
	return tiles


func remove_tile(tile_id):
	var tile_data: ITileData = _data.get(tile_id)
	if tile_data == null:
		return
	
	
func add_tile(tile: TileInterface) -> ITileData:
	var tile_id = tile.get_tile_id()
	
	if selected_tile_id == null:
		selected_tile_id = tile.get_tile_id()
	var tile_data: ITileData = _data.get(tile_id)
	if tile_data:
		tile_data.tile = tile
	else:
		tile_data = ITileData.new_tile_data(tile)
		_data[tile_id] = tile_data
	return tile_data


func get_tile_data(tile_id: int) -> ITileSlotData:
	var tile = get_tile(tile_id)

	if tile == null:
		return null
	var child_tiles = get_child_tiles(tile_id)
	var parent_tiles = get_parent_tiles(tile_id)

	var tile_slot_data = ITileSlotData.new()
	tile_slot_data.child_tiles = child_tiles 
	tile_slot_data.parent_tiles = parent_tiles
	return tile_slot_data 


func get_tile(tile_id: int) -> TileInterface:
	var tile_data: ITileData = _data.get(tile_id)
	if tile_data:
		return tile_data.tile_interface
	else:
		return null


func get_child_tiles(tile_id: int) -> Array[TileInterface]:
	var tile_data: ITileData = _data.get(tile_id)
	if tile_data:
		return tile_data.get_child_tiles(self)
	else:
		return []

func get_parent_tiles(tile_id: int) -> Array[TileInterface]:
	var tile_data: ITileData = _data.get(tile_id)
	if tile_data:
		return tile_data.get_parent_tiles(self)
	else:
		return []

class ITileSlotData:
	var tile_interface: TileInterface
	var child_tiles: Array[TileInterface]
	var parent_tiles: Array[TileInterface]


class ITileData:
	var tile_interface: TileInterface
	var tile_children_ids: Array[int] = []
	var tile_parent_ids: Array[int] = []

	func get_tile_id() -> int:
		return tile_interface.get_tile_id()

	func remove_child_id(tile_id: int):
		tile_children_ids = tile_children_ids.filter(func (id): return id != tile_id)


	func remove_parent_id(tile_id: int):
		tile_parent_ids = tile_parent_ids.filter(func (id): return id != tile_id)


	static func new_tile_data(tile: TileInterface):
		var tmp  = ITileData.new()
		tmp.tile_interface = tile
		return tmp
	
	
	func get_child_tiles(tile_map: ITileMapData) -> Array[TileInterface]:
		var tiles: Array[TileInterface] = []
		for tile_id in tile_children_ids:
			var tile = tile_map.get_tile(tile_id)
			if tile:
				tiles.push_back(tile)

		return tiles

	
	func get_parent_tiles(tile_map: ITileMapData) -> Array[TileInterface]:
		var tiles: Array[TileInterface] = []
		for tile_id in tile_parent_ids:
			var tile = tile_map.get_tile(tile_id)
			if tile:
				tiles.push_back(tile)

		return tiles	


	func is_root() -> bool:
		if tile_parent_ids.is_empty():
			return true
		else:
			return false


	func is_leaf() -> bool:
		if tile_children_ids.is_empty():
			return true
		else:
			return false
