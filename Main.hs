module Main where

import qualified Data.Map as Map
import System.IO (hSetBuffering, stdout, BufferMode(NoBuffering))
import Text.Read (readMaybe)

-- Here is where the meat of our game will go. IDK how to do that.
-- In ghci, if you load Main.hs and then type "main", it should print out the title and then thats it.









main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStrLn "Haskell Space Savers!"