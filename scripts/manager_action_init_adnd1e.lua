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
    Debug.console("getRollNoMods")
    rRoll.sType = "init"
    rRoll.aDice = {"d" .. DataCommonADND.nDefaultInitiativeDice}

    -- TODO: Decide how to get init mod from rActor for at least zombies in OSRIC
    rRoll.nMod = 0
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
