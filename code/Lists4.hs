-- CPSC 312 - 2017 - Lists in Haskell
module Lists4 where

-- To run it, try:
-- ghci
-- :load Lists4

-- myappend [a1,a2,..,an] [b1,b2,..,bm] = [a1,a2,..,an,b1,b2,..,bm]
myappend l1 l2 = foldr (:) l2 l1

-- append with infix operator
l1 ++++ l2 = foldr (:) l2 l1
--  [1,2,4,6] ++++ [11,23,45,56]


-- dotprod [x1,x2,..,xn] [y1,y2,..,yn]  = [x1*y1+x2*y2+...+xn*yn]
dotprod v1 v2 = foldr (\ (x,y)  s -> x*y+s) 0 
                      (zip v1 v2)

-- dotprod [1,2,3,4] [4,3,2,1]

-- mylength lst    returns length of lst
--mylength = foldr (\ x y -> y+1) 0


-- rev2 l1 l2 = reverse of list l2 followed by l1
rev2 l1 []     = l1
rev2 l1 (x:xs) = rev2 (x:l1) xs
-- rev2 [1,2,4,6] [11,23,45,56]

rev = rev2 []
-- rev [1,2,4,6,11,23,45,56]


-- myfoldl op v [a1,a2,..an] = (((v op a1) op a2) op ...) op an
myfoldl f v [] = v
myfoldl f v (x:xs) = myfoldl f (f v x) xs

-- consi is the inverse of cons 
consi x y = y : x

-- what is re? What is its type? What does it do?
re = myfoldl consi []
-- re [1,2,3,4,5]

re1 = myfoldl (\ x y -> y:x) []

-- infn f is the same as f, but reverses the first two arguments
myflip f a b = f b a

re2 = myfoldl (myflip (:)) []

-- re2 [1..10]

-- using definitions from the Prelude:
-- foldl (flip (:)) [] [1..10]

