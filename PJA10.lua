--- STEAMODDED HEADER

--- MOD_NAME: Balatro Jokers Plus
--- MOD_ID: PJATen
--- MOD_AUTHOR: [KaviD]
--- MOD_DESCRIPTION: Custom Joker
--- BADGE_COLOR: 191970
--- DISPLAY_NAME: Balatro Jokers Plus
--- VERSION: 1.0.0

SMODS.Atlas({ 
    key = "jokersplus2",
    path = "jokersplus2.png", 
    px = 81,
    py = 137,
})

SMODS.Joker{
  key = 'pjaten',
  loc_txt = {
    name = 'PJA 10',
    text = {
     "{C:green}#1# in #2#{} chance to create",
			"an {C:spectral}Aura{} card when any",
			"{C:attention}Booster Pack{} is opened",
                        "{C:inactive}(Must have room)"
         }
    },
    rarity = 3,
    atlas = "jokersplus2", pos = {x = 1, y = 0},
    cost = 10,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = false,
    perishable_compat = true,
    config = {extra = 3},
    -- Sets the sprite and hitbox
    set_ability = function(self, card, initial, delay_sprites)
        local w_scale, h_scale = 81/71, 137/95

        card.T.h = card.T.h * h_scale
        card.T.w = card.T.w * w_scale
    end,

    set_sprites = function(self, card, front)
        local w_scale, h_scale = 71/71, 95/95

        card.children.center.scale.y = card.children.center.scale.y * h_scale
        card.children.center.scale.x = card.children.center.scale.x * w_scale
    end,

    load = function(self, card, card_table, other_card)
        local w_scale, h_scale = 81/71, 137/95
        
        card.T.h = card.T.h * h_scale
        card.T.w = card.T.w * w_scale
    end,

    loc_vars = function(self, info_queue, card)
    return {vars = {G.GAME.probabilities.normal,card.ability.extra}}
  end,
    calculate = function(self, card, context)
      if context.open_booster and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        if pseudorandom('PJA') < G.GAME.probabilities.normal/card.ability.extra then
          return {
          G.E_MANAGER:add_event(Event({
                        func = function() 
                            local c = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_aura', 'sup')
                            c:add_to_deck()
                            G.consumeables:emplace(c)
                            return true 
                        end})) 
                }         
            end
        end
    end,
}