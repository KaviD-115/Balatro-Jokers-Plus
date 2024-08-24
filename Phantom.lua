--- STEAMODDED HEADER

--- MOD_NAME: Balatro Jokers Plus
--- MOD_ID: Phantom
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
  key = 'phantom',
  loc_txt = {
    name = 'Phantom',
    text = {
     "This Joker Gains {X:mult,C:white}X#1#{} Mult",
			"per {C:spectral}Spectral{} card used, resets",
                        "if any {C:spectral}Spectral Pack{} is {C:attention}skipped{}",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
         }
    },
    rarity = 2,
    atlas = "jokersplus", pos = {x = 2, y = 0},
    cost = 7,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = true,
    config = {extra = {Xmult_add = 1, Xmult = 1}},
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult_add, card.ability.extra.Xmult}}
  end,
    calculate = function(self, card, context)
      if context.using_consumeable and not context.blueprint then
                if context.consumeable.ability.set == "Spectral" then
               card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_add
               G.E_MANAGER:add_event(Event({
                func = function()
                  card:juice_up(0.7)
                  card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgraded", colour = G.C.MULT, instant = true})
          return true; end}))
      end
                end
      if context.skipping_booster and not context.blueprint and G.STATE == G.STATES.SPECTRAL_PACK then
                  card.ability.extra.Xmult = 1
                  G.E_MANAGER:add_event(Event({
                func = function()
                  card:juice_up(0.7)
                  card_eval_status_text(card,'extra',nil, nil, nil,{message = "Reset", colour = G.C.ORANGE, instant = true})
          return true; end}))
      end
      if context.joker_main and card.ability.extra.Xmult > 1 then
        return {
          message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
          Xmult_mod = card.ability.extra.Xmult,
        }
      end
    end
}