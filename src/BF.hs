{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module BF
    ( brainfuck
    ) where

import System.Exit (exitSuccess)

import Control.Monad.IO.Class (MonadIO(..))
import Control.Monad.Reader (MonadReader(..), ReaderT(..), asks)
import Control.Monad.State (MonadState(..), StateT(..), evalStateT, modify)
import Text.Parsec (parse)

import AST (BF(..), bf)
import Config (Config(..), IOMode(..))

import qualified Tape as T

type Tape = T.Tape Int

blank :: Tape
blank = T.fill 0

newtype VM a = VM { runVM :: ReaderT Config (StateT Tape IO) a }
    deriving (Functor, Applicative, Monad, MonadIO, MonadState Tape, MonadReader Config)


exec :: BF -> VM ()
exec i = case i of
    Dec -> do
        modify $ T.modify pred

    Inc -> do
        modify $ T.modify succ

    Shl -> do
        modify T.left

    Shr -> do
        modify T.right

    Inp -> do
        io <- asks inputMode
        x <- liftIO $ case io of
            Chars -> fromEnum <$> getChar
            Nums  -> readLn
        modify $ T.set x

    Out -> do
        io <- asks outputMode
        x <- T.get <$> get
        liftIO $ case io of
            Chars -> putChar $ toEnum x
            Nums  -> print x

    Loop is -> do
        x <- T.get <$> get
        case x of
            0 -> return ()
            _ -> execAll is >> exec (Loop is)

    Noop -> do
        return ()

    Debug -> do
        debug <- asks isDebug
        case debug of
            False -> return ()
            True  -> liftIO $ putStrLn "debug"

    Exit -> do
        liftIO exitSuccess

execAll :: [BF] -> VM ()
execAll = mapM_ exec

brainfuck :: Config -> String -> IO ()
brainfuck cfg s = do
    let Right ast = parse bf "" s
    flip evalStateT blank $ flip runReaderT cfg $ runVM $ execAll ast
