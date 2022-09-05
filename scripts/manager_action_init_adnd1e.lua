PC_LASTINIT = 0
NPC_LASTINIT = 0

OOB_MSGTYPE_APPLYINIT = "applyinit"

function onInit()
    ActionInit.getRoll = getRollNew
    ActionInit.handleApplyInit = handleApplyInitNew

    OOBManager.registerOOBMsgHandler(OOB_MSGTYPE_APPLYINIT, handleApplyInitNew)
end

-- initiative with modifiers, from item entry in ct or init button on character
-- function getRollNew(rActor, bSecretRoll, rItem)
--     local rRoll;
--     Debug.console("getRollNew");
--     rRoll = getRollNoMods(rActor, bSecretRoll, rItem);
--     Debug.console("ROLLNOMODS");
--     return rRoll;
-- end

-- initiative without modifiers, from item entry in ct or init button on character
function getRollNew(rActor, bSecretRoll, rItem)
    local rRoll = {}
    Debug.console("getRollNew")
    rRoll.sType = "init"
    rRoll.aDice = {"d" .. DataCommonADND.nDefaultInitiativeDice}

    rRoll.nMod = 0

    -- -- TODO, not necessary: Decide how to get init mod from rActor for at least zombies in OSRIC
    -- local sActorType, nodeActor = ActorManager.getTypeAndNode(rActor)
    -- Debug.console(nodeActor, sActorType)
    -- --Debug.console("manager_action_init.lua","getRoll","sActorType",sActorType);
    -- -- if nodeActor then
    -- --     if sActorType == "ct" then
    -- --         -- NPCs
    -- --         local nMod = DB.getValue(nodeActor, "initiative.total", 0)
    -- --         Debug.console(nMod)
    -- --         if nMod == 0 then
    -- --             nMod = DB.getValue(nodeActor, "init", 0)
    -- --             Debug.console(nMod)
    -- --         end

    -- --         Debug.console(nMod)
    -- --         rRoll.nMod = nMod
    -- --     end
    -- -- end
    -- --end of npc modding

    rRoll.sDesc = "[INIT]"
    rRoll.bSecret = bSecretRoll

    return rRoll
end

function handleApplyInitNew(msgOOB)
    local rSource = ActorManager.resolveActor(msgOOB.sSourceNode)
    local nTotal = tonumber(msgOOB.nTotal) or 0

    local bOsricInitiativeSwap = (OptionsManager.getOption("useOsricInitiativeSwap") == "on")

    -- grouped initiative options
    if ActorManager.isPC(rSource) then
        CombatManagerADND1e.applyInitResultToAllPCs(nTotal)
        PC_LASTINIT = nTotal
    elseif not ActorManager.isPC(rSource) then
        CombatManagerADND1e.applyInitResultToAllNPCs(nTotal)
        NPC_LASTINIT = nTotal
    end

    -- OSRIC initiative swap
    if bOsricInitiativeSwap then
        CombatManagerADND1e.applyInitResultToAllPCs(NPC_LASTINIT)
        CombatManagerADND1e.applyInitResultToAllNPCs(PC_LASTINIT)
    end
end
