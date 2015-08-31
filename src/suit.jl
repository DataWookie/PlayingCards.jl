# SUIT ----------------------------------------------------------------------------------------------------------------

Suits = ['C', 'D', 'H', 'S'];
SuitNames = ["Club", "Diamond", "Heart", "Spade"]

# Unicode mapping.
#
# https://en.wikipedia.org/wiki/Playing_cards_in_Unicode
#
SuitSymbols = ['\u2663', '\u2666', '\u2665', '\u2660'];

type Suit
	suit::Int32
	Suit(suit::Integer) = (1 <= suit <= 4) ? new(suit) : error("Invalid suit!")
end

Suit(suit::Char) = (suit in Suits) ? Suit(findfirst(Suits, suit)) : error("Invalid suit!")

char(suit::Suit) = Suits[suit.suit]
show(io::IO, suit::Suit) = print(io, char(suit))

fullname(suit::Suit) = SuitNames[suit.suit]

# Comparison operators.
#
==(s1::Suit, s2::Suit) = s1.suit == s2.suit
isless(s1::Suit, s2::Suit) = s1.suit < s2.suit

# -> Tests.
#
@assert try Suit("Q") end == false
@assert Suit('C') == Suit('C')
@assert Suit('C') < Suit('H')
@assert Suit('H') > Suit('C')
@assert fullname(Suit('S')) == "Spade"
