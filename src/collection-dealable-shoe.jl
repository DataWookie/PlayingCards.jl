# SHOE ----------------------------------------------------------------------------------------------------------------

type Shoe <: Dealable
	cards::Array{Card,1}
	Shoe(decks::Int64 = 8) = new(repmat(Deck().cards, decks))
end

# String representation.
#
string(shoe::Shoe) = string("Shoe with ", length(shoe), " cards remaining.")

# -> Tests.
#
@assert length(Shoe()) == 416

