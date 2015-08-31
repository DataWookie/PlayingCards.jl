# HAND ----------------------------------------------------------------------------------------------------------------

# type Hand <: CardCollection
# 	cards::Array{Card,1}
# end

abstract Hand <: CardCollection

# Dealing.
#
import Base.append!
append!(hand::Hand, cards::Array{Card,1}) = (append!(hand.cards, cards); hand)
deal!(deck::Dealable, hand::Hand, count::Int64 = 1) = append!(hand, deal!(deck, count))

# Sort.
#
import Base.sort!
sort!(hand::Hand) = sort!(hand.cards)

# String representation.
#
string(hand::Hand) = join(map(string, hand.cards), " ")

show(io::IO, hand::Hand) = print(io, string(hand))

# If evaluate() returns a tuple then the first element must be a numerical value.
#
isless(h1::Hand, h2::Hand) = evaluate(h1)[1] < evaluate(h2)[1]

