--- STEAMODDED HEADER

--- MOD_NAME: Balatro Jokers Plus
--- MOD_ID: Interstellar
--- MOD_AUTHOR: [KaviD]
--- MOD_DESCRIPTION: Custom Joker
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
  key = 'interstellar',
  loc_txt = {
    name = 'Interstellar',
    text = {
     '{C:green}#1# in #2#{} chance for each',
     'played {C:attention}7{} to create a {C:dark_edition}Negative{}',
     '{C:planet}Planet{} card when scored'
        }
    },
    rarity = 2,
    atlas = "jokersplus", pos = {x = 3, y = 0},
    cost = 7,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = true,
    config = {extra = 4},
    loc_vars = function(self, info_queue, card)
    return {vars = {G.GAME.probabilities.normal,card.ability.extra,}}
  end,
    calculate = function(self, card, context)
                    if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 7 then
        if pseudorandom('SoaringSevens') < G.GAME.probabilities.normal/card.ability.extra then
         G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                local card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, '8ba')
                                card:set_edition('e_negative', true)
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)
                        }))
                        return {
                            message = localize('k_plus_planet'),
                            colour = G.C.SECONDARY_SET.Planet,
                            card = card
                               }
                  end
             end
        end
   end,
}