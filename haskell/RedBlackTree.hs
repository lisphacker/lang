module RedBlackTree where

data Color = Red | Black
           deriving (Show)
data Tree k v = Leaf | Node k v Color (Tree k v) (Tree k v)
            deriving (Show)

insert :: (Ord k) => k -> v -> Tree k v -> Tree k v
insert k v tree = insertRepair $ insertRecurse k v tree

insertRecurse :: (Ord k) => k -> v -> Tree k v -> Tree k v
insertRecurse k v (Node tk tv c left right)
  | k < tk    = Node tk tv c (insertRecurse k v left) right
  | k > tk    = Node tk tv c left (insertRecurse k v right)
  | otherwise = Node tk v c left right
insertRecurse k v Leaf = Node k v Red Leaf Leaf

insertRepair :: (Ord k) => Tree k v -> Tree k v
insertRepair = id


rotateLeft :: Tree k v -> Tree k v
rotateLeft p@(Node p_k p_v p_c l (Node r_k r_v r_c r_l r_r)) = Node r_k r_v r_c (Node p_k p_v p_c l r_l) r_r

rotateRight :: Tree k v -> Tree k v
rotateRight p@(Node p_k p_v p_c (Node l_k l_v l_c l_l l_r) r) = Node l_k l_v l_c l_l (Node p_k p_v p_c l_r r)

depth tree = depth' tree 0
  where depth' Leaf             d = d
        depth' (Node _ _ _ l r) d = max (depth' l (d + 1)) (depth' r (d + 1))
        max a b = if a > b then a else b





tree = foldl f Leaf $ reverse [1..10]
  where f t x = insert x (x * x) t
