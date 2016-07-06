module Inherit where

class MakesSound a where
  makeSound :: a -> String

data Animal = Dog | Cat

instance MakesSound Animal where
  makeSound Dog = "bow wow"
  makeSound Cat = "mew mew"
