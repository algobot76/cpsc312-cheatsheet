module BTree where

data BTree = Empty | Node BTree Int BTree

-- tolist lst  returns the list giving the inorder traversal of lst
tolist :: BTree -> [Int]
tolist Empty = []
tolist (Node lt val rt) =
     tolist lt ++ (val : tolist rt)

-- tolist without append (++), using accumulators
tolista :: BTree -> [Int]
tolista lst =
    tolist2 lst []

tolist2 :: BTree -> [Int] -> [Int]
tolist2 Empty acc = acc
tolist2 (Node lt val rt) acc =
    tolist2 lt  (val : tolist2 rt acc)
