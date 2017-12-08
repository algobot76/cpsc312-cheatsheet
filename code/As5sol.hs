-- CPSC 312 2017 Assignment 5 Solution
-- Copyright David Poole 2017

-- harmonic n evaluates to the nth harmonic number

harmonic 1 = 1
harmonic n = harmonic (n-1) + 1/n

-- harmonic_tr n evaluates to the nth harmonic number
harmonic_tr n = harmonic_tr_help 1 1 n
    where
        -- harmonic nc h n evaluates to the nth harmonic number given that the nc-th harmonic number is h
        harmonic_tr_help nc v n
           | nc == n = v
           | otherwise = harmonic_tr_help (nc+1) (v+1/(nc+1)) n


-- harmonic (length [1,2,3,4])  gives a type error; length returns an Int but harmonic needs a Fractional
-- harmonic (fromIntegral (length [1,2,3,4]))

-- wins p nw nl  probability of winning given the team has probability of p of winning, it needs nw wins to win, and loses if it loses nl games
wins :: Double -> Int -> Int -> Double
wins _ 0 _ = 1
wins _ _ 0 = 0
wins p nw nl = p*(wins p (nw-1) nl) + (1-p) * (wins p nw (nl-1))

--- probability of winning a 5 game winning a tournament if a team has a 0.6 probaility of winning each game
-- wins 0.6 3 3
--- probability of winning a 7 game winning a tournament if a team has a 0.6 probaility of winning each game
-- wins 0.6 4 4
--- probability of winning 7 game tournament if one team is up 2-1 and each team has even chance of winning each game
-- wins 0.5 2 3

--  myremoveduplicates lst removes duplicates from a list; returns a list with
--       the same elements as lst, but with only one instance of each element
myremoveduplicates :: Eq t => [t] -> [t]
myremoveduplicates [] = []
myremoveduplicates (e1:r)
   | elem e1 r = myremoveduplicates r
   | otherwise = e1 : myremoveduplicates r

-- Try:
-- myremoveduplicates "abacad"
-- myremoveduplicates [7,3,2,1,3,2,2,1,1,3,7,8] 

myremoveduplicatesfirst :: Eq t => [t] -> [t]
myremoveduplicatesfirst lst = remdupfirst lst []
    where
        -- remdupfirst lst1 lst2   returns the elements in lst1 without duplicates that are not in lst2
        remdupfirst [] _ = []
        remdupfirst (h:t) lst2
            | h `elem` lst2 = remdupfirst t lst2
            | otherwise     = h : remdupfirst t (h:lst2)
            
-- Try:
-- myremoveduplicatesfirst "abacad"
-- myremoveduplicatesfirst [7,3,2,1,3,2,2,1,1,3,7,8] 


-- myordered lst is True if lst is ordered.
myordered :: Ord t => [t] -> Bool
myordered [] = True
myordered [e] = True
myordered (a:b:r) = a <= b && myordered (b:r)

-- Try
-- myordered "abcdefg"
-- myordered "ba"

-- myreplace x y lst replaces all occurrences of x in lst with y
myreplace :: Eq t => t -> t -> [t] -> [t]
myreplace _ _ [] = []
myreplace x y (h:t)
    | x==h = y:myreplace x y t
    | otherwise = h:myreplace x y t

-- myreplace 7 3 [7,0,7,1,7,2,7,3] 
-- myreplace 'a' 'x' ""
-- myreplace 'a' 'x' "abacad"

-- myapply lst sub where sub is a list of (x,y) pairs, replaces each occurrence of x by y in lst.
myapply :: Eq t => [t] -> [(t, t)] -> [t]
myapply []  _ = []
myapply (h:t) sub = app h sub :myapply t sub
    where
       -- app e sub gives the value e is replaced by according to sub
       app e [] = e
       app e ((x,y):r)
           | e==x = y
           | otherwise = app e r

-- myapply "abcdec" [('a','f'), ('c','3'), ('g','7')] 
-- myapply "baab" [('a','b'), ('b','a')]

-- deln n e lst returns the list that results from deleting the first n occurrences of e from lst
deln :: Eq t => Int -> t -> [t] -> [t]
deln 0 _ lst = lst
deln n e [] = []
deln n e (h:t)
   | e==h = deln (n-1) e t
   | otherwise = h:deln n e t

-- deln 2 'a' "avatar"

-- delna n e lst returns a list of all of the lists that result from deleting exactly n occurrences of e from lst
delna :: Eq t => Int -> t -> [t] -> [[t]]
delna 0 _ lst = [lst]
delna n e [] = []
delna  n e (h:t)
    | e==h = (delna (n-1) e t) ++ cons_to_each h (delna n e t)
    | otherwise = cons_to_each h (delna n e t)
        where
            -- cons_to_each e lst  -- conses e to every element of lst
            cons_to_each _ [] = []
            cons_to_each e (h:t) = (e:h):cons_to_each e t


-- delna 2 'a' "avatar"

-- Note that this would be easier with list comprehensions:
delna2 :: Eq t => Int -> t -> [t] -> [[t]]
delna2 0 _ lst = [lst]
delna2 n e [] = []
delna2 n e (h:t)
    | e==h = (delna2 (n-1) e t) ++ [h:r | r <- delna2 n e t]
    | otherwise = [h:r | r <- delna2 n e t]

-- delna2 2 'a' "avatar"


-- mynthinit n lst returns a list with the n elements from the end of list lst removed.
mynthinit :: Int -> [t] -> [t]
mynthinit n lst
   | length lst <= n = []
   | otherwise = collect  (length lst -n) lst
      where
        collect 0 lst = []
        collect n (h:t) = h:collect (n-1) t

-- Try:
-- mynthinit 10 [1..15]
