PC_LASTINIT = 0;
NPC_LASTINIT = 0;
OOB_MSGTYPE_APPLYINIT = "applyinit";

function onInit()
	getRollOrig = ActionInit.getRoll;
	ActionInit.getRoll = getRollNew;

    handleApplyInitOrig = ActionInit.handleApplyInit;
	ActionInit.handleApplyInit = handleApplyInitNew;

    OOBManager.registerOOBMsgHandler(OOB_MSGTYPE_APPLYINIT, handleApplyInitNew);
end

-- initiative with modifiers, from item entry in ct or init button on character
function getRollNew(rActor, bSecretRoll, rItem)
    local rRoll;
    Debug.console("getRollNew");
    rRoll = getRollNoMods(rActor, bSecretRoll, rItem);
    Debug.console("ROLLNOMODS");
    return rRoll;
end

-- initiative without modifiers, from item entry in ct or init button on character
function getRollNoMods(rActor, bSecretRoll, rItem)
    local rRoll = {};
    Debug.console("getRollNoMods");
    rRoll.sType = "init";
    rRoll.aDice = { "d" .. DataCommonADND.nDefaultInitiativeDice };

    -- TODO: Decide how to get init mod from rActor for at least zombies in OSRIC
    rRoll.nMod = 0;
    rRoll.sDesc = "[INIT]";
    rRoll.bSecret = bSecretRoll;

    return rRoll;
end

function handleApplyInitNew(msgOOB)
    local rSource = ActorManager.resolveActor(msgOOB.sSourceNode);
    local nTotal = tonumber(msgOOB.nTotal) or 0;

    --local bOptPCVNPCINIT = (OptionsManager.getOption("PCVNPCINIT") == 'on');
    local bOptInitGroupingSwap = (OptionsManager.getOption("initiativeOsricSwap") == 'on');

    -- grouped initiative options
    --if bOptPCVNPCINIT or (sOptInitGrouping ~= "neither") then
        
    
    
    
        -- TODO: handle some of these options that exist in 2e but don't make sense in 1e
        --if bOptPCVNPCINIT then --or sOptInitGrouping == "both") then
        
            if ActorManager.isPC(rSource) then
                CombatManagerADND1e.applyInitResultToAllPCs(nTotal);
                PC_LASTINIT = nTotal;
            elseif not ActorManager.isPC(rSource) then
                CombatManagerADND1e.applyInitResultToAllNPCs(nTotal);
                NPC_LASTINIT = nTotal;
            end
        -- elseif (sOptInitGrouping == "pc") then
        --     if ActorManager.isPC(rSource) then
        --         CombatManagerADND1e.applyInitResultToAllPCs(nTotal);
        --         PC_LASTINIT = nTotal;
        --     elseif not ActorManager.isPC(rSource) then
        --         CombatManagerADND1e.applyIndividualInit(nTotal, rSource);
        --         NPC_LASTINIT = nTotal;
        --     end
        -- elseif (sOptInitGrouping == "npc") then
        --     if not ActorManager.isPC(rSource) then
        --         CombatManagerADND1e.applyInitResultToAllNPCs(nTotal);
        --         NPC_LASTINIT = nTotal;
        --     elseif ActorManager.isPC(rSource) then
        --         CombatManagerADND1e.applyIndividualInit(nTotal, rSource);
        --         PC_LASTINIT = nTotal;
        --     end
        
    
    
    
        --end





    --else
        -- no group options set
        --CombatManagerADND1e.applyIndividualInit(nTotal, rSource);
--end

    -- if ties are turned off
    -- if not bOptInitTies then
    --     -- if a side's init has already been rolled
    --     if NPC_LASTINIT ~= 0 or PC_LASTINIT ~= 0 then
    --         -- if a PC rolled for initiative
    --         if ActorManager.isPC(rSource) then
    --             -- check for ties and correct
    --             -- this is to make sure we dont have same initiative
    --             -- give the benefit to players.
    --             if PC_LASTINIT == NPC_LASTINIT then
    --                 -- don't want init = 0
    --                 -- standard tiebreaker, without swapping
    --                 if not bOptInitGroupingSwap then
    --                     if NPC_LASTINIT ~= 1 then
    --                         nInitResult = NPC_LASTINIT - 1;
    --                         CombatManagerADND1e.applyInitResultToAllPCs(nInitResult);
    --                         PC_LASTINIT = nInitResult;
    --                     else
    --                         nInitResult = PC_LASTINIT + 1;
    --                         CombatManagerADND1e.applyInitResultToAllNPCs(nInitResult);
    --                         NPC_LASTINIT = nInitResult;
    --                     end
    --                 else
    --                 -- do the reverse so that pcs still have the advantage
    --                     if PC_LASTINIT ~= 1 then
    --                         nInitResult = PC_LASTINIT - 1;
    --                         CombatManagerADND1e.applyInitResultToAllNPCs(nInitResult);
    --                         NPC_LASTINIT = nInitResult;
    --                     else
    --                         nInitResult = NPC_LASTINIT + 1;
    --                         CombatManagerADND1e.applyInitResultToAllPCs(nInitResult);
    --                         PC_LASTINIT = nInitResult;
    --                     end
    --                 end
    --                 -- don't want inits > 6
    --                 if PC_LASTINIT > 6 or NPC_LASTINIT > 6 then
    --                     -- subtract 1 from each group's init
    --                     PC_LASTINIT = PC_LASTINIT - 1;
    --                     NPC_LASTINIT = NPC_LASTINIT - 1;
    --                     -- re-apply all inits
    --                     CombatManagerADND1e.applyInitResultToAllPCs(PC_LASTINIT);
    --                     CombatManagerADND1e.applyInitResultToAllNPCs(NPC_LASTINIT);
    --                 end
    --             end
    --         -- if an npc rolled for initiative
    --         else
    --             -- check for ties and correct
    --             -- this is to make sure we dont have same initiative
    --             -- give the benefit to players.
    --             if NPC_LASTINIT == PC_LASTINIT then
    --                 -- standard tiebreaker, without swapping
    --                 if not bOptInitGroupingSwap then
    --                     nInitResult = PC_LASTINIT + 1;
    --                     CombatManagerADND1e.applyInitResultToAllNPCs(nInitResult);
    --                     NPC_LASTINIT = nInitResult;
    --                 else
    --                 -- do the reverse so that pcs still have the advantage
    --                     nInitResult = NPC_LASTINIT + 1;
    --                     CombatManagerADND1e.applyInitResultToAllPCs(nInitResult);
    --                     PC_LASTINIT = nInitResult;
    --                 end
    --             end
    --             -- don't want inits > 6
    --             if PC_LASTINIT > 6 or NPC_LASTINIT > 6 then
    --                 -- subtract 1 from each group's init
    --                 PC_LASTINIT = PC_LASTINIT - 1;
    --                 NPC_LASTINIT = NPC_LASTINIT - 1;
    --                 -- re-apply all inits
    --                 CombatManagerADND1e.applyInitResultToAllPCs(PC_LASTINIT);
    --                 CombatManagerADND1e.applyInitResultToAllNPCs(NPC_LASTINIT);
    --             end
    --         end
    --     end
    -- end

    -- init grouping swap
    if bOptInitGroupingSwap then
        --if bOptPCVNPCINIT or (sOptInitGrouping ~= "neither") then
            CombatManagerADND1e.applyInitResultToAllPCs(NPC_LASTINIT);
            CombatManagerADND1e.applyInitResultToAllNPCs(PC_LASTINIT);
        --end
    end
end