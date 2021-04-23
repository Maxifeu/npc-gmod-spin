AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("NPCROLL")
util.AddNetworkString("NPCUI")
util.AddNetworkString("resultatspin")

function ENT:Use(act, ply)
	if IsValid(ply) and ply:IsPlayer() then
		net.Start("NPCUI")
		net.Send(ply)
	end
end

function ENT:SpawnFunction(ply, tr, classname)
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create(classname)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	return ent
end

net.Receive("NPCROLL", function(len, ply)
    local magies = {"du Feu", "de la Glace", "de l'Air", "de l'Eau"} -- Edit Here what you want to spin

    local value = math.random(1,#magies)

	local picked_value = magies[value]
	net.Start("resultatspin")
      net.WriteString(picked_value)
    net.Send(ply)
end)