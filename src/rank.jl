# RANK ----------------------------------------------------------------------------------------------------------------

Ranks = [char(50:57), 'T', 'J', 'Q', 'K', 'A']

type Rank
	rank::Int32
	Rank(rank::Integer) = (1 <= rank <= 13) ? new(rank) : error("Invalid rank!")
end

Rank(rank::Char) = (rank in Ranks) ? Rank(findfirst(Ranks, rank)) : error("Invalid rank!")

import Base.char
char(rank::Rank) = Ranks[rank.rank]
import Base.show
show(io::IO, rank::Rank) = print(io, char(rank))
import Base.convert
convert(::Type{Int64}, rank::Rank) = rank.rank

# Arithmetic operators.
#
+(rank::Rank, n::Int64) = Rank(rank.rank + n)
-(rank::Rank, n::Int64) = Rank(rank.rank - n)

# Comparison operators.
#
==(r1::Rank, r2::Rank) = r1.rank == r2.rank
import Base.isless
isless(r1::Rank, r2::Rank) = r1.rank < r2.rank

# -> Tests.
#
@assert try Rank('C') end == false
@assert Rank('Q') == Rank('Q')
@assert Rank('Q') < Rank('K')
@assert Rank('Q') > Rank('J')
@assert Rank('2') + 2 == Rank('4')
@assert Rank('4') - 2 == Rank('2')
