minetest.register_node("pathv7:junglewood", {
	description = "Mod jungle wood",
	tiles = {"default_junglewood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:path", {
	description = "Dirt path",
	tiles = {"pathv7_path.png"},
	is_ground_content = false,
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
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

minetest.register_node("pathv7:pstairn", {
	description = "Dirt stair N",
	tiles = {"pathv7_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly = 2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv7:pstairs", {
	description = "Dirt stair S",
	tiles = {"pathv7_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly = 2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:pstaire", {
	description = "Dirt stair E",
	tiles = {"pathv7_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly = 2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv7:pstairw", {
	description = "Dirt stair W",
	tiles = {"pathv7_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly = 2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv7:pstairne", {
	description = "Dirt stair NE",
	tiles = {"pathv7_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly = 2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv7:pstairnw", {
	description = "Dirt stair NW",
	tiles = {"pathv7_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly = 2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv7:pstairse", {
	description = "Dirt stair SE",
	tiles = {"pathv7_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly = 2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("pathv7:pstairsw", {
	description = "Dirt stair SW",
	tiles = {"pathv7_path.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {crumbly = 2},
	drop = "default:dirt",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})
