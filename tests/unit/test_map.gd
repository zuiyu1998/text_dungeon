extends GutTest



func test_tile_map_data():
	var tile_map_data = ITileMapData.new()
	var tile_interface = TileInterface.new()

	var tile_interface1 = TileInterface.new()
	var tile_interface2 = TileInterface.new()

	var root_tile_data = tile_map_data.add_tile(tile_interface)
	var second_tile_data = tile_map_data.add_tile_by_tile_id(root_tile_data.get_tile_id(), tile_interface1)
	var three_tile_data = tile_map_data.add_tile_by_tile_id(second_tile_data.get_tile_id(), tile_interface2)
	
	var tiles = tile_map_data.get_all_child_tiles(root_tile_data.get_tile_id(), 1)
	assert_eq(tiles.size(), 2)
	
	var parent_tiles = tile_map_data.get_all_parent_tiles(second_tile_data.get_tile_id(), 1)
	assert_eq(parent_tiles.size(), 2)
	
	var all_tiles = tile_map_data.get_all_tiles(second_tile_data.get_tile_id(), 1)
	assert_eq(all_tiles.size(), 3)
	
	assert_eq(all_tiles[0].get_tile_id(), root_tile_data.get_tile_id())
	assert_eq(all_tiles[1].get_tile_id(), second_tile_data.get_tile_id())
	assert_eq(all_tiles[2].get_tile_id(), three_tile_data.get_tile_id())
	
	pass

func test_tile_data():
	var tile_interface = TileInterface.new()
	
	var tile_data = ITileMapData.ITileData.new_tile_data(tile_interface)
	
	assert_eq(tile_data.is_root(), true)
	assert_eq(tile_data.is_leaf(), true)
	
	tile_data.tile_children_ids.assign([2])
	tile_data.tile_parent_ids.assign([1])
	
	tile_data.remove_child_id(2)
	assert_eq(tile_data.is_leaf(), true)
	
	tile_data.remove_parent_id(1)
	assert_eq(tile_data.is_root(), true)
	
	pass
