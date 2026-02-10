--- STEAMODDED HEADER
--- MOD_NAME: Balatro Jokers PLUS
--- MOD_ID: BalatroJokersPLUS
--- MOD_AUTHOR: [KaviD]
--- MOD_DESCRIPTION: Adds Vanilla-esque Jokers and Crossover Jokers from other Game Series
--- BADGE_COLOR: 465F85
--- DISPLAY_NAME: Balatro Jokers PLUS
--- VERSION: 1.9.1
--- PREFIX: PlusJokers

SMODS.Atlas({
    key = "modicon",
    path = "BJPlusModIcon.png",
    px = 32,
    py = 32
})

-- Registers the atlas for Jokers
SMODS.Atlas({ 
    key = "jokersplus",
    path = "jokersplus.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({ 
    key = "jokersplus2",
    path = "jokersplus2.png", 
    px = 81,
    py = 137,
})

SMODS.Atlas({ 
    key = "jokersplusupdatepack1",
    path = "jokersplusupdatepack1.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({ 
    key = "jokersplusupdatepack2",
    path = "jokersplusupdatepack2.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({ 
    key = "jokersplusupdatepack3",
    path = "jokersplusupdatepack3.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({ 
    key = "jokersplusupdatepack4",
    path = "jokersplusupdatepack4.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({ 
    key = "rupeesjoker",
    path = "RupeesJoker.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({ 
    key = "pacmanjoker",
    path = "PacManJokerArt.png", 
    px = 71,
    py = 95,
})

SMODS.Atlas({ 
    key = "soaringsevensjoker",
    path = "Soaring7sJokerArt.png", 
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
    perishable_compat = false,
    config = {extra = {Xmult_add = 0.75, Xmult = 1}},
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

SMODS.Joker{
  key = 'soaringsevens',
  loc_txt = {
    name = 'Soaring Sevens',
    text = {
     'Each played {C:attention}7{} has a {C:green}#1# in #3#{} chance',
     'to create a {C:planet}Planet{} card',
     'and a {C:green}#2# in #4#{} chance to create a',
     '{C:dark_edition}Negative{} {C:spectral}Black Hole{} when scored',        
        }
    },
    rarity = 1,
    atlas = "soaringsevensjoker", pos = {x = 0, y = 0},
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = true,
    config = { extra = { planet_odds = 4, blackhole_odds = 15} },
    loc_vars = function(self, info_queue, card)
        local planet_numerator, planet_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.planet_odds, 'interstellar_planet')
        local blackhole_numerator, blackhole_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.blackhole_odds, 'interstellar_blackhole')
        return { vars = { planet_numerator, blackhole_numerator, planet_denominator, blackhole_denominator, } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 7) then
                   if SMODS.pseudorandom_probability(card, 'interstellar_planet', 1, card.ability.extra.planet_odds) then
                     if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
           G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          G.E_MANAGER:add_event(Event({    
                            trigger = "after",
                            delay = 0.25,
                            func = (function()
                            SMODS.add_card {
                                        set = 'Planet',}
                            SMODS.calculate_effect({message = '+1 Planet', colour = G.C.SECONDARY_SET.Planet,  instant = true}, card)
                            G.GAME.consumeable_buffer = 0
                            return true
                            end)}))
                     end
                   end
                if SMODS.pseudorandom_probability(card, 'interstellar_blackhole', 1, card.ability.extra.blackhole_odds) then
                        return {
                extra = {
                message = "+1 Blackhole",
                colour = G.C.SECONDARY_SET.Spectral,
                message_card = card,
            func = function()
          G.E_MANAGER:add_event(Event({    
                            func = (function()
                            trigger = 'before'
                            local c = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_black_hole', 'sup')
                            c:set_edition({negative = true}, true)
                            c:add_to_deck()
                            G.consumeables:emplace(c)
                            return true
                            end)}))
                        end},}
                     end
                 end
           end
        end,
}
SMODS.Joker{
  key = 'thelemnisc8',
  loc_txt = {
    name = 'The Lemnisc8',
    text = {
     "This Joker gains",
                        "{C:chips}+#4#{} Chips for each {C:attention}8{} discarded",
			"and {C:mult}+#3#{} Mult for each {C:attention}8{} scored",
			"{C:inactive}(Currently {C:chips}+#2# {C:inactive}Chips / {C:mult}+#1#{C:inactive} Mult)",
         }
    },
    rarity = 1,
    atlas = "jokersplus", pos = {x = 0, y = 0},
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = false,
    config = {extra = {mult = 0, chips = 0, mult_gain = 1, chip_gain = 4}},
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.mult_gain, card.ability.extra.chip_gain}}
  end,
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if context.other_card:get_id() == 8 and not context.blueprint then
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
      return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
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
			return{
				mult = card.ability.extra.mult,
                                chips = card.ability.extra.chips,
			}
		end
    end
}

SMODS.Joker{
  key = 'pjaten',
  loc_txt = {
    name = 'PJA 10',
    text = {
     "{C:green}#1# in #2#{} chance to create either",
			"a {C:tarot}Wheel of Fortune{} or {C:spectral}Aura{} card", 
                        "when any {C:attention}Booster Pack{} is opened",
                        "{C:inactive}(Must have room)"
         }
    },
    rarity = 3,
    atlas = "jokersplus2", pos = {x = 1, y = 0},
    cost = 10,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = true,
    config = {extra = 2,},
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
    return {vars = {G.GAME.probabilities.normal or 1, card.ability.extra}}
  end,
    calculate = function(self, card, context)
      if context.open_booster and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        if pseudorandom('pjatn') < G.GAME.probabilities.normal / card.ability.extra then
         local d100 = pseudorandom(pseudoseed('pjatnd100'), 1, 100)
           if d100 <= 50 then
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
           if d100 > 50 then
               return {
          G.E_MANAGER:add_event(Event({
                        func = function() 
                            local c = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_wheel_of_fortune', 'sup')
                            c:add_to_deck()
                            G.consumeables:emplace(c)
                            return true 
                        end})) 
                }              
           end
            end
        end
    end,
}

SMODS.Joker{
  key = 'mmx',
  loc_txt = {
    name = 'Mega Man X',
    text = {
     "Generate {C:attention}2{} copies of a single",
                    "random {C:tarot}Tarot{} card when",
                    "{C:attention}Boss Blind{} is defeated",
                    "{C:inactive}(Must have room)"
         }
    },
    rarity = 1,
    atlas = "jokersplusupdatepack3", pos = {x = 1, y = 0},
    cost = 4,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = false,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss and not self.gone then
          if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit - 1 then
             G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1 
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
							local _card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'mmx')
							_card:add_to_deck()
							G.consumeables:emplace(_card)
							G.GAME.consumeable_buffer = 0
                                                        local _card2 = copy_card(_card)
                                                        _card2:add_to_deck()
                                                        G.consumeables:emplace(_card2) 
						return true
					end)}))
				return {
					message = ('YOU GET'),
					colour = G.C.BLUE,
					card = card
				}
                 else if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
             G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1 
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
							local _card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'mmx')
							_card:add_to_deck()
							G.consumeables:emplace(_card)
							G.GAME.consumeable_buffer = 0 
						return true
					end)}))
				return {
					message = ('YOU GET'),
					colour = G.C.BLUE,
					card = card
				}
               end

	  end
       end
end,
}

SMODS.Joker{
  key = 'raygun',
  loc_txt = {
    name = 'Ray Gun',
    text = {
     "Each played {C:attention}9{}, {C:attention}3{}, or {C:attention}5{} gives",
                    "{X:mult,C:white}X#1#{} Mult when scored",
         }
    },
    rarity = 1,
    atlas = "jokersplusupdatepack2", pos = {x = 1, y = 0},
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = true,
    config = {extra = {x_mult = 1.15}},
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.x_mult,}}
    end,
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 9 or context.other_card:get_id() == 3 or context.other_card:get_id() == 5 then
              return {
                     x_mult = card.ability.extra.x_mult,
                     card = card
                    }
            end
      end
end,
}

SMODS.Joker{
  key = 'pacman',
  loc_txt = {
    name = 'Pac-Man',
        text = {"{X:mult,C:white}X#1#{} Mult",
                    "{C:inactive}Extra Lives: {C:gold}#2#{}",
                    "This Joker loses a {C:gold}life{} if played",
		    "hand contains a scoring {V:1}#3#{}",
                    "{s:0.8}suit changes at end of round,",
                    "{C:inactive}({C:dark_edition}+1UP{}{C:inactive} when {C:attention}Boss Blind{}{C:inactive} defeated)",
         }
    },
    rarity = 2,
    atlas = "pacmanjoker", pos = {x = 0, y = 0},
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    blueprint_compat = true,
    perishable_compat = false,
    config = {extra = {Xmult = 2.5, remaining = 2, pacbool = false}},
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.bjp_pacma_suit or {}).suit or 'Spades'
        return {vars = {card.ability.extra.Xmult, card.ability.extra.remaining, localize(suit, 'suits_singular'),
                colours = { G.C.SUITS[suit]}}
        }
    end,
    calculate = function(self, card, context)
       if context.joker_main and card.ability.extra.remaining >= 0 then
            return {
                Xmult = card.ability.extra.Xmult,
      }
        end
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss and not self.gone then
                                card.ability.extra.remaining = card.ability.extra.remaining + 1
                                return {
                                        play_sound('holo1'),
					message = ('1UP!'),
					colour = G.C.DARK_EDITION,
					card = card
				}
                                end
	if context.after and context.main_eval and not context.blueprint then
			card.ability.extra.pacbool = false
			for _, v in pairs(context.scoring_hand) do
				if v:is_suit(G.GAME.current_round.bjp_pacma_suit.suit) then
					card.ability.extra.pacbool = true
				end
                if card.ability.extra.pacbool then
                  if card.ability.extra.remaining - 1 <= -1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = card
                                    return true; end})) 
                            return true
                        end
                    })) 
                    return {
                       card_eval_status_text(card,'extra',nil, nil, nil,{message = "GAME OVER", colour = G.C.RED,}),
                       card = card
                    }
               else card.ability.extra.remaining = card.ability.extra.remaining - 1
                    return {
                        card_eval_status_text(card,'extra',nil, nil, nil,{message = "-1 Life", colour = G.C.RED,}),
        card = card
                    }
                      end
                end
            end
        end
  end
}

local function reset_bjp_pacma_suit()
	G.GAME.current_round.bjp_pacma_suit = { suit = 'Spades' }
	local valid_pacma_cards = {}
	for _, playing_card in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(playing_card) then
			valid_pacma_cards[#valid_pacma_cards + 1] = playing_card
		end
	end
	local pacma_card = pseudorandom_element(valid_pacma_cards,
		pseudoseed('bjp_pacmajoker' .. G.GAME.round_resets.ante))
	if pacma_card then
		G.GAME.current_round.bjp_pacma_suit.suit = pacma_card.base.suit
	end
end

function SMODS.current_mod.reset_game_globals(run_start)
reset_bjp_pacma_suit()
end


SMODS.Joker{
  key = 'rupees',
  loc_txt = {
    name = 'Rupees',
        text = {
     "Earn {C:green}$1{}, {C:chips}$5{}, or {C:mult}$20{}", 
                    "at end of round",
		    "{C:inactive}(Odds = {C:green}1 in 2{}{C:inactive},", 
                    "{C:chips}3 in 8{}{C:inactive},{C:inactive} & {C:mult}1 in 8{}{C:inactive})",
         }
    },
    rarity = 1,
    atlas = "rupeesjoker", pos = {x = 0, y = 0},
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = false,
    perishable_compat = true,
    config = {extra = { small_payout = 1,
                        medium_payout = 5,
                        big_payout = 20
	     }
    },
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.small_payout, card.ability.extra.medium_payout, card.ability.extra.big_payout,}}
    end,
    calc_dollar_bonus = function(self, card)
     local d100 = pseudorandom(pseudoseed('rupees'), 1, 100)
      if d100 <= 50 then
            return card.ability.extra.small_payout
        end

        if d100 > 50 and d100 <= 87 then
            return card.ability.extra.medium_payout
        end

        if d100 > 87 then
            return card.ability.extra.big_payout
        end
  end,

}

SMODS.Joker{
  key = "octane",
  loc_txt = {
    name = 'Octane',
    text = {
            "{C:chips}+#1#{} Chips",
                    "Destroyed if Blind",
                    "is defeated on the", 
                    "{C:attention}final hand{} of round",
        }
    },
    rarity = 1,
    atlas = "jokersplusupdatepack4", pos = {x = 1, y = 0},
    cost = 4,
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    blueprint_compat = true,
    perishable_compat = true,
    config = {extra = {chips = 75}},
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips,}}
 end,
    calculate = function(self, card, context)
if context.joker_main then
        return {
                chip_mod = card.ability.extra.chips,
                message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}
            }
end
if context.cardarea == G.jokers then
              if context.after and G.GAME.chips + hand_chips * mult > G.GAME.blind.chips and not context.blueprint then
                  if G.GAME.blind and G.GAME.current_round.hands_left == 0 then  
				G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = card
                                    return true; end})) 
                            return true
                        end
                    })) 
                    return {
                        message = ('What a save!'),
                        colour = G.C.BLUE
                    }

	  end
       end
   end
end,
}

SMODS.Joker{
  key = 'plumber',
  loc_txt = {
    name = 'Plumber',
    text = {
     "Gains {C:chips}+#2#{} chips",
     "if played hand",
     "contains a {C:attention}Flush{}",
     "{C:inactive}(Currently {C:chips}+#1# {C:inactive}Chips)"
        }
    },
    rarity = 1,
    atlas = "jokersplusupdatepack1", pos = {x = 0, y = 0},
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = false,
    config = {extra = {chips = 0, chip_gain = 8}},
    loc_vars = function(self, info_queue, card)
   return {vars = {card.ability.extra.chips, card.ability.extra.chip_gain}}
  end, 
    calculate = function(self, card, context)
      if context.cardarea == G.jokers and context.before and not context.blueprint then 
        if context.scoring_name == "Flush" or context.scoring_name == "Straight Flush" or context.scoring_name == "Royal Flush" or context.scoring_name == "Flush Five" or context.scoring_name == "Flush House" then
                        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.CHIPS,
                            card = card
                        }
                         end
        end
        if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}},
          chip_mod = card.ability.extra.chips,
      }
     end
    end,
}

SMODS.Joker{
  key = "vaultboy",
  loc_txt = {
    name = 'Vault Boy',
    text = {
            "{X:mult,C:white}X#3#{} Mult",
			        "After {C:attention}#1#{} rounds, sell this card",
                    "to create a {C:dark_edition}Negative{} {C:spectral}Soul{} card",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)",
         }
    },
    rarity = 3,
    atlas = "jokersplusupdatepack4", pos = {x = 0, y = 0},
    cost = 8,
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    blueprint_compat = false,
    perishable_compat = false,
    config = {extra = {rounds_needed = 3, rounds = 0, Xmult = 0.5,}},
    no_pool_flag = 'vboy_extinct',
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.rounds_needed, card.ability.extra.rounds, card.ability.extra.Xmult,}}
 end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition and card.ability.extra.rounds < card.ability.extra.rounds_needed then
          card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds >= card.ability.extra.rounds_needed then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                    message = (card.ability.extra.rounds < card.ability.extra.rounds_needed) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.rounds_needed) or localize('k_active_ex'),
                    colour = G.C.FILTER
                }
            elseif context.selling_self and card.ability.extra.rounds >= card.ability.extra.rounds_needed then
              G.GAME.pool_flags.vboy_extinct = true
              G.E_MANAGER:add_event(Event({
                        func = function()  
                            local c = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_soul', 'sup')
                            c:set_edition({negative = true}, true)
                            c:add_to_deck()
                            G.consumeables:emplace(c)
                            return true
                        end}))
            end
         if context.joker_main then
        return {
          Xmult = card.ability.extra.Xmult,
        }
       end
end,
}

SMODS.Joker{
  key = 'attachecase',
  loc_txt = {
    name = 'Attache Case',
    text = {
     "{C:dark_edition}+2{} Joker Slots",
     "{C:attention}+1{} consumable slot",
     "{C:green}#1# in #3#{} chance to set money to {C:money}$0{}",
     "when any {C:attention}Booster Pack{} is opened",
         }
    },
    rarity = 3,
    atlas = "jokersplusupdatepack3", pos = {x = 0, y = 0},
    cost = 8,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = false,
    perishable_compat = false,
    config = {extra = {merchant = 1, odds = 4,}},
    loc_vars = function(self, info_queue, card)
    return {vars = {G.GAME.probabilities.normal or 1, card.ability.extra.merchant, card.ability.extra.odds,}}
    end,
    add_to_deck = function(self, card, from_debuff)
		card.ability.extra.merchant = math.floor(card.ability.extra.merchant)
		local mod = card.ability.extra.merchant
		 G.jokers.config.card_limit = G.jokers.config.card_limit + 2
		 G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
	end,
	remove_from_deck = function(self, card, from_debuff)
		card.ability.extra.merchant = math.floor(card.ability.extra.merchant)
		local mod = card.ability.extra.merchant
		 G.jokers.config.card_limit = G.jokers.config.card_limit - 2
		 G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
	end,
    calculate = function(self, card, context)
      if context.open_booster and not context.blueprint then
         if pseudorandom('whatareyabuyin') < G.GAME.probabilities.normal / card.ability.extra.odds then
          ease_dollars(-G.GAME.dollars, true)
            return {
                  message  = localize('k_reset'),
                  delay = 0.65,
                  colour = G.C.MONEY,
                  card = card,
            }
         end
      end
   end,
}

SMODS.Joker{
  key = 'wildwest',
  loc_txt = {
    name = 'Wild West',
    text = {
     "Retrigger all played",
     "{C:attention}Wild{} and {C:attention}Stone Cards{}",
        }
    },
    rarity = 2,
    atlas = "jokersplusupdatepack1", pos = {x = 2, y = 0},
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = true,
    config = {extra = {repetitions = 1}},
    calculate = function(self, card, context)
            if context.cardarea == G.play and context.repetition and not context.repetition_only then
                if context.other_card.ability.effect == "Wild Card" or context.other_card.ability.effect == "Stone Card" then
        return {
          message = 'Again!',
          repetitions = card.ability.extra.repetitions,
          card = card
        }
          end
            end
    end,
}

SMODS.Joker{
  key = 'cottoncandy',
  loc_txt = {
    name = 'Cotton Candy',
    text = {
     "Gain {C:chips}+#1#{} hand and {C:red}+#2#{} discard",
     "at the start of each round", 
     "for the next {C:attention}#3#{} rounds",
        }
    },
    rarity = 2,
    atlas = "jokersplusupdatepack1", pos = {x = 1, y = 0}, 
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    blueprint_compat = false,
    perishable_compat = true,
    config = {extra = {hands = 1, discards = 1, remaining = 5}},
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.hands, card.ability.extra.discards, card.ability.extra.remaining}}
  end,
    calculate = function(self, card, context)
        if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
                if card.ability.extra.remaining - 1 <= 0 then 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                    return true; end})) 
                            return true
                        end
                    })) 
                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
        else
            card.ability.extra.remaining = card.ability.extra.remaining - 1
                    return {
                        message = card.ability.extra.remaining..'',
                        colour = G.C.FILTER
                    } 
            end
        end
        if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
                    ease_hands_played(card.ability.extra.hands)
       end
        if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
                    ease_discard(card.ability.extra.discards)
       end

    end,
}

SMODS.Joker{
  key = 'thepickaxe',
  loc_txt = {
    name = 'The Pickaxe',
    text = {
     "Each {C:diamonds}Diamond{} card discarded",
                    "has a {C:green}#1# in #2#{} chance to be", 
                    "destroyed and permanently",
                    "increase {C:attention}Blind Payout{} by {C:money}$#3#{}",
                    "{C:inactive}(Currently {C:money}$#4#{C:inactive})",
         }
    },
    rarity = 3,
    atlas = "jokersplusupdatepack2", pos = {x = 0, y = 0},
    cost = 8,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = false,
    perishable_compat = false,
    config = {extra = {odds = 4, money_add = 1, money = 0,}},
    loc_vars = function(self, info_queue, card)
    return {vars = {G.GAME.probabilities.normal or 1, card.ability.extra.odds, card.ability.extra.money_add, card.ability.extra.money}}
    end,
    calculate = function(self, card, context)
      if context.discard and 
            not context.other_card.debuff then            
        if context.other_card:is_suit('Diamonds') and not context.blueprint then
            if pseudorandom('thepickaxe') < G.GAME.probabilities.normal / card.ability.extra.odds then
               card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_add
              return {
                play_sound('slice1', math.random()*0.1 + 0.6,0.3),
                message = localize('k_upgrade_ex'),
                delay = 0.45,
                colour = G.C.MONEY,
                remove = true,
                card = card
            }
           end
        end
      end
    end,
calc_dollar_bonus = function(self, card)
    local bonus = card.ability.extra.money
    if bonus > 0 then return bonus
    end
end
}

SMODS.Joker{
  key = 'dagonet',
  loc_txt = {
    name = 'Dagonet',
    text = {
     "When {C:attention}Blind{} is selected,",
     "destroy Joker to the right",
     "and permanently gain {X:mult,C:white}X#1#{} Mult",
     "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
        }
    },
    rarity = 4,
    atlas = "jokersplusupdatepack1", pos = {x = 3, y = 0}, soul_pos = { x = 4, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = false,
    config = {extra = {Xmult_add = 1, Xmult = 1}},
    loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.Xmult_add, card.ability.extra.Xmult}}
  end,
    calculate = function(self, card, context)
                    if context.setting_blind and not context.blueprint then
                local my_pos = nil
                for i = 1, #G.jokers.cards do
                card = card
                     if G.jokers.cards[i] == card then my_pos = i; break 
                    end
                     end
                if my_pos and G.jokers.cards[my_pos+1] and not self.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then 
                    local sliced_card = G.jokers.cards[my_pos+1]
                    sliced_card.getting_sliced = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_add
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                        play_sound('slice1', 0.96+math.random()*0.08)
                    return true end }))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult_add}}, colour = G.C.RED, no_juice = true})
                end
                      elseif context.joker_main and card.ability.extra.Xmult > 1 then
                            return {
                                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                                Xmult_mod = card.ability.extra.Xmult,
                          }
            end
    end,
}

--Challenges

SMODS.Challenge{
    loc_txt = "Card Collector (BJ+)",
    key = 'cardcollector',
    rules = {
        custom = {},
        modifiers = {
            {id = "hands", value = 3},
            {id = "hand_size", value = 9},
        }
    },
    jokers = {
        {id = 'j_trading', eternal = true},
        {id = 'j_PlusJokers_pjaten', eternal = true},
    },
    consumeables = {},
    vouchers = {
           {id = 'v_magic_trick'},
	   {id = 'v_illusion'},
},
    restrictions = {
        banned_cards = {},
        banned_tags = {},
        banned_other = {},
    },
    }


SMODS.Challenge{
    loc_txt = "Jinxed (BJ+)",
    key = 'jinxed',
    rules = {
        custom = {
    },
        modifiers = {
            {id = 'joker_slots', value = 1},
            {id = 'consumable_slots', value = 3},
        },
    },
    jokers = {
        {id = 'j_lucky_cat', edition = 'negative', eternal = true},
    },
    consumeables = {
        {id = 'c_ectoplasm'},
        {id = 'c_magician'},
        },
    vouchers = {
	{id = 'v_omen_globe'},   
        },
    restrictions = {
        banned_cards = {},
        banned_tags = {},
        banned_other = {}
    },
    }

SMODS.Challenge{
    loc_txt = "Mine-crafting (BJ+)",
    key = 'minecrafting',
    rules = {
        custom = {
            {id = 'no_reward_specific', value = 'Big'},
	    {id = 'no_extra_hand_money'},
            {id = 'no_interest'},
},
        modifiers = {
    },
},
    jokers = {
        {id = 'j_PlusJokers_thepickaxe', eternal = true},
    },
    consumeables = {
            {id = 'c_star'},
},
    vouchers = {},
    restrictions = {
        banned_cards = {
            {id = 'j_rocket'},
            {id = 'j_golden'},
            {id = 'j_satellite'},
            {id = 'v_recyclomancy'},
            {id = 'v_seed_money'},
            {id = 'v_money_tree'},
},
             banned_tags = {},
             banned_other = {}
    },
}

SMODS.Challenge{
    loc_txt = "READY (BJ+)",
    key = 'readymmx',
    rules = {
        custom = {},
        modifiers = {
            {id = 'consumable_slots', value = 3},
        },
    },
    jokers = {
        {id = 'j_PlusJokers_mmx', eternal = true},
    },
    consumeables = {},
    vouchers = {},
    restrictions = {
        banned_cards = {
           {id = "p_arcana_normal_1"},
             {id = "p_arcana_normal_2"},
             {id = "p_arcana_jumbo_1"},
             {id = "p_arcana_jumbo_2"},
             {id = "p_arcana_mega_1"},
             {id = "p_arcana_mega_2"},
	     { id = "v_crystal_ball" },
	     { id = "v_omen_globe" },
},
        banned_tags = {},
        banned_other = {},
    },
    }

SMODS.Challenge{
    loc_txt = "The Legend of Jimbo (BJ+)",
    key = 'legendofjimbo',
    rules = {
        custom = {
            {id = 'no_reward_specific', value = 'Small'},
	    {id = 'no_extra_hand_money'},
            {id = 'no_interest'},
},
        modifiers = {
            {id = "dollars", value = 0},
        },
},
    jokers = {
        {id = 'j_PlusJokers_rupees', eternal = true},
        {id = 'j_joker', eternal = true},
    },
    consumeables = {{id = 'c_talisman'},
        {id = 'c_talisman'},
},
    vouchers = {
},
    restrictions = {
        banned_cards = {{id = 'j_rocket'},
            {id = 'j_golden'},
            {id = 'j_satellite'},
            {id = 'v_recyclomancy'},
            {id = 'v_seed_money'},
            {id = 'v_money_tree'},},
        banned_tags = {
            {id = 'tag_investment'},
},
        banned_other = {},
    },
    }

SMODS.Challenge{
    loc_txt = "Wild Wasteland (BJ+)",
    key = 'wildwasteland',
    rules = {
        custom = {},
        modifiers = {
            {id = "discards", value = 4},
	    {id = "hands", value = 2},
    },
},
    jokers = {
        {id = 'j_PlusJokers_wildwest', eternal = true},
	{id = 'j_PlusJokers_vaultboy',},
    },
    consumeables = {
            {id = 'c_lovers'},
	    {id = 'c_tower'},
},
    vouchers = {},
    restrictions = {
        banned_cards = {
                { id = "v_nacho_tong" },
	        { id = "v_recyclomancy" },
},
             banned_tags = {},
             banned_other = {
                {id = "bl_goad", type = "blind"},
                {id = "bl_head", type = "blind"},
                {id = "bl_club", type = "blind"},
                { id = "bl_window", type = "blind"},
      }
    },
}
