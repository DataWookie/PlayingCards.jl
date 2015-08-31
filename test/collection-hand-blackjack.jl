shoe = Shoe()

shuffle!(shoe)

h0 = BlackjackHand(shoe)
hit!(shoe, h0)
h1 = BlackjackHand([Card("2S"), Card("6H"), Card("AS")])					# Soft 19
h2 = BlackjackHand([Card("2S"), Card("6H"), Card("AS"), Card("AS")])				# Soft 20
h3 = BlackjackHand([Card("2S"), Card("6H"), Card("AS"), Card("AS"), Card("AS")])		# Soft 21
h4 = BlackjackHand([Card("2S"), Card("6H"), Card("AS"), Card("AS"), Card("AS"), Card("AS")])	# Hard 12
h5 = BlackjackHand([Card("TS"), Card("AH")])							# Blackjack
h6 = BlackjackHand([Card("TS"), Card("QH"), Card("KH")])					# Bust
h7 = BlackjackHand([Card("8C"), Card("AH")])

println(h0, " ", evaluate(h0))
println(h1, " ", evaluate(h1))
println(h2, " ", evaluate(h2))
println(h3, " ", evaluate(h3))
println(h4, " ", evaluate(h4))
println(h5, " ", evaluate(h5))
println(h6, " ", evaluate(h6))

@assert blackjack(h5)
@assert bust(h6)
@assert (h6 < h6) == false									# Busts are equal
@assert (h6 > h6) == false									# Busts are equal
@assert h6 < h4
@assert h4 > h6
@assert h5 > h3
@assert h3 < h5
@assert (h5 < h5) == false									# BJs are equal
@assert (h5 > h5) == false									# BJs are equal
@assert h2 > h1
@assert h1 < h2
@assert h3 > h2
@assert h7 == h1
