-- CPSC 312 - 2017 - Binary Trees in Haskell
module BTree where

-- To run it, try:
-- ghci
-- :load BTree

-- a binary tree where the nodes are labelled with integers
data BTree = Empty
           | Node BTree Int BTree

-- tolist lst  retuens the list giving the inorder traversal of lst
tolist :: BTree -> [Int]
tolist Empty = []
tolist (Node lt val rt) =
     tolist lt ++ (val : tolist rt)

--- Example to try
-- tolist (Node (Node Empty 2 (Node Empty 4 Empty)) 5 (Node Empty 8 Empty))





-- tolist without append (++), using accumulators
tolista :: BTree -> [Int]
tolista lst =
    tolist2 lst []

-- tolist2 tree lst   returns the the list of elements of tree followed by the elements of lst
tolist2 :: BTree -> [Int] -> [Int]
tolist2 Empty acc = acc
tolist2 (Node lt val rt) acc =
     tolist2 lt  (val : tolist2 rt acc)

--- Example to try
-- tolista (Node (Node Empty 2 (Node Empty 4 Empty)) 5 (Node Empty 8 Empty))
