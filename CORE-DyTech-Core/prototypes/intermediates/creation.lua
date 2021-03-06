require "prototypes.intermediates.intermediates"

function DyTech_Core_Create_Intermediates_Item(NAME, CATEGORY)
  local result =
  {
    type = "item",
    name = "pig-iron-plate",
	icon = "__MAIN-DyTech-Metallurgy__/graphics/metals/iron/pig.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "dytech-intermediates-all",
    order = "iron-pig",
    stack_size = 200
  }
  result.name = NAME
  result.order = NAME
  result.subgroup = "dytech-intermediates-" .. CATEGORY
  result.icon = "__CORE-DyTech-Core__/graphics/intermediates/"..NAME..".png"
  return result
end

function DyTech_Core_Create_Intermediates_Recipe(NAME)
  local result =
  {
    type = "recipe",
    name = "hematite-processing",
    icon = "__MAIN-DyTech-Metallurgy__/graphics/chemicals/water.png",
    enabled = true,
    ingredients =
    {
    },
    result = "stone-brick"
  }
  result.name = NAME 
  result.result = NAME 
  result.icon = "__CORE-DyTech-Core__/graphics/intermediates/"..NAME..".png"
  return result
end

for index,name in pairs(INTERMEDIATES) do
	  data:extend(
		{
		  DyTech_Core_Create_Intermediates_Item(name.Name, name.Subgroup),
		})
	if name.Recipe then
	  data:extend(
		{
		  DyTech_Core_Create_Intermediates_Recipe(name.Name),
		})
		if data.raw.item["chalcopyrite-ore"] then
			for _,v in pairs(name.Recipe_Metallurgy) do
				table.insert(data.raw.recipe[name.Name].ingredients,v)
			end
		else
			for _,v in pairs(name.Recipe_Normal) do
				table.insert(data.raw.recipe[name.Name].ingredients,v)
			end
		end
		if name.Smelting then
			data.raw.recipe[name.Name].category = "smelting"
		end
	end
end

data.raw.recipe["track-chain-link"].result_count = 5
data.raw.recipe["sand"].result_count = 5
data.raw.recipe["bone-charcoal"].result_count = 5