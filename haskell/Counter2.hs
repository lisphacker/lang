module Counter2 where

import Control.Monad 
import System.IO

newtype Counter i a = Counter {
      inc :: i -> (a, i)
}

instance (Num i, Show i, Show a) => Show (Counter i a) where
    show c = let (x, i) = inc c 0
             in "<" ++ show x ++ ", " ++ show i ++ ">"

makeCounter x = Counter (\i -> (x, i + 1))

instance (Num i) => Monad (Counter i) where
    return x = Counter $ \i -> (x, i)
    m >>= f = Counter $ \i -> let (x, i') = inc m i
                              in inc (f x) i'

newtype CountedIO m i a = CountedIO {
      runIO :: m (Counter i a)
}

instance (Monad m) => Monad (CountedIO m i) where
    return x = CountedIO . return . Counter $ \i -> (x, i)
    m >>= f = do
      c <- m
      (f c)

makePrintableCounter x = fixIO $ Counter (\i -> (x, i + 1))

c1 = makeCounter "Hello"
c2 = makeCounter "World"

--main = do
 -- io <- Counter1 IO c1
  --return io
