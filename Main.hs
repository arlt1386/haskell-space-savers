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

    --Section for Ship Arrival story:
    

    --Section for Planet Arrival story:
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

    ("walkingPastBush", Node "As you continue walking, the rustling gets louder. As you take one last glace, the last thing you see is the fangs of a Shadow Tiger as it \
    \clamps its jaws around your throat. THE END."
        []),

    ("shootBush", Node "As you fire into the rustling bush, you hear the terrrible scream of a Shadow Tiger. You realize you were mere moements away from death."
        [Choice "Continue..." "groupArrival"]),

    ("speeder", Node "You ride your speeder toward the beacon. You arrive quickly and find a group of survivors huddled in a ditch. They tell you to watch out for the \
    \monster in the woods. You hear a noise behind you. As you turn around you see a hideous monster with a large number of grotesque eyes."
        [Choice "Shoot the monster." "shootMonster",
         Choice "Jump into ditch and then fire on the monster with the survivors." "jumpDitch",
         Choice "Shoot yourself." "shootSelf"]),

    ("shootMonster" Node "You fire your lazgun at the monster. Hitting one of its grotesque eyes. It sends out a psychic beam as it roars. You and the survivors are all \
    \stunned. It now starts to charge."
        [Choice "Roll out of the way and continue shooting." "rollShoot",
         Choice "Throw flame bomb at the monsters eyes." "flameBomb"]),

    ("jumpDitch" Node "You jump into the ditch and fire at the mosnter along with the survivors. The monster is overwhelmed by the sheer number of attackers. It sends out a \
    \psychic shreek that stuns all of you. It then starts to charge."
        [Choice "Roll out of the way and continue shooting." "rollShoot",
         Choice "Throw flame bomb at the monsters eyes." "flameBomb"]),

    ("shootSelf", Node "You draw the lasgun from your hip. The barrel is cold against your chest, and for one long heartbeat you feel it pulse against the muzzle. \
    \You squeeze the trigger. White fire floods your chest, and then the pain thins and fades. A terrible stillness settles over you, and the din of the battlefield \
    \drains away like a tide going out. THE END."
        []),

    ("groupArrival" Node "You arrive to the location of the beacon and find a group of survivors huddled in a ditch. They tell you to watch out for the \
    \monster in the woods. You hear a noise behind you. As you turn around you see a hideous monster with a large number of grotesque eyes."
        [Choice "Shoot the monster." "shootMonster",
         Choice "Jump into ditch and then fire on the monster with the survivors." "jumpDitch"]),

    ("rollShoot" )

    ]

    
        
        




showNode :: Node -> IO ()
showNode node = do
    putStrLn ""
    putStrLn (nodeText node)
    putStrLn ""
    mapM_ showChoice (zip [1..] (nodeChoices node))

showChoice :: (Int, Choice) -> IO ()
showChoice (i, c) = putStrLn (show i ++ ") " ++ choiceText c)

askChoice :: [Choice] -> IO NodeId
askChoice choices = do
    putStr "> "
    input <- getLine
    case readMaybe input of
        Just n | n >= 1 && n <= length choices ->
            return (choiceNext (choices !! (n - 1)))
        _ -> do
            putStrLn "Please enter a number from the list."
            askChoice choices

play :: Story -> NodeId -> IO ()
play s nid = case Map.lookup nid s of
    Nothing -> putStrLn ("[Story error: missing node \"" ++ nid ++ "\"]")
    Just node -> do
        showNode node
        if null (nodeChoices node)
            then putStrLn "Thanks for playing!"
        else do
            next <- askChoice (nodeChoices node)
            play s next


main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStrLn "Haskell Space Savers!"
    play story "start"