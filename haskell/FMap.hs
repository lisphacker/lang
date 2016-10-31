module FMap where

data Tree a = Node a (Tree a) (Tree a) | Nil deriving (Show)

treeMap :: (a -> b) -> Tree a -> Tree b
treeMap f Nil = Nil
treeMap f (Node a l r) = Node (f a) (treeMap f l) (treeMap f r)


t = Node 4 (Node 3 (Node 1 Nil Nil) (Node 2 Nil Nil)) (Node 6 (Node 5 Nil Nil) (Node 7 Nil Nil))
