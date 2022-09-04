function onInit()
    Debug.console("manager_actor_adnd1e.lua", "init")
    ActorHealthManager.getWoundPercent = getWoundPercentNew
end

function getWoundPercentNew(rActor)
    Debug.console("manager_actor_adnd1e.lua", "getWoundPercentNew")
    -- local rActor = ActorManager.resolveActor(node);
    -- local node = ActorManager.getCreatureNode(rActor);
    local sNodeType, node = ActorManager.getTypeAndNode(rActor)
    local nHP = 0
    local nWounds = 0

    -- Debug.console("manager_actor_adnd.lua","getWoundPercent","sNodeType",sNodeType);
    if sNodeType == "pc" then
        nHP = math.max(DB.getValue(node, "hp.total", 0), 0)
        nWounds = math.max(DB.getValue(node, "hp.wounds", 0), 0)
    elseif sNodeType == "ct" then
        nHP = math.max(DB.getValue(node, "hptotal", 0), 0)
        nWounds = math.max(DB.getValue(node, "wounds", 0), 0)
    end

    local nPercentWounded = 0

    if nHP > 0 then
        nPercentWounded = nWounds / nHP
    end

    --local bDeathsDoor = OptionsManager.isOption("HouseRule_DeathsDoor", "on"); -- using deaths door aD&D rule

    local sStatus = ActorHealthManager.STATUS_HEALTHY
    local nLeftOverHP = (nHP - nWounds)

    -- AD&D goes to -10 then dead with deaths door
    --local nDEAD_AT = -10;

    -- force death's door
    -- if not bDeathsDoor then
    --     nDEAD_AT = 0;
    -- end

    --if sTargetType == "pc" then
    -- ^^ was PC

    --end

    if nPercentWounded >= 1 then
        -- had to remove the hasEffect() checks as it caused a recursive loop with
        -- the new Aura system
        --if nLeftOverHP <= nDEAD_AT or EffectManager5E.hasEffect(rActor, "Dead") then

        -- changing death's door options, since it always exists in 1e
        local nDeathDoorThreshold = 0
        local nDEAD_AT = -10

        local sOptHouseRuleDeathsDoor = OptionsManager.getOption("HouseRule_DeathsDoor")

        if sOptHouseRuleDeathsDoor == "exactlyZero" then
            nDeathDoorThreshold = 0
        elseif sOptHouseRuleDeathsDoor == "zeroToMinusThree" then
            nDeathDoorThreshold = -3
        else
            -- minus 9 because -10 = dead
            nDeathDoorThreshold = -9
        end

        --local nDeathValue = (nTotalHP - nWounds) - nRemainder;

        -- still has hp
        -- if nWounds < nHP then
        --     -- 0 or lower hp
        --     if EffectManager5E.hasEffect(rTarget, "Stable") then
        --         EffectManager.removeEffect(ActorManager.getCTNode(rTarget), "Stable")
        --     end

        --     -- check for optional AD&D deaths door rule (0 to -10) ? --celestian
        --     if EffectManager5E.hasEffect(rTarget, "Unconscious") then
        --         EffectManager.removeEffect(ActorManager.getCTNode(rTarget), "Unconscious")
        --     end

        --     if EffectManager5E.hasEffect(rTarget, "Dead") then
        --         EffectManager.removeEffect(ActorManager.getCTNode(rTarget), "Dead")
        --     end
        -- elseif nWounds >= nTotalHP then
        --     -- dead
        --     local nHitPointValue = nTotalHP - nWounds

        --     -- equal to or higher than death's door threshold
        --     if nHitPointValue >= nDeathDoorThreshold then
        --         -- dead
        --         EffectManager.addEffect(
        --             "",
        --             "",
        --             ActorManager.getCTNode(rTarget),
        --             {sName = "Unconscious;DMGO:1", sLabel = "Unconscious;DMGO:1", nDuration = 0},
        --             true
        --         )
        --     else
        --         EffectManager.addEffect("", "", ActorManager.getCTNode(rTarget), {sName = "Dead", nDuration = 0}, true)
        --     end
        -- else
        --     EffectManager.addEffect("", "", ActorManager.getCTNode(rTarget), {sName = "Dead", nDuration = 0}, true)
        -- end

        Debug.console("manager_actor_adnd1e.lua 105", nLeftOverHP)

        -- if nLeftOverHP >= nDeathDoorThreshold then
        --     --    elseif EffectManager5E.hasEffect(rActor, "Stable") then
        --     --      sStatus = "Unconscious";
        --     sStatus = ActorHealthManager.STATUS_DYING;
        -- elseif nLeftOverHP <= nDEAD_AT then
        --     sStatus = ActorHealthManager.STATUS_DEAD;
        -- end

        if nLeftOverHP <= nDEAD_AT then
            sStatus = ActorHealthManager.STATUS_DEAD
        end

        if nLeftOverHP < 1 then
            sStatus = sStatus .. " (" .. nLeftOverHP .. ")"
        end
    elseif OptionsManager.isOption("WNDC", "detailed") then
        if nPercentWounded >= .75 then
            sStatus = ActorHealthManager.STATUS_CRITICAL
        elseif nPercentWounded >= .5 then
            sStatus = ActorHealthManager.STATUS_HEAVY
        elseif nPercentWounded >= .25 then
            sStatus = ActorHealthManager.STATUS_MODERATE
        elseif nPercentWounded > 0 then
            sStatus = ActorHealthManager.STATUS_LIGHT
        else
            sStatus = ActorHealthManager.STATUS_HEALTHY
        end
    else
        if nPercentWounded >= .5 then
            sStatus = ActorHealthManager.STATUS_SIMPLE_HEAVY
        elseif nPercentWounded > 0 then
            sStatus = ActorHealthManager.STATUS_SIMPLE_WOUNDED
        else
            sStatus = ActorHealthManager.STATUS_HEALTHY
        end
    end

    return nPercentWounded, sStatus
end
