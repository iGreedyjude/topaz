-----------------------------------------
-- Trust: Naji
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
require("scripts/globals/zone")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    local BastokFirstTrust = caster:getCharVar("BastokFirstTrust")
    local zone = caster:getZoneID()

    if BastokFirstTrust == 1 and (zone == tpz.zone.NORTH_GUSTABERG or zone == tpz.zone.SOUTH_GUSTABERG) then
        caster:setCharVar("BastokFirstTrust", 2)
    end

    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_GTE, 1000,
                        ai.r.WS, ai.s.SPECIFIC, tpz.ws.BURNING_BLADE)

    tpz.trust.synergyMessage(mob, {
        [900] = tpz.trust.message_offset.SYNERGY_1 -- Ayame
    })
end

function onMobDespawn(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DEATH)
end