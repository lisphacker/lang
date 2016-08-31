module Counter where

import Prelude hiding ((>>=), return)
import Control.Applicative (Applicative(..))
import Control.Monad       (liftM, ap, return, (>>=))
import Control.Monad.Trans.State

data Counter a = Counter a
               
instance (Show a) => Show (Counter a) where
  show (Counter x) = "<" ++ show x ++ ">"

{-
instance Functor Counter where
  fmap f (Counter x) = Counter (f x)

instance Applicative Counter where
  pure x = Counter x
  Counter f <*> Counter x = Counter (f x)
-}

instance (Num a) => Monad (State Counter) where
  return x -> state (\s -> (

zero = Counter 0

add1 = ((+) 1)
