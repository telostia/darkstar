-----------------------------------------
-- Spell: Gravity
-----------------------------------------

require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0;
end;

function onSpellCast(caster,target,spell)

    -- Pull base stats.
    local dINT = (caster:getStat(MOD_INT) - target:getStat(MOD_INT));
    local power = 50; -- 50% reduction

    -- Duration, including resistance.  Unconfirmed.
    local duration = 120;
    local params = {};
    params.diff = nil;
    params.attribute = MOD_INT;
    params.skillType = 35;
    params.bonus = 0;
    params.effect = EFFECT_WEIGHT;
    duration = duration * applyResistanceEffect(caster, target, spell, params);

    if (duration >= 30) then --Do it!
    
        if (caster:hasStatusEffect(EFFECT_SABOTEUR)) then
        duration = duration * 2;
    end
    caster:delStatusEffect(EFFECT_SABOTEUR);
    
        if (target:addStatusEffect(EFFECT_WEIGHT,power,0,duration)) then
            spell:setMsg(236);
        else
            spell:setMsg(75);
        end
    else
        spell:setMsg(284);
    end

    return EFFECT_WEIGHT;
end;