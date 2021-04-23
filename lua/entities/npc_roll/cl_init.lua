include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

local function OpenNPCUI()
	local scrw, scrh = ScrW(), ScrH()

    local npcuimg = vgui.Create("DFrame")
    npcuimg:SetPos(scrw * .3, scrh * .2)
    npcuimg:SetSize(200, 200)
    npcuimg:SetTitle("")
    npcuimg:ShowCloseButton(false)
    function npcuimg:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
    end
    npcuimg:MakePopup()

    local npcuimgclose = vgui.Create("DImageButton", npcuimg)
    npcuimgclose:SetPos(170, 10)
    npcuimgclose:SetSize(20, 20)
    npcuimgclose:SetImage("icon16/cross.png")
    npcuimgclose.DoClick = function()
        npcuimg:Close()
    end

    local npcuimgnom = vgui.Create("DLabel", npcuimg)
    npcuimgnom:SetPos(10, 10)
    npcuimgnom:SetSize(180, 20)
    npcuimgnom:SetText("Spin Magie")

    local npcuirollbutt = vgui.Create("DButton", npcuimg)
    npcuirollbutt:SetPos(50, 100)
    npcuirollbutt:SetSize(100, 30)
    npcuirollbutt:SetText("Spin")
    npcuirollbutt.DoClick = function()
    end

    function npcuirollbutt:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(250, 250, 250))
        draw.RoundedBox(0, 1, 1, w-2, h-2, Color(200, 200, 200))
    end

    npcuirollbutt.DoClick = function()
        net.Start("NPCROLL")
        net.SendToServer()
        LocalPlayer():ChatPrint("Vous avez spin votre magie !") -- Modify the Chat message you receive once you pushed the spin button
    end
end

net.Receive("NPCUI", OpenNPCUI)