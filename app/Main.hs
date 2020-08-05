module Main where

import BF (brainfuck)

main :: IO ()
main = do
    prog <- getLine
    brainfuck prog
