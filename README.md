# Wiser Dicer

A Strategy based Board Game in Haskell.
Where the initial configuraton of dice is given and one 
final configuration of the dice is also given we have to move the dice in such a way that at the final position the value at the top of the dice matches with the final configuration.Congrats You cleared the first level of this game.

## Contents-
* Description
* Installation
* How to Play
* Contributors

### Description

* Language - Haskell
* Compiler - ghc
* Text Editor - Sublime text
* Building and packaging - Cabal
* Documentation - Haddock
* Graphics Library - Gloss

### Installation Instructions

* Install Haskell Platform on your system. Installation instructions can be found [here](https://www.haskell.org/platform/)
* Clone the repository, using

 ```
 $ git clone https://github.com/IITH-SBJoshi/Wiser-Dicer
 ```

* Change the working directory to that of the cloned repository

```
$ cd Wiser-Dicer
```
* Configure using Cabal

```
$ cabal configure
```
* Install using Cabal

```
$ cabal install
```

* Execute
```
$ cabal run
```
#### Alternative

* Install Haskell Platform on your system. Installation instructions can be found [here](https://www.haskell.org/platform/)
* Clone the repository, using

 ```
 $ git clone https://github.com/IITH-SBJoshi/Wiser-Dicer
 ```
* Download cabal using

```
 $ brew install cabal
 ```
 
* Download Gloss using 

```
 $ cabal install gloss
```

* Change the working directory to that of the cloned repository

```
$ cd Wiser-Dicer
```
* Change the working directory to either src (for 2 player) or src_one_player (for 1 player)

```
$ cd src 
```
or

```
$ cd src_one_player 
```

* Compile using ghc

```
$ ghc Main.hs
```

* Execute
```
$ ./Main
```


### How to Play-

* White - die, Green - target

* The center value represents the top side value of the die.
The up, down, left and right values represents the respective values on die sides.
* Move using arrow keys, change map using shift (for 2 player) and enter (for 1 player), press space when game won to change map

### Contributors-
* Sudhanshu Chawhan.
* Siddharth Shrivastava.
* Rajkumar Naidu.
