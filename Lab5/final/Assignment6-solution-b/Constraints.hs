module Constraints
where

import Domain

allConstraints :: Constraint
allConstraints = rowConstraint ++ colConstraint ++ boxConstraint

rowConstraint :: Constraint
rowConstraint = [[(row, col) | col <- [1..9]] | row <- [1..9]]

colConstraint :: Constraint
colConstraint = [[(row, col) | row <- [1..9]] | col <- [1..9]]

boxConstraint :: Constraint
boxConstraint = [[(y,x)| x <- xb, y <-yb] | xb <- boxes, yb <- boxes] where
  boxes = [[1..3],[4..6],[7..9]]
