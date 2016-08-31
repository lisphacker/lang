module Possibly where

data Possibly a = Exactly a | Unknown

instance Monad Possibly where
  (Exactly a) >>= f = f a
  Unknown     >>= f = Unknown
  return            = Exactly

  (>>) = (*>)
  fail _              = Nothing
