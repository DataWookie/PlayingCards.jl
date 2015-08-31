# DECK ----------------------------------------------------------------------------------------------------------------

type Deck <: Dealable
	cards::Array{Card,1}
	Deck() = new(map(Card, [0:51]))
end

# String representation.
#
string(deck::Deck) = string("Deck with ", length(deck), " cards remaining.")

# -> Tests.
#
@assert length(Deck()) == 52
@assert deal!(Deck()) == [Card("AS")]
@assert typeof(shuffle!(Deck())) == Deck
@assert length(deal!(Deck())) == 1
@assert length(deal!(Deck(), 3)) == 3

