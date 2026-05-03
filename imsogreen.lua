TwentyFivePercentGreener = SMODS.current_mod

--#region The shader itself

SMODS.ScreenShader {
    key = "green",
    path = "green.fs",
    order = math.huge,
    should_apply = function(self)
        return true
    end,
    send_vars = function(self)
        return {
            green_mix = TwentyFivePercentGreener.green_mix
        }
    end
}

--#endregion

--#region Mod Methods

function TwentyFivePercentGreener.reset_game_globals(run_start)
    if run_start then
        G.GAME.tfpg_target_green_mix = 0.25
    end
end

--#endregion

--#region Register Atli

SMODS.Atlas {
    key = "vouchers",
    px = 71,
    py = 95,
    path = "Vouchers.png"
}

SMODS.Atlas {
    key = "jokers",
    px = 71,
    py = 95,
    path = "Jokers.png"
}

--#endregion

--#region Register Objects

SMODS.Sound {
    key = "green",
    path = "green.ogg",
    replace = "magic_crumple3"
}

SMODS.Joker {
    key = "the_guy_from_that_meme_lathering_green_all_over_him",
    atlas = "jokers",
    pos = {x = 0, y = 0},
    rarity = 2,
    cost = 6,
    discovered = true,
    config = {
        extra = {
            gpm = 0.25,
            mpgpm = 1.5
        }
    },
    loc_vars = function(self, info_queue, card)
        local green = G.GAME and G.GAME.tfpg_target_green_mix or 0.25
        return {
            vars = {
                card.ability.extra.mpgpm,
                card.ability.extra.gpm*100,
                green / card.ability.extra.gpm * card.ability.extra.mpgpm
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local green = G.GAME and G.GAME.tfpg_target_green_mix or 0.25
            return {
                mult = green / card.ability.extra.gpm * card.ability.extra.mpgpm
            }
        end
    end
}

SMODS.Voucher {
    key = "green_gaster",
    atlas = "vouchers",
    pos = {x = 0, y = 0},
    soul_pos = {x = 0, y = 1},
    discovered = false,
    cost = 7,
    config = {
        extra = {
            green_mult = 2
        }
    },
    loc_vars = function(self, info_queue, voucher)
        return {
            vars = {
                voucher.ability.extra.green_mult
            }
        }
    end,
    redeem = function(self, voucher)
        G.GAME.tfpg_target_green_mix = G.GAME.tfpg_target_green_mix * voucher.ability.extra.green_mult

        G.E_MANAGER:add_event(Event({
            func = function()
                voucher:juice_up(0.5, 0.3)
                play_sound("negative", 0.75)
                return true
            end
        }))
    end
}

--#endregion

--#region Overrides and hooks

local iwantgreen = loc_colour
function loc_colour(...)
    if not G.ARGS.LOC_COLOURS then
        iwantgreen()
    end

    G.ARGS.LOC_COLOURS.tfpg_00ff00 = HEX("00FF00")

    return iwantgreen(...)
end

local update = Game.update
function Game:update(dt, ...)
    update(self, dt, ...)
    TwentyFivePercentGreener.green_mix = (TwentyFivePercentGreener.green_mix or 0.25)*(1 - dt) + dt*(G.GAME and G.GAME.tfpg_target_green_mix or 0.25)
end

--#endregion