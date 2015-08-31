# HAND: BLACKJACK -----------------------------------------------------------------------------------------------------

type BlackjackHand <: Hand
	cards::Array{Card,1}
end

# Outer constructors.
#
BlackjackHand(deck::Dealable) = (hand = BlackjackHand([]); deal!(deck, hand, 2); hand)

hit!(deck::Dealable, hand::BlackjackHand) = append!(hand, deal!(deck, 1))

function evaluate(hand::BlackjackHand)
	r = map(x -> int(x), ranks(hand)) + 1
	r[11 .<= r .<= 13] = 10					# Convert face cards to 10
	#
	value = sum(filter(n -> n < 14, r))			# Value without Aces
	texture = "hard"
	#
	naces = count(n -> n == 14, r)
	if naces > 1
		value += naces - 1
		naces = 1
	end
	if naces == 1
		if value + 11 > 21
			value += 1
		else
			value += 11
			texture = "soft"
		end
	end
	#
	(value, texture, length(r) == 2 && value == 21)
end

blackjack(hand::BlackjackHand) = evaluate(hand)[3]
bust(hand::BlackjackHand) = evaluate(hand)[1] > 21

==(h1::BlackjackHand, h2::BlackjackHand) = evaluate(h1) == evaluate(h2)
function isless(h1::BlackjackHand, h2::BlackjackHand)
	v1 = evaluate(h1)
	v2 = evaluate(h2)
	if v1[1] > 21					# BUST	h1	h2
		if v2[1] > 21				# ----------------
			return false			# 	Y	Y
		end
		return true				# 	Y	N
	end
	v2[1] > 21 && return false			# 	N	Y
	#
	if v1[3]					# BJ	h1	h2
		if v2[3]				# ----------------
			return false			#	Y	Y
		end
		return false				#	Y	N
	end
	v2[3] && return true				#	N	Y
	#
	v1[1] < v2[1]
end

