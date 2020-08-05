module Tape
    ( Tape(..)
    , get
    , set
    , modify
    , left
    , right
    , fill
    ) where

import Stream (Stream(..))
import qualified Stream as S

data Tape a = Tape (Stream a) a (Stream a)
    deriving (Eq, Show)

get :: Tape a -> a
get (Tape _ x _) = x

set :: a -> Tape a -> Tape a
set x (Tape ls _ rs) = Tape ls x rs

modify :: (a -> a) -> Tape a -> Tape a
modify f t = set x t
    where x = f $ get t

left :: Tape a -> Tape a
left (Tape (l :> ls) c rs) = Tape ls l (c :> rs)

right :: Tape a -> Tape a
right (Tape ls c (r :> rs)) = Tape (c :> ls) r rs

fill :: a -> Tape a
fill x = Tape (S.repeat x) x (S.repeat x)
