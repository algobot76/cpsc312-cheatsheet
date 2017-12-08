-- CPSC 312 2017 - Assignment 6 solution
-- Copyright D. Poole, 2017. Do not redistrubute

-- Question 1 (a)
tails :: [t] -> [[t]]
tails [] = [[]]
tails (e:r) = (e:r):tails(r)
-- tails "happy"

tails1 :: [t] -> [[t]]
tails1 = foldr (\x (h:r) -> (x:h):(h:r) ) [[]]

-- Question 1(b)
map1 :: (a -> b) -> [a] -> [b]

map1 _ [] = []
map1 f (h:t) = f h : map1 f t

map2 f lst = [f e | e <- lst]

map3 f lst = foldr (\x y -> f x :y) [] lst

-- Question 2
-- 2(a) Here are a few solutions
harmonic n = foldr (+) 0 [1/i | i <- [1..n]]
harmonic1 n = foldr (\x y -> 1/x+y) 0 [1..n]

-- tail recursion versions
harmonic_tr n = foldl (+) 0 [1/i | i <- [1..n]]
harmonic_tr1 n = foldl (\x y -> x+1/y) 0 [1..n]

-- 2(b)
myremoveduplicates  lst = [ head l | l <- tails lst, l /= [], not (head l `elem` tail l)]
myremoveduplicates2  lst = [ h | (h:t) <- tails lst,  not (h `elem` t)]    --using pattern matching
-- myremoveduplicates "abacad"
-- myremoveduplicates2 [7,3,2,1,3,2,2,1,1,3,7,8]

-- 2(c)
myordered lst = and [e1<=e2 | (e1:e2:r) <- tails lst]
-- myordered "abcdefg"
-- myordered "ba"

---or using zip
myordered2 [] = True
myordered2 (h:t) = and [e1 <= e2 | (e1,e2) <- zip (h:t) t]

-- 2(d)
myreplace x y lst = [if e==x then y else e | e <- lst]

-- myreplace 7 3 [7,0,7,1,7,2,7,3]
-- myreplace 'a' 'x' ""
-- myreplace 'a' 'x' "abacad"

-- 2(e)

-- one try
myapply lst sub = [(\res -> if res /= [] then head res else e) [b | (a,b) <- sub, a==e]  | e <- lst]
-- myapply "abcdec" [('a','f'), ('c','3'), ('g','7')]
-- myapply "baab" [('a','b'), ('b','a')]

-- or even clearer....
-- head_with_default lst def   = head of list lst, otherwise (if there is no head) evaluates to def
head_with_default [] def = def
head_with_default (h:t) _    = h
myapply1 lst sub = [head_with_default [b | (a,b) <- sub, a==e]  e | e <- lst]

-- or even simpler
myapply2 lst sub = [head [b | (a,b) <- sub++[(e,e)], a==e] | e <- lst]

-- Question 3

-- split (`elem` " ,.?!") "What? is this thing? called Love."  => ["What","is","this","thing","called","Love"]
split sep [] = []
split sep (h1:h2:t)
    | sep h1 = split sep (h2:t)
    | sep h2 = [h1]:split sep (h2:t)
    | otherwise = ((h1:w1):rest)
                where w1:rest = split sep (h2:t)
split sep [h]   -- if previous patterns do not match the argument must be a single element list
    | sep h = []
    | otherwise = [[h]]

-- split even [1,3,4,5,7,9,8,8,55,45]
-- split (==',') "comma,separated,list,as,in,a,csv,file"
-- split (`elem` " ,.?!") "make string into words, removing ,.? etc.  "
-- split (`elem` " ,.?!") "What? is this thing? ... called Love."
-- split (`elem` " ,.?!") "What is this? thing called, Love??"
