module Main where

import System.IO (IOMode(..), hGetContents, openFile, stdin)

import BF (brainfuck)
import Config (Config(..))
import Options (configIO)

main :: IO ()
main = do
    cfg <- configIO
    prog <- hGetContents =<< case source cfg of
        Nothing -> return stdin
        Just p  -> openFile p ReadMode
    brainfuck cfg prog
