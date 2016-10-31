module Tick where

import Control.Monad.State

zero = state 0 0

tick :: State Int Int
tick = do n <- get
          put (n+1)
          return n
