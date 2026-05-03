return {
    descriptions = {
        Voucher = {
            v_tfpg_green_gaster = {
                name = "Green Gaster",
                text = {
                    "Makes the game {X:tfpg_00ff00,C:white}X#1#{} more green"
                }
            }
        },
        Joker = {
            j_tfpg_the_guy_from_that_meme_lathering_green_all_over_him = {
                name = ("I'm so {C:tfpg_00ff00%s}G R E E N"):format(PassiveChaos and ",E:pc_wave" or ""),
                text = {
                    "{C:mult}+#1#{} mult for each {X:tfpg_00ff00,C:white}#2#%{C:tfpg_00ff00} of green",
                    "{C:inactive,s:0.9}(Currently {C:mult,s:0.9}+#3#{C:inactive,s:0.9} mult)"
                }
            }
        }
    }
}