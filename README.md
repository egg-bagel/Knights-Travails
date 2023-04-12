# Knights-Travails
Knight's Travails exercise from TOP Ruby course

In this exercise, I built a function called knight_moves that shows the shortest possible route for a knight to get from one square to another on a chess board. The function outputs every square the knight stops at on its path.

I used a two-queue system to keep track of how many moves the knight makes. This was a tip I found somewhere on the internet. The next_queue array holds all the potential moves that can be made from the current square. On the next move or turn, after all moves in the current queue have been explored, next_queue becomes the main queue, and next_queue is cleared. All the potential moves from the last turn become the current moves being evaluated, and their potential next moves are placed in next_queue. The move count is incremented every time the queues are switched.

The hardest part of this exercise was figuring out how to keep track of the knight's path. Initially, Knight was the only class I created, and I was using simple sets of coordinates [x, y] to track the knight's position on the board. This wasn't adequate because it did not give me a way to trace the knight's movement. So I ended up creating a Board class and a Square class as well. The board object is made up of square objects, and each square object contains instance variables for its coordinates as well as its parent square. While every square could have multiple legal parent squares, I am only interested in which square the knight actually came from to reach the new square, so that is the one that I saved as the parent. By turning the sets of coordinates into objects that store data, I was able to keep track of information about the knight's movement across the board and reconstruct the path once the knight reached the destination. 