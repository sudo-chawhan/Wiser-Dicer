module Rendering where

import Data.Array
import Game
import Maps
import Helper
import Graphics.Gloss
import Graphics.Gloss.Data.Color

makeTile :: Float -> Float -> Picture
makeTile x y = pictures [
		line[ (x , y) , (x , y + tileSize)],
		line[ (x , y) , (x + tileSize , y )],
		line[ (x + tileSize , y) , (x + tileSize , y + tileSize)],
		line[ (x , y + tileSize) , (x + tileSize , y + tileSize)]
	]

-- Use maybe as a list might not always give a Picture
wallGrid :: [(Int , Int)] -> Picture
wallGrid [] = blank
wallGrid ((x,y) : ls) = pictures [
		makeWall x y (orange),
		wallGrid ls
	] 

-- used to make a colored tile ( can be used for making any type of tile) 
makeWall :: Int -> Int -> Color-> Picture
makeWall xBlock yBlock icolor = color icolor ( polygon [(x,y),(x,y + tileSize),(x + tileSize,y + tileSize),(x + tileSize,y)])
	where 
		x = (fromIntegral xBlock) * tileSize 
		y = (fromIntegral yBlock) * tileSize 

gameGridIntial :: Int -> Picture
gameGridIntial i= pictures $ [
		-- makes a grid of n x n tile
		( makeTile x y ) | x <- [0 , tileSize.. (nF-1) * tileSize ] , y <- [0 , tileSize.. (nF-1) * tileSize ]  
	] 
	where
		wallPos = findAllAnything map0 (n-1)
		map0 = (lMap $ maps !! i)
		n = (nI $ maps !! i)
		nF = fromIntegral n


cellsOfBoard :: Board -> Cell -> Picture -> Picture
cellsOfBoard board cell cellPicture =
    pictures
    $ map (snapPictureToCell cellPicture . fst)
    $ filter (\(_, e) -> e == cell)
    $ assocs board

-- change name of this function
snapPictureToCell :: Picture -> (Int, Int) -> Picture
snapPictureToCell cellPic (xBlock,yBlock) = translate x y cellPic
	where 
		x = (fromIntegral xBlock) * tileSize
		y = (fromIntegral yBlock) * tileSize  

cellPicPlayer :: ConfigPlayer -> Picture
cellPicPlayer player = pictures [
		makeWall 0 0 white,
		translate tf tf $ scale (0.75*tileSize/100) (0.75*tileSize/100) $ topPlayer,
		color (greyN 0.5) $ translate (-tileSize/3 ) (tileSize/2.5) $ scale tf2 tf2 $  westPlayer,
		color (greyN 0.5) $ translate (tileSize + tileSize/6) (tileSize/2.5) $ scale tf2 tf2 $  eastPlayer,
		color (greyN 0.5) $ translate (tileSize/2.5) (tileSize/6 + tileSize) $ scale tf2 tf2 $  northPlayer,
		color (greyN 0.5) $ translate (tileSize/2.5) (-tileSize/3) $ scale tf2 tf2 $  southPlayer
	]	
	where
		topPlayer = makeI $ top player
		eastPlayer = makeI $ east player
		westPlayer = makeI $ west player
		southPlayer = makeI $ south player
		northPlayer = makeI $ north player
		tf = (15.0*tileSize/100)
		tf2 = (0.25*tileSize/100)


-- | converts given integer into picture with same number of dots
makeI :: Int -> Picture
makeI i =
	case i of
		1 -> makeOne
		2 -> makeTwo
		3 -> makeThree
		4 -> makeFour
		5 -> makeFive
		6 -> makeSix


-- | MAkes a Picture of one dot to represents the dice(1)
makeOne :: Picture 
makeOne = pictures[
        translate (tileSize/2) (tileSize/2) $ circleSolid radius
        ]
        where
            radius = tileSize/10
            
-- | MAkes a Picture of 2 dots to represents the dice(2)
makeTwo :: Picture
makeTwo = pictures[
        translate (tileSize/3) (2*tileSize/3) $ circleSolid radius,
        translate (2*tileSize/3) (tileSize/3) $ circleSolid radius
        ]
        where
            radius = tileSize/10            

-- | MAkes a Picture of 3 dots to represents the dice(3)
makeThree :: Picture 
makeThree = pictures[
        translate (tileSize/4) (3*tileSize/4) $ circleSolid radius,
        translate (3*tileSize/4) (tileSize/4) $ circleSolid radius,
        translate (tileSize/2) (tileSize/2) $ circleSolid radius
        ]
        where
            radius = tileSize/10        
-- | MAkes a Picture of 4 dots to represents the dice(4)
makeFour :: Picture
makeFour  = pictures[
        translate (tileSize/4) (3*tileSize/4) $ circleSolid radius,
        translate (3*tileSize/4) (tileSize/4) $ circleSolid radius,
        translate (3*tileSize/4) (3*tileSize/4) $ circleSolid radius,
        translate (tileSize/4) (tileSize/4) $ circleSolid radius
        ]
        where
            radius = tileSize/10 

-- | MAkes a Picture of 5 dots to represents the dice(5)
makeFive :: Picture
makeFive  = pictures[
        translate (tileSize/4) (3*tileSize/4) $ circleSolid radius,
        translate (3*tileSize/4) (tileSize/4) $ circleSolid radius,
        translate (3*tileSize/4) (3*tileSize/4) $ circleSolid radius,
        translate (tileSize/4) (tileSize/4) $ circleSolid radius,
        translate (tileSize/2) (tileSize/2) $ circleSolid radius
        ]
        where
            radius = tileSize/10 


-- | MAkes a Picture of 6 dots to represents the dice(6)
makeSix :: Picture
makeSix  = pictures[
        translate (tileSize/4) (2*tileSize/3) $ circleSolid radius,
        translate (tileSize/4) (tileSize/3) $ circleSolid radius,
        translate (2*tileSize/4) (2*tileSize/3) $ circleSolid radius,
        translate (2*tileSize/4) (tileSize/3) $ circleSolid radius,
        translate (3*tileSize/4) (2*tileSize/3) $ circleSolid radius,
        translate (3*tileSize/4) (tileSize/3) $ circleSolid radius
        ]
        where
            radius = tileSize/10



-- | colors and make the target cell 
cellPicTarget :: Int -> Picture
cellPicTarget targetInt = pictures [
		makeWall 0 0 green,
		translate (15.0*mf) (15.0*mf) $ scale (0.75*mf) (0.75*mf) $ makeI tInt
	]	
	where
		tInt = targetInt
		mf = tileSize/100
		
cellPicWall :: Picture
cellPicWall = pictures [
		makeWall 0 0 $ makeColorI 139 71 38 255
	]	

cellPicEmpty :: Picture
cellPicEmpty  = pictures [
		makeWall 0 0 $ makeColorI 224 238 224 255
	]	

gameGrid :: Game -> Picture
gameGrid game = pictures [
		scoreboard game,
		cellsOfBoard board Empty cellPicEmpty,
		cellsOfBoard board Wall cellPicWall,
		snapPictureToCell ( cellPicTarget (snd (finalTarget game)) ) $ fst (finalTarget game),
		cellsOfBoard board Player $ cellPicPlayer (configPlayer game),
		gameGridIntial (level game)
	]
	where
		board = gameBoard game


scoreboard :: Game ->Picture
scoreboard game = pictures [translate (2*tileSize) (-tileSize) $ scale 0.5 0.5 $ text $ "Total Moves" ++ (show $ numberOfMoves game) ]

makeFinal :: Game -> Picture -> Picture
makeFinal game pic 
	| (gameState game) == GameOver = pictures [ pic, translate (-tileSize) (-tileSize) $ scale (0.5*tileSize/100) (0.5*tileSize/100) $ text "You Won"]
	| otherwise = pic

-- change the names above
gameAsPicture :: Game -> Picture
gameAsPicture game = translate shift shift
                               	frame 
                	where
                        	frame = makeFinal game $ gameGrid game
                        	n = nI $ maps !! (level game) 
                        	shift = (-1)*(fromIntegral n)/2 * tileSize
