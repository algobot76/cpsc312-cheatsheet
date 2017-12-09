--  CPSC 312 2017 - Final Exam Practice Questions
--  Solutions that relate to Haskell

-- Question 1
-- (\f g x -> f x (g x)) (\ x y -> 2*x) (\x y -> x*x) 5
-- returns 10
-- (\f g x -> f x (g x)) (\ x y -> y) (\x y -> x*x) 5
-- returns (\y -> 25)
-- try:
-- (\f g x -> f x (g x)) (\ x y -> y) (\x y -> x*x) 5 999

-- Question 2
-- del1 e lst    -- returns a list with one instance of e removed from list lst
-- need to make a choice of what happens if e is not in lst
-- it could
---- return lst
---- give a runtime error
---- return Nothing
del1 e (h:t)
   | e==h      = t
   | otherwise = e:del1 e t
--- what does this do if e is not in lst?

-- (ii)
del1all :: Eq t => t -> [t] -> [[t]]
del1all _ [] = []
del1all e (h:t)
    | e==h  = t:[h:l | l <- del1all e t]
    | otherwise = [h:l | l <- del1all e t]
-- try:
-- del1all 2 [1,2,3,2,4,2]

-- (iii) Prolog can do something like
-- del1(val(x,V),[val(y,3),val(x,7),val(x,2)],R).
-- to return the value of x as well as the rest of the list

-- (iv) Haskel can work with higher-order function, e.g., generalizing this delete1 to act on other functions of the elements (not just equality

--- iappend l = [(l1,l2)] where l1 appended to l2 gives l
--- returns list of all answers
iappend :: [t] -> [([t],[t])]
iappend [] = [([],[])]
iappend (h:t) = ([],(h:t)) : [(h:l1,l2) | (l1,l2) <- iappend t]

-- try:
--  iappend [1,2,3,4]

shuffle :: [t] -> [t] -> [[t]]  -- list of all shuffles
shuffle l1 [] = [l1]
shuffle [] l2 = [l2]
shuffle (h1:t1) (h2:t2) =
    [h1:e | e <- shuffle t1 (h2:t2)] ++ [h2:e | e <- shuffle (h1:t1) t2]

-- sumn lst = (sum lst, lenght lst)
sumn :: [Int] -> (Int,Int)  -- (sum,lenght)
sumn [e] = (e,1)
sumn (h:t) =
    let (s,n) = sumn t
    in (s+h, n+1)
ave lst =
    let (s,n) = sumn lst
    in s `div` n

-- question 4. Here we  return the list of all remaining element as does the original prolog program
-- e.g,   wff ["p","&","not","q","or","r"]
-- this uses the same naming conventions for variables as in the prolog (except, lower case, of course)
wff :: [[Char]] -> [[[Char]]]
wff a =
   [ b | z <- terminal a, y <- binop z, b <- wff y]
   ++ [b | z <- unop a, b <- wff z]
   ++ terminal a
   
binop ("&":t) = [t]
binop ("or":t) = [t]
binop (_:_) = []
binop [] = []

terminal (term:t) 
   | term `elem` ["p","q","r"] = [t]
   | otherwise = []
terminal [] = []

unop ("not":t) = [t]
unop (_:_) = []
unop [] = []


-- Question 5

data BSTree k v = Empty
                | Node k v (BSTree k v) (BSTree k v)
         deriving (Eq, Show, Read)

{-
(a) BSTree is a type constructor, k is a type

(b) Node is a function that takes 4 arguments, the first of if type k, the second is of type v and the 3rd and 4th arguments are of type (BSTree k v)

(c) Here are two examples
Node 3 'a' Empty Empty
Node 3 'a' (Node 1 'b' Empty Empty) Empty

(d)
-}

lefttree :: BSTree k v -> Maybe (BSTree k v)
lefttree Empty = Nothing
lefttree (Node _ _ lt _) = Just lt

-- try
-- lefttree (Node 3 'a' (Node 1 'b' Empty Empty) Empty)

{-
(e) This defines the function "show" for Example and declares that Example in a type in the show class.
It creates a string with a newline at the start and where the elements are separated by a tab.

Question 6
The answers are in the article!
-}