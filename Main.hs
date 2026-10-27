module Main where

import qualified Data.Map as Map
import System.IO (hSetBuffering, stdout, BufferMode(NoBuffering))
import Text.Read (readMaybe)

type NodeId = String 
 
data Choice = Choice {choiceText :: String, choiceNext :: NodeId}

data Node = Node {nodeText :: String, nodeChoices :: [Choice]}

type Story = Map.Map NodeId Node


story :: Story
story = Map.fromList
    []

-- Here is where the meat of our game will go. IDK how to do that. Will youtube or ask Claude.
-- In ghci, if you load Main.hs and then type "main", it should print out the title and then thats it.









main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStrLn "Haskell Space Savers!"