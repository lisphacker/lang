maxSequence :: [Int] -> Int
maxSequence lst = fst (maxSequence2 lst) where
    maxSequence2 []     = (0, 0)
    maxSequence2 (x:xs) = let t = maxSequence2 xs
                              m1 = fst t
                              m2 = snd t
                              m3 = max(0, x + m2)
                              m4 = max(m1, m3)
                          in
                            (m4, m3)
