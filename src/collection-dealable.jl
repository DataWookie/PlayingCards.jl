# DEALABLE ------------------------------------------------------------------------------------------------------------

abstract Dealable <: CardCollection

# Number of cards remaining in deck.
#
import Base.length
length(deck::Dealable) = length(deck.cards)

# Dealing.
#
deal!(deck::Dealable, count::Int64 = 1) = (count <= length(deck)) ? [pop!(deck.cards) for i in 1:count] : throw(BoundsError())
burn!(deck::Dealable, count::Int64 = 1) = (deal!(deck, count); nothing)

# Shuffling.
#
import Base.shuffle!
shuffle!(deck::Dealable) = (shuffle!(deck.cards); deck)

# String representation.
#
show(io::IO, deck::Dealable) = print(io, string(deck))

