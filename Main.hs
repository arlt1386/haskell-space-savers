-- Haskell Text Based Adventure Game
-- Authors: Susanna Arlt, Rohan Hari
-- Date Modified: 11/02/2026

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


-- Here is where the meat of our game will go. IDK how to do that. Will youtube it.

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

    --Section for Ship Arrival story (it will go into the planetArrival node when you leave the ship.):
    ("shipArrival", Node "You fly your docking craft to the open port on the ship. You successfully enter the ship. It looks empty but you feel like you're being watched."
        [Choice "Explore the dark ship" "explore",
         Choice "Too spooky, call it quits." "leaveShip"]),

    ("explore", Node "You cautiously walk down the dark entrance, when suddenly, a zombified survivor falls off of the ceiling!"
       [Choice "Eek! I can't do this anymore!" "leaveShip",
        Choice "Nothing I can't handle: shoot alien before it hits the ground" "shipMonster"]),

    ("shipMonster", Node "You bravely and calmly shot the alien, this doesn't phase you; You do this on the regular. Now, what are you here for?"
       [Choice "I want to look around to see if I can find anything valuble." "shipMonster2",
        Choice "I want to try to recover the ship, let's check the controls" "engine"]),
     
    ("shipMonster2", Node "You take a right turn down a long corridor that seems like it would be too big for the ship, and before \
    \you could think about it, a mangled alien-leopard jumps into you and feasts upon you. THE END"
      []),
      
    ("engine", Node "You're familiar with this make of ship so you know where the engine controls are located. You jump over the paralyzed alien \
    \ body and hang a left into a room full of blinking lights and a burnt hair smell. All of the control panels are fried, it's no use to try to fix it."
      [Choice "I want to keep looking to see if I can find anything" "shipMonster2",
       Choice "Nothing here is of use to me." "leaveShip"]),

    ("leaveShip", Node "You quickly leave this mess of a ship and take off in your own, careful as to not even look behind you. You think to yourself, \
    \ 'Something about that place feels off.' You get back on the path to arrive at the planet with emergency hail"
      [Choice "Pick up the pace!" "planetArrival",
       Choice "Let's take our time..." "planetArrival"]),

    --Section for Planet Arrival story:
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

    ("shootMonster", Node "You fire your lazgun at the monster. Hitting one of its grotesque eyes. It sends out a psychic beam as it roars. You and the survivors are all \
    \stunned. It now starts to charge."
        [Choice "Roll out of the way and continue shooting." "rollShoot",
         Choice "Throw flame bomb at the monsters eyes." "flameBomb"]),

    ("jumpDitch", Node "You jump into the ditch and fire at the mosnter along with the survivors. The monster is overwhelmed by the sheer number of attackers. It sends out a \
    \psychic shreek that stuns all of you. It then starts to charge."
        [Choice "Roll out of the way and continue shooting." "rollShoot",
         Choice "Throw flame bomb at the monsters eyes." "flameBomb"]),

    ("shootSelf", Node "You draw the lasgun from your hip. The barrel is cold against your chest, and for one long heartbeat you feel it pulse against the muzzle. \
    \You squeeze the trigger. White fire floods your chest, and then the pain thins and fades. A terrible stillness settles over you, and the din of the battlefield \
    \drains away like a tide going out. THE END."
        []),

    ("groupArrival", Node "You arrive to the location of the beacon and find a group of survivors huddled in a ditch. They tell you to watch out for the \
    \monster in the woods. You hear a noise behind you. As you turn around you see a hideous monster with a large number of grotesque eyes."
        [Choice "Shoot the monster." "shootMonster",
         Choice "Jump into ditch and then fire on the monster with the survivors." "jumpDitch"]),

    ("rollShoot", Node "You roll out of the charging monstors path. You, along with the survivors continue shooting at the monster. The multiple incomming attacks daze and \
    \confuse the monster. As you all fire your last rounds into the monster, it falls with a dying whimper. You all cheer and the commander of the survivors comes towards you \
    \to thank you for your help. He then asks if you are able to take them back to their ship."
        [Choice "Rob the survivors." "robSurvivors",
         Choice "Agree to help the survivors back to their ship." "helpSurvivors"]),

    ("flameBomb", Node "As you ignite the hard metal tube, you aim and throw it at the monster. The bomb erupts into a large ball of fire, it coats the monster in sticky napalm. \
    \The scream of the monster is ear piercing. you all take the oportunity to fire and as the monster dies, it is over quickly. You all cheer and the survivors come to thank \
    \you for the help. The commander comes to you and ask for your help returning to their ship."
        [Choice "Rob the survivors." "robSurvivors",
         Choice "Agree to help the survivors back to their ship." "helpSurvivors"]),

    ("robSurvivors", Node "As you aim your weapon at the survivors at the commander and demand their loot, you hear a click behind you before you feel a searing pain in your back. \
    \The blast hit you in the spine and as you bleed out on the ground, the commander looks down at you in disappointment. \"There is a sufficiency in the world for man's need but not for man's greed.\" THE END."
        []),

    ("helpSurvivors", Node "You lead the survivors back to your ship and fly them back to their ship. You help them make the needed repairs to their ship. A few days later, their galactic cruiser is back \
    \up and running. The commander offers you to come with them back to their planet."
        [Choice "Agree to follow them to their planet." "followSurvivors",
         Choice "Refuse politely and continue on your own." "continueSolo"]),

    ("followSurvivors", Node "After you arrive at the planet, the commander reveals to you that they are actually the emperor of this planet. They bring you to the palentine hill and a triumph is held in \
    \your honor. You are then showered with land and riches. You will never have to want for anything again. CONGRADULATIONS! THE END."
        [])
    ]


-- Here is the engine that will run the story we make. It is how we show each node contents and the option of which node to go to next.
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
