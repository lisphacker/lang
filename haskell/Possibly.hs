module Possibly where

import Control.Monad (fmap)
import Control.Applicative (pure, (<*>))
data Possibly a = Exactly a | ItsAMystery
                deriving Show

instance Functor Possibly where
  fmap f (Exactly a) = Exactly (f a)
  fmap f ItsAMystery = ItsAMystery

instance Applicative Possibly where
  pure a = Exactly a
  
  Exactly f <*> Exactly a = Exactly (f a)
  _ <*> _ = ItsAMystery

instance Monad Possibly where
  return a = Exactly a
  Exactly a >>= f = f a
  ItsAMystery >>= f = ItsAMystery
