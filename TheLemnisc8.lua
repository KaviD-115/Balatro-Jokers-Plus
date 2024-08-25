--- STEAMODDED HEADER

--- MOD_NAME: Balatro Jokers Plus
--- MOD_ID: TheLemnisc8
--- MOD_AUTHOR: [KaviD]
--- MOD_DESCRIPTION: Adds 6 Thematical Balatro Jokers
--- BADGE_COLOR: 191970
--- DISPLAY_NAME: Balatro Jokers Plus
--- VERSION: 1.0.0

SMODS.Atlas({ 
    key = "jokersplus",
    path = "jokersplus.PNG", 
    px = 71,
    py = 95,
})

SMODS.Joker{
  key = 'thelemnisc8',
  loc_txt = {
    name = 'The Lemnisc8',
    text = {
     "This Joker Gains {C:mult}+#3#{} Mult",
			"for each {C:attention}8{} scored",
			"and {C:chips}+#4#{} Chips for",
			"each {C:attention}8{} discarded",
			"{C:inactive}(Currently",
			"{C:mult}+#1#{C:inactive} Mult / {C:chips}+#2# {C:inactive}Chips)",
         }
    },
    rarity = 3,
    atlas = "jokersplus", pos = {x = 0, y = 0},
    cost = 8,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = false,
    config = {extra = {mult = 0, chips = 0, mult_gain = 1, chip_gain = 8}},
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.mult_gain, card.ability.extra.chip_gain}}
  end,
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if context.other_card:get_id() == 8 then
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
      return {
        card_eval_status_text(card,'extra',nil, nil, nil,{message = "Upgraded", colour = G.C.MULT, instant = true}),
        card = card
            }
        end
	elseif context.discard and
            not context.other_card.debuff then            
    if context.other_card:get_id() == 8 and not context.blueprint then
      card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
      return {
        message = 'Upgraded!',
        colour = G.C.CHIPS,
        delay = 0.45, 
        card = card
            }
          end
        end
      if context.joker_main then
	card_eval_status_text(card,'chips',card.ability.extra.chips, nil, nil)
        return {
          mult_mod = card.ability.extra.mult,
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}},
          chip_mod = card.ability.extra.chips,
      }
      end
    end
}
