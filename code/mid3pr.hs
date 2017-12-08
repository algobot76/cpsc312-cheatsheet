-- CPSC 2016 -- Runnable Solution to Practice Test for Midterm 3 

-- Question 1

doif f g [] = []
doif f g (h:t)
   | f h = g h : doif f g t
   | otherwise = h : doif f g t

-- (a)
-- :type doif
doif :: (t -> Bool) -> (t -> t) -> [t] -> [t]

-- (b)
--doif even (`div` 2) [1,2,3,4,5,6]
-- [1,1,3,2,5,3]

-- (c)
capvowel lst = doif (`elem` "aeiou") toUpper lst
toUpper :: Char -> Char
toUpper x = toEnum( fromEnum x - fromEnum 'a' + fromEnum 'A')

-- capvowel "abcdefghij"

-- Question 2

-- (a)
subsequence l1 l2 = starts l1 l2 || l2 /= [] && subsequence l1 (tail l2)
    where
      starts [] _ = True
      starts _ [] = False
      starts (h1:t1) (h2:t2) = h1==h2 && starts t1 t2
-- subsequence "fun" "logic and functional"
-- subsequence "laf" "logic and functional" 

-- (b)
subsequence :: Eq a => [a] -> [a] -> Bool

-- (c)
-- subsequence takes 2 arguments, both lists of the the same typoe and returns a Boolean
-- the type must implement equality

-- Question 3

-- (a)
doif1 f g lst = [if f x then g x else x | x <- lst]
-- doif1 even (`div` 2) [1,2,3,4,5,6]

-- (b)
doif2 f g = foldr (\x y -> (if f x then g x else x):y) []
-- doif2 even (`div` 2) [1,2,3,4,5,6]

-- foldr (\ x y -> (if elem x "aeiou" then toUpper x else '_'):y ) [] "abcefop"
-- "A__E_O_"

-- Question 4

-- (a) Polymorphic typing is when a function can take many types.
-- for example doif
-- doif :: (t -> Bool) -> (t -> t) -> [t] -> [t]
--  works for any type t

-- (b) call-by-value evaluates the arguments of a function before applying the function.
-- call-by-name applies the function before evaluating the arguments
-- lazy evaluation is like call-by-name, but it only evaluates the arguments once

-- (c) foldl is a function that takes 3 arguments. The type of the result is the type of the second argument (which is called b, in the type declaration).
-- The type of the 3rd argument must be a list of some type, which is here referred to as a
-- The first argument of foldl is a function, that takes two arguments, the first of the type b, the second of type a, and returns a value of type b.
