require "defines"
require "util"

--[[TODO:
	Proper localisation
]]--

--Don't mind me:
--/c game.player.insert{name="nuclear-reactor",count=1}
	
--[[Debug Functions]]--
debug_master = true -- Master switch for debugging, shows most things!

function debug(str)
	if debug_master then
		for _,player in pairs(game.players) do
			player.print(str)
		end
	end
end

function datablock(str, strname)
	if debug_master then
		game.makefile("DataDump/"..strname..".txt", serpent.block(str))
		debug("Made serpent.block file: "..strname)
	end
end

function datadump(str, strname)
	if debug_master then
		game.makefile("DataDump/block "..strname..".txt", serpent.dump(str))
		debug("Made serpent.dump file: "..strname)
	end
end

game.oninit(function()
glob.tick = {}
glob.tick[1] = 0
glob.usedFuel = {}
glob.entitypos = {}
glob.entityinfo = {}
glob.entitycount = 0
end)

--[[Insert Fancy Code Here:]]--

--[[glob.entityinfo[1] = nuclear-reactor-container = {}
nuclear-reactor-container[1] = false]]--

--[[game.onevent(defines.events.onputitem, function(event)
--Saving the coordinates of the placed entity
	glob.entitypos[1] = event.position.x-2 --Left Top
	glob.entitypos[2] = event.position.y+2
	
	glob.entitypos[4] = event.position.x+2 --Right Bottom
	glob.entitypos[5] = event.position.y-2
	
	glob.entitypos[6] = event.position.x-3
	glob.entitypos[7] = event.position.y
end)]]--

--[[Reactor Code]]--

game.onevent(defines.events.onbuiltentity, function(event)

	if event.createdentity.name == "nuclear-reactor" then
	
	--Saving the coordinates of the placed entity
	glob.entitycount = glob.entitycount + 1
	glob.entityinfo[glob.entitycount] = {}
	glob.entityinfo[glob.entitycount].TopLeft = event.createdentity.position.x-2
	glob.entityinfo[glob.entitycount].TopRight = event.createdentity.position.x+2
	
	glob.entityinfo[glob.entitycount].BottomLeft = event.createdentity.position.y-2
	glob.entityinfo[glob.entitycount].BottomRight = event.createdentity.position.y+2
	
	glob.entityinfo[glob.entitycount].MiddleLeft = event.createdentity.position.x-3
	glob.entityinfo[glob.entitycount].Yaxis = event.createdentity.position.y
	
	
		glob.entityinfo[glob.entitycount].Name = event.createdentity
--[[		builtentityinfo = event.createdentity
		table.insert(glob.entityinfo, builtentityinfo)
		datadump(glob.entityinfo, "entityinfo1")]]--
		event.createdentity.operable = false
		if (game.canplaceentity{name = "nuclear-reactor-container", position = {glob.entityinfo[glob.entitycount].MiddleLeft, glob.entityinfo[glob.entitycount].Yaxis}}) then
			game.createentity{name = "nuclear-reactor-container", position = {glob.entityinfo[glob.entitycount].MiddleLeft, glob.entityinfo[glob.entitycount].Yaxis}, force=game.forces.player}
				debug("Entity Found!")
				glob.entityinfo[glob.entitycount].ContainerFound = game.findentitiesfiltered{area = {{(glob.entityinfo[glob.entitycount].MiddleLeft-10), (glob.entityinfo[glob.entitycount].Yaxis-10)}, {(glob.entityinfo[glob.entitycount].MiddleLeft+10), (glob.entityinfo[glob.entitycount].Yaxis+10)}}, name = "nuclear-reactor-container"}
				datadump(glob.entityinfo[glob.entitycount], "Placed-Entity")
		else
			for i,player in ipairs(game.players) do
				player.print("The nuclear reactor couldn't be placed. Please make sure the complete 6x6 area is clear, and you place the reactor in the middle.")
				game.players[i].insert({name = "nuclear-reactor", count = 1})
			end
			glob.entityinfo[glob.entitycount].Name.destroy()
		end
	end
	
--[[if event.createdentity.name == "nuclear-reactor-container" then
		glob.entityinfo[2] = event.createdentity.getinventory(1)
		datadump(glob.entityinfo)
	end]]--
end)

--[[game.onevent(defines.events.onguiclick, function(event)
	if event.guielement.name = "nuclear-reactor-container" then
		nuclear-reactor-container[1] = true
	end
end)]]--

game.onevent(defines.events.ontick, function(event)
	if glob.tick[1] == 590 then
		moveFuel()
		calcEnergy()
		glob.tick[1] = 0
	else
		glob.tick[1] = glob.tick[1] + 1
	end
end)

function moveFuel()
	if glob.entityinfo[2] ~= nil then
		if glob.entityinfo[1].valid and glob.entityinfo[2].valid --[[and glob.entityinfo[2].name == "nuclear-reactor-container"]] then
			debug("It works!")
		else
			debug("Not valid")
		end
	--[[datadump(glob.entityinfo[2], "glob.entityinfo[2]")
	glob.entityinfo[8] = glob.entityinfo[2].getinventory(1)
	datadump(glob.entityinfo[8], "glob.entityinfo[8]")
		if glob.entityinfo[8].isempty() == false then
			debug("Ur a smartass u MagicLegend")
				glob.entityinfo[5] = glob.entityinfo[2].getinventory(1).getcontents()
			datadump(glob.entityinfo[5], "glob.entityinfo[5]")
				glob.usedFuel[1] = glob.entityinfo[2].getinventory(1).getcontents()
			debug("The usedFuel variable contains: "..usedFuel[1])
				glob.entityinfo[2].removeitem(1)
		end]]--
	else
	debug("glob.entityinfo[2] = nil")
	end
end

function calcEnergy()
	if glob.usedFuel[1] ~= nil then
		if glob.usedFuel[1] == "Plutonium" then
			debug("Plutonium all the way!")
		elseif glob.usedFuel[1] == "Uranium" then
			debug("Uranium is your friend!")
		else
			debug("I have no idea what that is... But it doesn't look like something burnable in a reactor!")
			game.player.insert({name=glob.usedFuel[1],count=1})
		end
	else
		debug("No fuel")
	end
end

--Don't mind me:
--/c game.player.insert{name="nuclear-reactor",count=1}