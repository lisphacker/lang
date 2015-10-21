{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

module Simple where

import Prelude hiding (null, lookup)
import Base 

instance (Show k, Ord k) => BST k v where
    insert k v Empty                 = singleton k v
    insert k v n@(BSTNode kn vn l r) = if k < kn then
                                           BSTNode kn vn (insert k v l) r
                                       else
                                           if k > kn then
                                               BSTNode kn vn l (insert k v r)
                                           else
                                               error ("Key " ++ show k ++ " already present in tree")

    delete k n = Empty

    lookup k Empty                 = Nothing
    lookup k n@(BSTNode kn vn l r) = if k == kn then
                                         Just vn
                                     else
                                         if k < kn then
                                             lookup k l
                                         else
                                             lookup k r

                                     
