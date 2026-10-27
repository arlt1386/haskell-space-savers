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
    [("start", Node "You are flying your ship near the fourth sector of the andromeda galaxy. Suddenly the ships sensors pick up an emergency hail."
        [Choice "Re-route to the hailing coordinates" "re-route",
         Choice "Ignore the hail and fly on." "cowardEnding"]), 
         
     ("cowardEnding", Node "You silence the call and fly on into space like a coward. THE END."
        []),

     ("re-route", Node "You enter the new coordinates into your ship's navigation and activate your FTL drive. 
     Space bends around and your ship travels the lightways. You come out of the lightway and see a disabled ship floading in the orbit of Sigma-4, a lush green planet."
        [Choice "Fly to the ship in your docking craft and enter." "shipArrival",
         Choice "Fly to the planet where the emergency hail is coming from." "planetArrival"]),
        
        
    
    
    ]

-- Here is where the meat of our game will go. IDK how to do that. Will youtube or ask Claude.
-- In ghci, if you load Main.hs and then type "main", it should print out the title and then thats it.









main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStrLn "Haskell Space Savers!"