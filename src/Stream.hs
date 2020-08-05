module Stream
    ( Stream(..)
    , repeat
    ) where

import Prelude hiding (repeat)

data Stream a = a :> Stream a
    deriving (Eq, Show)

repeat :: a -> Stream a
repeat x = x :> repeat x
