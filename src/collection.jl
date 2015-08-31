# CARD COLLECTION -----------------------------------------------------------------------------------------------------

abstract CardCollection

ranks(collection::CardCollection) = map(x -> x.rank, collection.cards)

