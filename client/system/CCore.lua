--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 19.12.2014 - Time: 18:41
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CCore = inherit(CSingleton)        --Client Core

function CCore:constructor()
    self.managers = {}
    ---Manager Table: {"ManagerName", {arguments}}
end

function CCore:destructor()

end

function CCore:getManager(sName)
    return self[sName]
end

function CCore:loadManager()
    for _, v in ipairs(self.managers) do
        if (type(_G[v[1]]) == "table") then
            self[tostring(v[1])] = new(_G[v[1]], unpack(v[2]))
            debugOutput(("[CCore] Loading manager '%s'"):format(tostring(v[1])))
        else
            debugOutput(("[CCore] Couldn't find manager '%s'"):format(tostring(v[1])))
        end
    end
end

function CCore:startScript()
    outputChatBox("|GoJump| #ff8000Type /go to play MTAGoJump!", 255, 255, 255, true)

    addCommandHandler("go",
        function()
            if not self.GO then
                self.GO = new(GoJump)
                outputChatBox("|GoJump| #ff8000Press 'backspace' to close MTAGoJump!", 255, 255, 255, true)
            elseif not self.GO.state then
                self.GO = new(GoJump)
            end
        end
    )
end

--Create the Core Instance
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local s = getTickCount()
        debugOutput("[CCore] Start MTAGoJump")

        RPC = new(CRPC)
        Event = new(CEvent)
        Core = new(CCore)

        Core:loadManager()
        Core:startScript()

        debugOutput(("[CCore] Starting finished (%sms)"):format(getTickCount()-s))

        --triggerServerEvent("onClientResourceStarted", resourceRoot)
    end
)
