-- CPSC 312 -- Haskell Code from the 2016 Final
-- Copyright 2017 - not for redistribution

-- Question 1

foo [] y = y
foo (a:b) c = a: foo c b
-- foo [1,3]  [9,7,4]
-- [1,9,3,7,4]

powerset [] = [[]]
powerset (h:t) =
    let pset = powerset t
    in  [h:s | s <- pset] ++ pset


-- Question 2

split [] = ([],[])
split [x] = ([x],[])
split (x:y:r) =
    let (r1,r2) = split r
    in (x:r1, y:r2)

merge [] l = l
merge l [] = l
merge (a:l1) (b:l2)
    | a <= b = a: merge l1 (b:l2)
    | otherwise = b: merge (a:l1) l2

msort [] = []
msort [a] = [a]
msort l =
   let (l1,l2) = split l
   in merge (msort l1) (msort l2)

-- msort [1,6,4,3,5,8,3,5,7,9,11,0]

--  Question 3
{-
sorted :: [a] -> Bool
sorted [] = True
sorted (x:y:xs) = x < y && (sorted y:xs)
 
(a) The precedence means  (sorted y:xs)  is  ((sorted y):xs) which is a list and so can't be joined by &&
The fix is to make it  sorted (y:xs)

(b) The declaration of sorted claims it works with a list of any type, but < is only defined for tyoes that implement the Ord class.
Fix is to make the declaration
sorted :: Ord a => [a] -> Bool

(c) It did not cover the case when the there is only one element in the list. 
Fix is to add:
sorted [_] = True


-}

-- Question 4

-- (a)
transpose m i j = m j i

-- (b)
replace m i j v ni nj =
    if (ni==i && nj==j)
       then v
       else m ni nj
-- (c)
sum_all m =
    sum [m i j | i <- [1..9], j <- [1..9]]

-- (e) You could declare
type Matrix = Int -> Int -> Double
transpose :: Matrix -> Matrix
-- This does not provide extra type checking, except that the user can see that the type is correct, and the system can check this.

-- An alternative is to have  (with "my" used here to make sure that it compiles)
newtype MyMatrix = MyMatrix (Int -> Int -> Double)
mytranspose :: MyMatrix -> MyMatrix
mytranspose (MyMatrix m) =
    MyMatrix (\ i j -> m j i)
--  This does provide extra type checking becuse it only works for MyMartices, not for arbitrary functions

-- Question 5 
data BSTree k v = BSEmpty
                | BSNode k v (BSTree k v) (BSTree k v)

instance (Show k, Show v) => Show (BSTree k v) where
   show t = foldr (\ e r -> (show e) ++ "\n"++ r) "" (tolist t)

tolist BSEmpty = []
tolist (BSNode key val l r) = tolist l ++ [(key,val)] ++ tolist r

--(a)  k and v are types; the type of the key and the type of the value of the tree

--(b)  tolist :: BSTree a b -> [(a, b)]

--(c)
myst t = length (tolist t)
-- returns the number of nodes in the tree

--(d) This defined how to "show" a BSTree. This specifies that (BSTRee k v) is in the Show class as long as the types k and v are in the Show class.

--(e)
bt1 = BSNode 2 "fun" BSEmpty (BSNode 4 "me" BSEmpty BSEmpty)
bt2 = BSNode 4 "me" (BSNode 2 "fun" BSEmpty BSEmpty) BSEmpty 

value_in_tree BSEmpty _ = False
value_in_tree (BSNode key val lt rt) v =
    val==v || value_in_tree lt v || value_in_tree rt v



