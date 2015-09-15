module Vector where

class Vector v where
    vmod :: (Num a) => v -> a

data Vector2D = Vector2D {
      x :: Float
    , y :: Float
} deriving Show

instance Vector Vector2D where
    vmod (Vector2D x y) = x * x + y * y

v1 = Vector2D 10 20
