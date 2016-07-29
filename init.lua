-- Parameters

local YMAXMINP = -32 -- Maximum minp.y of generated chunks
					-- (-32 for default mapgen v6. 48, 128, 208 for higher)
local HSAMP = 0.03 -- Height select amplitude. Maximum steepness of paths
local HSOFF = 0.0 -- Height select offset.
					-- Bias paths towards lower (-) or higher (+) terrain
local TCOL = 0.3 -- Column noise threshold. Bridge column density


-- Mapgen v7 parameters

-- 2D noise for base terrain

local np_base = {
	offset = 4,
	scale = 70,
	spread = {x = 600, y = 600, z = 600},
	seed = 82341,
	octaves = 5,
	persist = 0.6
}

-- 2D noise for alt terrain

local np_alt = {
	offset = 4,
	scale = 25,
	spread = {x = 600, y = 600, z = 600},
	seed = 5934,
	octaves = 5,
	persist = 0.6
}

-- 2D noise for height select

local np_select = {
	offset = -8,
	scale = 16,
	spread = {x = 500, y = 500, z = 500},
	seed = 4213,
	octaves = 5, -- default 6
	persist = 0.3 -- default 0.7
}

-- Mod path parameters

-- 2D noise for patha

local np_patha = {
	offset = 0,
	scale = 1,
	spread = {x = 1024, y = 1024, z = 1024},
	seed = 11711,
	octaves = 3,
	persist = 0.4
}

-- 2D noise for pathb

local np_pathb = {
	offset = 0,
	scale = 1,
	spread = {x = 2048, y = 2048, z = 2048},
	seed = -8017,
	octaves = 4,
	persist = 0.4
}

-- 2D noise for pathc

local np_pathc = {
	offset = 0,
	scale = 1,
	spread = {x = 4096, y = 4096, z = 4096},
	seed = 300707,
	octaves = 5,
	persist = 0.4
}

-- 2D noise for pathd

local np_pathd = {
	offset = 0,
	scale = 1,
	spread = {x = 8192, y = 8192, z = 8192},
	seed = -80033,
	octaves = 6,
	persist = 0.4
}

-- 2D noise for columns

local np_column = {
	offset = 0,
	scale = 1,
	spread = {x = 8, y = 8, z = 8},
	seed = 1728833,
	octaves = 3,
	persist = 2
}


-- Do files

dofile(minetest.get_modpath("pathv7") .. "/nodes.lua")


-- Initialise noise objects to nil

local nobj_base = nil
local nobj_alt = nil
local nobj_select = nil
local nobj_patha = nil
local nobj_pathb = nil
local nobj_pathc = nil
local nobj_pathd = nil
local nobj_column = nil

-- Localise noise buffers

local nbuf_base
local nbuf_alt
local nbuf_select
local nbuf_patha
local nbuf_pathb
local nbuf_pathc
local nbuf_pathd
local nbuf_column


-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y < -32 or minp.y > YMAXMINP then
		return
	end

	local t1 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	
	local c_air      = minetest.get_content_id("air")
	local c_ignore   = minetest.get_content_id("ignore")
	local c_tree     = minetest.get_content_id("default:tree")
	local c_sand     = minetest.get_content_id("default:sand")
	local c_dirt     = minetest.get_content_id("default:dirt")
	local c_grass    = minetest.get_content_id("default:dirt_with_grass")
	local c_drygrass = minetest.get_content_id("default:dirt_with_dry_grass")
	local c_dirtsnow = minetest.get_content_id("default:dirt_with_snow")
	local c_desand   = minetest.get_content_id("default:desert_sand")
	local c_stone    = minetest.get_content_id("default:stone")
	local c_sastone  = minetest.get_content_id("default:sandstone")
	local c_destone  = minetest.get_content_id("default:desert_stone")
	local c_ice      = minetest.get_content_id("default:ice")
	local c_meselamp = minetest.get_content_id("default:meselamp")

	local c_wood   = minetest.get_content_id("pathv7:junglewood")
	local c_path   = minetest.get_content_id("pathv7:path")
	local c_column = minetest.get_content_id("pathv7:bridgewood")

	local c_stairn  = minetest.get_content_id("pathv7:stairn")
	local c_stairs  = minetest.get_content_id("pathv7:stairs")
	local c_staire  = minetest.get_content_id("pathv7:staire")
	local c_stairw  = minetest.get_content_id("pathv7:stairw")
	local c_stairne = minetest.get_content_id("pathv7:stairne")
	local c_stairnw = minetest.get_content_id("pathv7:stairnw")
	local c_stairse = minetest.get_content_id("pathv7:stairse")
	local c_stairsw = minetest.get_content_id("pathv7:stairsw")
	
	local c_pstairn  = minetest.get_content_id("pathv7:pstairn")
	local c_pstairs  = minetest.get_content_id("pathv7:pstairs")
	local c_pstaire  = minetest.get_content_id("pathv7:pstaire")
	local c_pstairw  = minetest.get_content_id("pathv7:pstairw")
	local c_pstairne = minetest.get_content_id("pathv7:pstairne")
	local c_pstairnw = minetest.get_content_id("pathv7:pstairnw")
	local c_pstairse = minetest.get_content_id("pathv7:pstairse")
	local c_pstairsw = minetest.get_content_id("pathv7:pstairsw")

	local sidelen = x1 - x0 + 1
	local emerlen = sidelen + 32
	local overlen = sidelen + 5 -- noisemap x, z from minp-3 to maxp+2
	local chulens = {x = overlen, y = overlen, z = 1}
	local minpos = {x = x0 - 3, y = z0 - 3}

	nobj_base   = nobj_base   or minetest.get_perlin_map(np_base,   chulens)
	nobj_alt    = nobj_alt    or minetest.get_perlin_map(np_alt,    chulens)
	nobj_select = nobj_select or minetest.get_perlin_map(np_select, chulens)

	nobj_patha  = nobj_patha  or minetest.get_perlin_map(np_patha,  chulens)
	nobj_pathb  = nobj_pathb  or minetest.get_perlin_map(np_pathb,  chulens)
	nobj_pathc  = nobj_pathc  or minetest.get_perlin_map(np_pathc,  chulens)
	nobj_pathd  = nobj_pathd  or minetest.get_perlin_map(np_pathd,  chulens)
	nobj_column = nobj_column or minetest.get_perlin_map(np_column, chulens)
	
	local nvals_base   = nobj_base  :get2dMap_flat({x = x0 - 3, y = z0 - 3}, nbuf_base)
	local nvals_alt    = nobj_alt   :get2dMap_flat({x = x0 - 3, y = z0 - 3}, nbuf_alt)
	local nvals_select = nobj_select:get2dMap_flat({x = x0 - 3, y = z0 - 3}, nbuf_select)

	local nvals_patha  = nobj_patha :get2dMap_flat(minpos, nbuf_patha)
	local nvals_pathb  = nobj_pathb :get2dMap_flat(minpos, nbuf_pathb)
	local nvals_pathc  = nobj_pathc :get2dMap_flat(minpos, nbuf_pathc)
	local nvals_pathd  = nobj_pathd :get2dMap_flat(minpos, nbuf_pathd)
	local nvals_column = nobj_column:get2dMap_flat(minpos, nbuf_column)
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
	local data = vm:get_data()

	local ni = 1
	local stable = {}
	for z = z0 - 3, z1 + 2 do
		local n_xprepatha = false
		local n_xprepathb = false
		local n_xprepathc = false
		local n_xprepathd = false
		-- x0 - 3, z0 - 3 is to setup initial values of 'xprepath_', 'zprepath_'
		for x = x0 - 3, x1 + 2 do
			local n_patha = nvals_patha[ni]
			local n_zprepatha = nvals_patha[(ni - overlen)]

			local n_pathb = nvals_pathb[ni]
			local n_zprepathb = nvals_pathb[(ni - overlen)]
			
			local n_pathc = nvals_pathc[ni]
			local n_zprepathc = nvals_pathc[(ni - overlen)]

			local n_pathd = nvals_pathd[ni]
			local n_zprepathd = nvals_pathd[(ni - overlen)]

			if x >= x0 - 2 and z >= z0 - 2 then
				local abscol = math.abs(nvals_column[ni])
				local base = nvals_base[ni]
				local alt = nvals_alt[ni]
				local select = nvals_select[ni]
				if base < alt then
					base = alt
				end
				local tblend = 0.5 + HSAMP * (select - 0.5) + HSOFF
				tblend = math.min(math.max(tblend, 0), 1)
				local tlevel = base * tblend + alt * (1 - tblend)
				-- TODO allow path above
				local pathy = math.floor(math.min(math.max(tlevel, 7), 42))

				if (n_patha >= 0 and n_xprepatha < 0) -- detect sign change of noise
						or (n_patha < 0 and n_xprepatha >= 0)
						or (n_patha >= 0 and n_zprepatha < 0)
						or (n_patha < 0 and n_zprepatha >= 0)

						or (n_pathb >= 0 and n_xprepathb < 0)
						or (n_pathb < 0 and n_xprepathb >= 0)
						or (n_pathb >= 0 and n_zprepathb < 0)
						or (n_pathb < 0 and n_zprepathb >= 0)

						or (n_pathc >= 0 and n_xprepathc < 0)
						or (n_pathc < 0 and n_xprepathc >= 0)
						or (n_pathc >= 0 and n_zprepathc < 0)
						or (n_pathc < 0 and n_zprepathc >= 0)

						or (n_pathd >= 0 and n_xprepathd < 0)
						or (n_pathd < 0 and n_xprepathd >= 0)
						or (n_pathd >= 0 and n_zprepathd < 0)
						or (n_pathd < 0 and n_zprepathd >= 0) then
					if pathy > y1 then
						-- build columns through this chunk
						if abscol < TCOL then
							for i = -1, 1, 2 do
							for k = -1, 1, 2 do
								local vi = area:index(x + i, y1, z + k)
								for y = 1, sidelen do
									local nodid = data[vi]
									if nodid == c_stone
											or nodid == c_destone
											or nodid == c_sastone
											or nodid == c_ice then
										break
									else
										data[vi] = c_column
									end
									vi = vi - emerlen
								end
							end
							end
						end
					elseif pathy >= y0 then
						-- path in chunk
						-- scan disk at path level for dirt
						local wood = true
						for k = -2, 2 do
							local vi = area:index(x - 2, pathy, z + k)
							for i = -2, 2 do
								local nodid = data[vi]
								if nodid == c_dirt
										or nodid == c_grass
										or nodid == c_dirtsnow
										or nodid == c_drygrass then
									wood = false -- use dirt path node
								end
								vi = vi + 1
							end
						end
						-- scan disk 5 nodes above path for stone/ice
						local tunnel = false
						local excatop
						for k = -2, 2 do
							local vi = area:index(x - 2, pathy + 5, z + k)
							for i = -2, 2 do
								local nodid = data[vi]
								if nodid == c_stone
										or nodid == c_destone
										or nodid == c_sastone
										or nodid == c_ice then
									tunnel = true
								end
								vi = vi + 1
							end
						end

						if tunnel then
							excatop = pathy + 5 -- tunnel
						else
							excatop = y1 -- excavate to chunk top
						end
						-- place path node brush
						if wood then
							local vi = area:index(x - 2, pathy, z - 2)
							if data[vi] ~= c_path
									and data[vi] ~= c_wood then
								data[vi] = c_stairne
							end
							for iter = 1, 3 do
								vi = vi + 1
								if data[vi] ~= c_path
										and data[vi] ~= c_wood then
									data[vi] = c_stairn
								end
							end
							vi = vi + 1
							if data[vi] ~= c_path
									and data[vi] ~= c_wood then
								data[vi] = c_stairnw
							end
	
							for k = -1, 1 do
								local vi = area:index(x - 2, pathy, z + k)
								if data[vi] ~= c_path
										and data[vi] ~= c_wood then
									data[vi] = c_staire
								end
								for iter = 1, 3 do
									vi = vi + 1
									data[vi] = c_wood
								end
								vi = vi + 1
								if data[vi] ~= c_path
										and data[vi] ~= c_wood then
									data[vi] = c_stairw
								end
							end
	
							local vi = area:index(x - 2, pathy, z + 2)
							if data[vi] ~= c_path
									and data[vi] ~= c_wood then
								data[vi] = c_stairse
							end
							for iter = 1, 3 do
								vi = vi + 1
								if data[vi] ~= c_path
										and data[vi] ~= c_wood then
									data[vi] = c_stairs
								end
							end
							vi = vi + 1
							if data[vi] ~= c_path
									and data[vi] ~= c_wood then
								data[vi] = c_stairsw
							end
						else
							local vi = area:index(x - 2, pathy, z - 2)
							if data[vi] ~= c_path
									and data[vi] ~= c_wood then
								data[vi] = c_pstairne
							end
							for iter = 1, 3 do
								vi = vi + 1
								if data[vi] ~= c_path
										and data[vi] ~= c_wood then
									data[vi] = c_pstairn
								end
							end
							vi = vi + 1
							if data[vi] ~= c_path
									and data[vi] ~= c_wood then
								data[vi] = c_pstairnw
							end
	
							for k = -1, 1 do
								local vi = area:index(x - 2, pathy, z + k)
								if data[vi] ~= c_path
										and data[vi] ~= c_wood then
									data[vi] = c_pstaire
								end
								for iter = 1, 3 do
									vi = vi + 1
									data[vi] = c_path
								end
								vi = vi + 1
								if data[vi] ~= c_path
										and data[vi] ~= c_wood then
									data[vi] = c_pstairw
								end
							end
	
							local vi = area:index(x - 2, pathy, z + 2)
							if data[vi] ~= c_path
									and data[vi] ~= c_wood then
								data[vi] = c_pstairse
							end
							for iter = 1, 3 do
								vi = vi + 1
								if data[vi] ~= c_path
										and data[vi] ~= c_wood then
									data[vi] = c_pstairs
								end
							end
							vi = vi + 1
							if data[vi] ~= c_path
									and data[vi] ~= c_wood then
								data[vi] = c_pstairsw
							end
						end
						-- excavate above path
						for y = pathy + 1, excatop do
							for k = -2, 2 do
								local vi = area:index(x - 2, y, z + k)
								for i = -2, 2 do
									local nodid = data[vi]
									if y == excatop then
										if nodid == c_dirt
												or nodid == c_grass
												or nodid == c_drygrass
												or nodid == c_dirtsnow then
											data[vi] = c_stone
										elseif nodid == c_desand then
											data[vi] = c_destone
										elseif tunnel
												and math.random() < 0.05
												and (nodid == c_stone
												or nodid == c_destone
												or nodid == c_sastone
												or nodid == c_ice) then
											data[vi] = c_meselamp
										end
									elseif y <= pathy + 4 then
										if nodid ~= c_wood
												and nodid ~= c_path
												and nodid ~= c_stairn
												and nodid ~= c_stairs
												and nodid ~= c_staire
												and nodid ~= c_stairw
												and nodid ~= c_stairne
												and nodid ~= c_stairnw
												and nodid ~= c_stairse
												and nodid ~= c_stairsw
												and nodid ~= c_pstairn
												and nodid ~= c_pstairs
												and nodid ~= c_pstaire
												and nodid ~= c_pstairw
												and nodid ~= c_pstairne
												and nodid ~= c_pstairnw
												and nodid ~= c_pstairse
												and nodid ~= c_pstairsw then
											data[vi] = c_air
										end
									else
										data[vi] = c_air
									end
									vi = vi + 1
								end
							end
						end
						-- bridge structure
						if wood then
							for i = -1, 1 do
							for k = -1, 1 do
								if not (i == 0 and k == 0) then
									local vi = area:index(x + i, pathy - 1, z + k)
									for y = 1, 2 do
										data[vi] = c_column
										vi = vi - emerlen
									end
								end
							end
							end
							-- columns
							if abscol < TCOL then
								for i = -1, 1, 2 do
								for k = -1, 1, 2 do
									local vi = area:index(x + i, pathy - 3, z + k)
									for y = pathy - 3, y0, -1 do
										local nodid = data[vi]
										if nodid == c_stone
												or nodid == c_destone
												or nodid == c_sastone
												or nodid == c_ice then
											break
										else
											data[vi] = c_column
										end
										vi = vi - emerlen
									end
								end
								end
							end
						end
					end
				end
			end

			n_xprepatha = n_patha
			n_xprepathb = n_pathb
			n_xprepathc = n_pathc
			n_xprepathd = n_pathd
			ni = ni + 1
		end
	end
	
	vm:set_data(data)
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	vm:write_to_map(data)

	local chugent = math.ceil((os.clock() - t1) * 1000)
	print ("[pathv7] Generate chunk " .. chugent .. " ms")
end)
