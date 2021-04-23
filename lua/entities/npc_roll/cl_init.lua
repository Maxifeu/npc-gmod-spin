include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

local function OpenNPCUI()
	local scrw, scrh = ScrW(), ScrH()

    local npcuimg = vgui.Create("DFrame")
    npcuimg:SetPos(scrw * .3, scrh * .2)
    npcuimg:SetSize(400, 200)
    npcuimg:SetTitle("")
    npcuimg:Center()
    npcuimg:ShowCloseButton(false)
    npcuimg:MakePopup()
    function npcuimg:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
    end

    local npcuimgclose = vgui.Create("DImageButton", npcuimg)
    npcuimgclose:SetPos(370, 10)
    npcuimgclose:SetSize(20, 20)
    npcuimgclose:SetImage("icon16/cross.png")
    npcuimgclose.DoClick = function()
        npcuimg:Close()
    end

    local npcuimgnom = vgui.Create("DLabel", npcuimg)
    npcuimgnom:SetPos(178, 10)
    npcuimgnom:SetSize(200, 20)
    npcuimgnom:SetText("Spin Magie")

    local npcuirollbutt = vgui.Create("DButton", npcuimg)
    npcuirollbutt:SetPos(150, 100)
    npcuirollbutt:SetSize(100, 30)
    npcuirollbutt:SetText("Spin")
    function npcuirollbutt:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(250, 250, 250))
        draw.RoundedBox(0, 1, 1, w-2, h-2, Color(200, 200, 200))
    end 
    npcuirollbutt.DoClick = function()
        net.Start("NPCROLL")
        net.SendToServer()
        LocalPlayer():ChatPrint("Vous avez spin votre magie !") -- Modify the Chat message you receive once you pushed the spin button
        npcuimg:Close()
    end
end

local function ResultatSpin(argument)
    local resspin = vgui.Create("DFrame")
    resspin:SetSize(400, 200)
    resspin:Center()
    resspin:SetTitle("")
    resspin:MakePopup()
    resspin:ShowCloseButton(false)

    local npcuirollspinres = vgui.Create("DLabel", resspin)
    npcuirollspinres:SetPos(125, 75)
    npcuirollspinres:SetSize(300, 30)
    npcuirollspinres:SetText("Vous contrôlez la magie " .. argument .. ".")

    function resspin:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(100, 100, 100))
        draw.RoundedBox(0, 0, 0, w, 40, Color(50, 50, 50))
    end
    local resspinname = vgui.Create("DLabel", resspin)
    resspinname:SetPos(178, 10)
    resspinname:SetSize(200, 20)
    resspinname:SetText("Spin Magie")

    local resspinclose = vgui.Create("DImageButton", resspin)
    resspinclose:SetPos(370, 10)
    resspinclose:SetSize(20, 20)
    resspinclose:SetImage("icon16/cross.png")
    resspinclose.DoClick = function()
        resspin:Close()
    end
end

net.Receive("resultatspin", function()
    local picked_value = net.ReadString()
    ResultatSpin(picked_value)
end )
net.Receive("NPCUI", OpenNPCUI)