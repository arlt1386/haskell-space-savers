module Main where

import qualified Data.Map as Map
import System.IO (hSetBuffering, stdout, BufferMode(NoBuffering))
import Text.Read (readMaybe)

type NodeId = String 
 
data Choice = Choice 
    {choiceText :: String
    , choiceNext :: NodeId
    }

data Node = Node 
    {nodeText :: String
    , nodeChoices :: [Choice]
    }

type Story = Map.Map NodeId Node


-- Here is where the meat of our game will go. IDK how to do that. Will youtube or ask Claude.
-- In ghci, if you load Main.hs and then type "main", it should print out the title and then thats it.

story :: Story
story = Map.fromList
    [("start", Node "You are flying your ship near the fourth sector of the andromeda galaxy. Suddenly the ships sensors pick up an emergency hail."
        [Choice "Re-route to the hailing coordinates." "re-route",
         Choice "Ignore the hail and fly on." "cowardEnding"]), 
         
     ("cowardEnding", Node "You silence the call and fly on into space like a coward. THE END."
        []),

     ("re-route", Node "You enter the new coordinates into your ship's navigation and activate your FTL drive. Space bends around and your ship travels the lightways. \
     \You come out of the lightway and see a disabled ship floating in the orbit of Sigma-4, a lush green planet."
        [Choice "Fly to the ship in your docking craft and enter." "shipArrival",
         Choice "Fly to the planet where the emergency hail is coming from." "planetArrival"]),

     ("planetArrival", Node "You successfully land on the planet. The homing beacon is 5 clicks to the north. Do you take your speeder or walk?"
        [Choice "Walk to the homing beacon." "walk",
         Choice "Take the speeder." "speeder"]),

     ("walk", Node "You start walking toward the beacon. Lazgun hanging on your hip. As you walk on the path, you suddenly hear a rustle in the bushes."
        [Choice "Continue walking." "walkingPastBush",
         Choice "Shoot into the bush." "shootBush",
         Choice "Shoot yourself." "shootSelf"]),

    ("speeder", Node "You ride your speeder toward the beacon. You arrive quickly and find a group of survivors huddled in a ditch. They tell you to watch out for the \
    \monster in the woods. You hear a noise behind you. As you turn around you see a hideous monster."
        [Choice "Shoot the monster." "shootMonster",
         Choice "Jump into ditch and then fire on the monster with the survivors." "jumpDitch",
         Choice "Shoot yourself." "shootSelf"])
        
        
    
    
    ]


-- Down here is where the "engine" of the game will go. Some way to display a node, ask player for input choice, and loop through the nodes. IDK this either.








main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStrLn "Haskell Space Savers!"