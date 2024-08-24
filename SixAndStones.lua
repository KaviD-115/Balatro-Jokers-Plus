--- STEAMODDED HEADER

--- MOD_NAME: Balatro Jokers Plus
--- MOD_ID: SixAndStones
--- MOD_AUTHOR: [KaviD]
--- MOD_DESCRIPTION: Adds 6 Thematical Balatro Jokers
--- BADGE_COLOR: 191970
--- DISPLAY_NAME: Balatro Jokers Plus
--- VERSION: 1.0.0

SMODS.Atlas({ 
    key = "jokersplus",
    path = "jokersplus.png", 
    px = 71,
    py = 95,
})

SMODS.Joker{
  key = "sixandstones",
  loc_txt = {
    name = 'Six and Stones',
    text = {
            'Each played {C:attention}6{} or {C:attention}Stone Card{}',
            'gives {C:mult}+6{} Mult when scored',
        }
    },
    rarity = 1,
    atlas = "jokersplus", pos = {x = 1, y = 0},
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = true,
    config = {extra = 6},
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 6 or context.other_card.ability.name == 'Stone Card' then
              return {
                    mult = card.ability.extra,
                    card = card,
                }
            end
        end
    end,
}