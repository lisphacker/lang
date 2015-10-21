module MaxSubArray where

maxSubArray l = fst (mxSA l)
    where mxSA [] = (0, 0)
          mxSA (x:xs) = if null xs then
                            (x, x)
                        else
                            let (maxSoFar, maxEndingHere) = mxSA xs
                                maxEndingHere2 = max x (x + maxEndingHere)
                                maxSoFar2 = max maxSoFar maxEndingHere2
                            in (maxSoFar2, maxEndingHere2)

a = [31,-41,59,26,-53,58,97,-93,-23,84]
