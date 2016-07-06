module Counter where

import Prelude hiding ((>>=), return)
import Control.Monad
import Control.Applicative

data Counter a = Count a
instance (Show a) => Show (Counter a) where
  show (Count x) = "<" ++ show x ++ ">"

count :: (Counter a) -> a
count (Count x) = x

instance Functor Counter where
  fmap f (Count a) = Count (f a)
  
instance Applicative Counter where
  pure x = Count x
  Count f <*> Count x = Count (f x)
  
instance Monad Counter where
  return x = Count x
  m >>= f = f (count m)

inc = Count . ((+) 1)

add :: Num a => Counter a -> Counter a -> Counter a
--add m1 m2 = m1 >>= (\c1 -> m2 >>= (\c2 -> return (c1 + c2)))
add m1 m2 = do
  c1 <- m1
  c2 <- m2
  return (c1 + c2)
