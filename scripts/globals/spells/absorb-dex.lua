--------------------------------------
--     Spell: Absorb-DEX
--     Steals an enemy's dexterity.
--------------------------------------
 
require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0;
end;

function onSpellCast(caster,target,spell)
    
    if (target:hasStatusEffect(EFFECT_DEX_DOWN) or caster:hasStatusEffect(EFFECT_DEX_BOOST)) then
        spell:setMsg(75); -- no effect
    else        
        local dINT = caster:getStat(MOD_INT) - target:getStat(MOD_INT);
        local params = {};
        params.diff = nil;
        params.attribute = MOD_INT;
        params.skillType = 37;
        params.bonus = 0;
        params.effect = nil;
        resist = applyResistance(caster, target, spell, params);
        if (resist <= 0.125) then
            spell:setMsg(85);
        else
            spell:setMsg(330);
            caster:addStatusEffect(EFFECT_DEX_BOOST,ABSORB_SPELL_AMOUNT*resist*((100+(caster:getMod(MOD_AUGMENTS_ABSORB)))/100), ABSORB_SPELL_TICK, ABSORB_SPELL_AMOUNT*ABSORB_SPELL_TICK,FLAG_DISPELABLE); -- caster gains DEX
            target:addStatusEffect(EFFECT_DEX_DOWN,ABSORB_SPELL_AMOUNT*resist*((100+(caster:getMod(MOD_AUGMENTS_ABSORB)))/100), ABSORB_SPELL_TICK, ABSORB_SPELL_AMOUNT*ABSORB_SPELL_TICK,FLAG_ERASABLE);    -- target loses DEX
        end
    end
    return EFFECT_DEX_DOWN;
end;