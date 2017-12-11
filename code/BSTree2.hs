-- CPSC 312 - 2017 - Binary Search Trees in Haskell
module BSTree where

-- To run it, try:
-- ghci
-- :load BSTree

-- a binary search tree 
data BSTree k v = Empty
                | Node k v (BSTree k v) (BSTree k v)
         deriving (Eq, Show, Read)

egtree = Node 5 "alive" (Node 2 "be" Empty (Node 4 "fun" Empty Empty)) (Node 8 "food" Empty  Empty)

-- Try:
-- egtree  -- note how "show" is defined for BSTrees

-- tolist lst  returns the list giving the inorder traversal of lst
tolist :: BSTree k v -> [(k,v)]
tolist Empty = []
tolist (Node key val lt rt) =
     tolist lt ++ ((key,val) : tolist rt)

--- Example to try
-- tolist egtree





-- tolist without append (++), using accumulators
tolista :: BSTree k v -> [(k,v)]
tolista lst =
    tolist2 lst []
      where
        -- tolist2 tree lst   returns the the list of elements of tree followed by the elements of lst
        -- tolist2 :: BSTree k v -> [(k,v)] -> [(k,v)]
        tolist2 Empty acc = acc
        tolist2 (Node key val lt rt) acc =
             tolist2 lt  ((key,val) : tolist2 rt acc)

--- Example to try
-- tolista egtree

-- insert key val tree   returns the tree that results from inserting key with value into tree
insert :: Ord k => k -> v -> BSTree k v -> BSTree k v
insert key val Empty = Node key val Empty Empty
insert key val (Node k1 v1 lt rt)
    | key == k1 = Node key val lt rt
    | key < k1 = Node k1 v1 (insert key val lt) rt
    | key > k1 = Node k1 v1 lt (insert key val rt)

-- insert 6 "six" egtree

-- what if we wanted to return the old value as well as the tree?
-- what if there wasn't an old value; what should be returned? (It has to be of the correct type!)

-- insertv key val tree   returns the previous value and the resulting tree
insertv :: Ord k => k -> v -> BSTree k v -> (Maybe v, BSTree k v)
insertv key val Empty = (Nothing, Node key val Empty Empty)
insertv key val (Node k1 v1 lt rt)
    | key == k1 = (Just v1, Node key val lt rt)
    | key < k1 = let (res,nt) = insertv key val lt
                 in (res, Node k1 v1 nt rt)
    | key > k1 = let (res,nt) = insertv key val rt
                 in (res, Node k1 v1 lt nt) 

-- try:
-- insertv 6 "six" egtree 
-- insertv 4 "me" (snd it)


-- lookup key tree   returns the value of key in tree
btlookup :: Ord k => k -> BSTree k v -> Maybe v
btlookup key (Node k1 v1 lt rt)
    | key == k1 = Just v1
    | key < k1  = btlookup key lt
    | otherwise = btlookup key rt
btlookup key Empty = Nothing

-- lookup 8 egtree
-- lookup 7 egtree

instance Functor (BSTree k) where
    -- fmap :: (a -> b) -> Maybe k a -> Maybe k b
    fmap f Empty = Empty
    fmap f (Node key val t1 t2) = Node key (f val) (fmap f t1) (fmap f t2)

-- try
-- egtree
-- fmap ("not"++) egtree