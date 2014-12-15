module Graph where

import Data.Graph.Inductive
import Control.Applicative
import Data.Char (toLower)
import Data.List (find)
import Data.Map (Map, fromList, findWithDefault)
import Data.Maybe (fromMaybe, listToMaybe)
import Text.ParserCombinators.Parsec
import Parse
import Places
import Dictionary (Direction)

nodeFromPlace :: Place -> LNode Place
nodeFromPlace place = (num place, place)

edgesFromPlace :: Place -> [LEdge Direction]
edgesFromPlace place = map (\x -> (num place, node x, direction x)) (exits place)

createGraph :: [ Place ] -> Gr Place Direction
createGraph places = mkGraph (map nodeFromPlace places)
                             (concatMap edgesFromPlace places)

maybeFindNode :: Direction -> [LEdge Direction] -> Maybe Node
maybeFindNode direction edges = 
  let sameDirection x (_, _, y) = x == y 
      newNode (_, x, _) = x in
  newNode <$> find (sameDirection direction) edges


-- This takes a node and direction and the graph, and tries to follow 
-- the direction to another node in the graph. If it fails, error message.
-- Is there a more Haskell-y way to write this?
findNodeByDirection :: Node -> Direction -> Gr Place Direction -> 
  Either String Node
findNodeByDirection oldNode direction graph = 
  let maybeNode = maybeFindNode direction $ out graph node in
  case maybeNode of
    Nothing      -> Left "You can't go that way."
    Just newNode -> Right newNode

