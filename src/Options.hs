module Options
    ( configIO
    ) where

import System.Console.GetOpt (OptDescr(..), ArgDescr(..), ArgOrder(..), getOpt)
import System.Environment (getArgs)

import Config (IOMode(..), Config(..), defaultConfig)

data Flag
    = Debug
    | FileName String
    | InputMode IOMode
    | OutputMode IOMode
    deriving (Eq, Show)

options :: [OptDescr Flag]
options =
    [ Option "d" ["debug", "debug-on"]
        (NoArg Debug)
        "Enable debug mode"
    , Option "f" ["file", "file-name"]
        (ReqArg FileName "filename")
        "File from which to read the program"
    , Option "i" ["input", "input-mode"]
        (ReqArg (\s -> InputMode $ case s of { "nums" -> Nums; _ -> Chars }) "mode")
        "Select numerical or UTF-8 input"
    , Option "o" ["output", "output-mode"]
        (ReqArg (\s -> OutputMode $ case s of { "nums" -> Nums; _ -> Chars }) "mode")
        "Select numerical or UTF-8 output"
    ]

configUpdate :: Flag -> Config -> Config
configUpdate f c = case f of
    Debug        -> c { isDebug = True }
    FileName p   -> c { source = Just p }
    InputMode m  -> c { inputMode = m }
    OutputMode m -> c { outputMode = m }

flags :: [String] -> [Flag]
flags argv = os
    where (os,_,_) = getOpt Permute options argv

config :: [Flag] -> Config
config = foldr id defaultConfig . map configUpdate

configIO :: IO Config
configIO = config . flags <$> getArgs
