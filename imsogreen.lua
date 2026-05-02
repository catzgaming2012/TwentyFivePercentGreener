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
            green_mix = G.GAME and G.GAME.tfpg_current_green or 0.25
        }
    end
}
--#endregion

function TwentyFivePercentGreener.reset_game_globals(run_start)
    if run_start then
        G.GAME.tfpg_current_green = 0.25
    end
end