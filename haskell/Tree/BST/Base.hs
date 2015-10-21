{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

module Base where

data BSTNode k a = Empty | BSTNode k a (BSTNode k a) (BSTNode k a)
              deriving Show

key   (BSTNode k _ _ _) = k
value (BSTNode _ v _ _) = v
left  (BSTNode _ _ l _) = l
right (BSTNode _ _ _ r) = r

empty = Empty
singleton k v = BSTNode k v Empty Empty

null Empty             = True
null (BSTNode _ _ _ _) = False

class BST k a where
    insert :: k -> a -> BSTNode k a -> BSTNode k a
    delete :: k -> BSTNode k a -> BSTNode k a
    lookup :: k -> BSTNode k a -> Maybe a
