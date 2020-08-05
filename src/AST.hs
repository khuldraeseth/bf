module AST
    ( BF(..)
    , bf
    ) where

import Control.Applicative ((<|>), (<*), (*>), many)
import Text.Parsec.Char (anyChar, char)
import Text.Parsec.Combinator (choice)
import Text.Parsec.String (Parser)

data BF
    = Dec
    | Inc
    | Shl
    | Shr
    | Inp
    | Out
    | Loop [BF]
    | Noop
    | Debug
    | Exit
    deriving (Eq, Show)

bf :: Parser [BF]
bf = many atom
    where atom = choice [dec, inc, shl, shr, inp, out, loop, debug]

dec :: Parser BF
dec = Dec <$ char '-'

inc :: Parser BF
inc = Inc <$ char '+'

shl :: Parser BF
shl = Shl <$ char '<'

shr :: Parser BF
shr = Shr <$ char '>'

inp :: Parser BF
inp = Inp <$ char ','

out :: Parser BF
out = Out <$ char '.'

loop :: Parser BF
loop = Loop <$> inner
    where inner = char '[' *> bf <* char ']'

debug :: Parser BF
debug = Debug <$ char '!'
