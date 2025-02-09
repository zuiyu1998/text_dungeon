extends GutTest

func test_props():
	var props = PropConst.get_default_props()
	
	props.update_prop("dexterity", 4)
	
	assert_eq(2, props.get_prop("first_attack").get_value())
	pass
