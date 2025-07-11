extends Node

#States for various game components
#This is for a very bare bones state machine to determine various behaviours dependant on the state
#set on an object

#Declare Variables

#Ball States
# Docked = bound to the paddle
# Launched = pressed Space to launch ball
# Undocked = ball is in play
var ball_state = "Docked"

#Brick States
# States are for the colours to assist with score adjustment
# Acceptable states are Red, Yellow, Orange, Green, DkGrey, DkBlue, DkPurple, Blue, and Grey as a
# default state (which may be used for indestructible grey bricks at some point)
var brick_state = "Grey"