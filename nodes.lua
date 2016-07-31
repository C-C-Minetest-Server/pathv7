minetest.register_node("pathv7:junglewood", {
	description = "Mod jungle wood",
	tiles = {"default_junglewood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:bridgewood", {
	description = "Bridge wood",
	tiles = {"pathv7_bridgewood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairn", { -- stair rising to the north
	description = "Jungle wood stair N",
	tiles = {"default_junglewood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairs", {
	description = "Jungle wood stair S",
	tiles = {"default_junglewood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:staire", {
	description = "Jungle wood stair E",
	tiles = {"default_junglewood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairw", {
	description = "Jungle wood stair W",
	tiles = {"default_junglewood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairne", {
	description = "Jungle wood stair NE",
	tiles = {"default_junglewood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairnw", {
	description = "Jungle wood stair NW",
	tiles = {"default_junglewood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairse", {
	description = "Jungle wood stair SE",
	tiles = {"default_junglewood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairsw", {
	description = "Jungle wood stair SW",
	tiles = {"default_junglewood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})
