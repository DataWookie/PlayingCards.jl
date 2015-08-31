# CARD ----------------------------------------------------------------------------------------------------------------

# Rank |  C  D  H  S
# ------------------
# 2    |  0 13 26 39
# 3    |  1 14 27 40
# 4    |  2 15 28 41
# 5    |  3 16 29 42
# 6    |  4 17 30 43
# 7    |  5 18 31 44
# 8    |  6 19 32 45
# 9    |  7 20 33 46
# T    |  8 21 34 47
# J    |  9 22 35 48
# Q    | 10 23 36 49
# K    | 11 24 37 50
# A    | 12 25 38 51

# I played with having methods to calculate the rank and suit from the index but, since these are likely to be called
# frequently in client code, it made sense from an efficiency perspective to simply retain these data within the type.
#
immutable Card
	index::Int32
	mask::Int64
	rank::Rank
	suit::Suit
	function Card(index::Integer)
		if (0 <= index < 52)
			return new(index, 1 << index, Rank(index % 13 + 1), Suit(div(index, 13) + 1))
		else
			error("Invalid index!")
		end
	end
end

# Outer constructors.
#
function Card(rank::Char, suit::Char)
	if !in(rank, Ranks) error("Invalid rank!") end
	if !in(suit, Suits) error("Invalid suit!") end
	Card(findfirst(Ranks, rank) + findfirst(Suits, suit) * 13 - 14)
end
function Card(code::String)
	@assert length(code) == 2
	Card(code[1], code[2])
end

# rank(card::Card) = card.rank + 1
# suit(card::Card) = card.suit

# String representation.
#
import Base.string
string(card::Card) = string(card.rank, card.suit)
unicode(card::Card) = string(Ranks[card.rank], SuitsSymbols[card.suit])

import Base.show
# show(io::IO, card::Card) = print(io, string(card))

# Comparison operators.
#
==(c1::Card, c2::Card) =  (c1.rank == c2.rank) && (c1.suit == c2.suit)
import Base.isless
isless(c1::Card, c2::Card) = (c1.rank == c2.rank) ? (c1.suit < c2.suit) : (c1.rank < c2.rank)

# -> Tests.
#
@assert try Card("PS") end == false
@assert try Card("2F") end == false
@assert Card("5C").mask == 8
@assert Card("5C").rank == Rank('5')
@assert Card("5C").suit == Suit('C')
@assert string(Card('5', 'C')) == "5C"
#
@assert Card("5C") == Card("5C")
@assert Card("5C") != Card("5D")
@assert Card("5C") != Card("6C")
@assert Card("5C") <  Card("6C")
@assert Card("5C") <  Card("5D")
@assert Card("5C") >  Card("4C")
@assert Card("5D") >  Card("5C")

