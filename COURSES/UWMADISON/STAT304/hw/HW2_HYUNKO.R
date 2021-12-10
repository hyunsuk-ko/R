# Name: HYUN KO
# Email: hko26@wisc.edu

rm(list = ls())

four.in.a.row = function(player, v, debug=FALSE) {
  if (debug) {
    cat(sep="", "four.in.a.row(player=", player, ", v=", v, ")\n")
  }
  count = 0
  for (i in 1:length(v)) {
    if (player == v[i]) {
      count = count + 1
    }
    else {
      count = 0
    }
    
    if (count == 4) {
      return(TRUE)
    }
  }
  return(FALSE)
}


won = function(player, board, r, c, debug=FALSE) {
  if (debug) {
    cat(sep="", "won(player=", player, ", board=\n")
    print(board)
    cat(sep="", ", r=", r, ", c=", c, ")\n")
  }
  
  row = board[r , ]
  column = board[ , c]
  diagonal = board[row(board) - col(board) == r - c]
  rev.diagonal = board[row(board) + col(board) == r + c]

  return(
      all(four.in.a.row(player, row)) |
      all(four.in.a.row(player, column)) |
      all(four.in.a.row(player, diagonal)) |
      all(four.in.a.row(player, rev.diagonal))
  ) 
}


largest.empty.row = function(board, col, debug=FALSE) {
  if (debug) {
    cat(sep="", "largest.empty.row(board=\n")
    print(board)
    cat(sep="", ", col=", col, ")\n")
  }
  
  lookup = board[ , col]
  result = 0
  for (letter in lookup) {
    if (letter == "E") {
      result = result + 1
    }
    else {
      break
    }
  }
  return(result) 
}

source("HW2test.R") # Run tests on the functions above.


row = 6
column = 7

x = rep(x = 1:7, each = 6)
y = rep(x = 1:6, times = 7)

plot(x,y,xlim = c(0,8), ylim = c(7,0), type="n")

x0 = c(seq(0.5, column + 0.5), rep(0.5, column))
y0 = c(rep(0.5, column + 1), seq(0.5, row + 0.5))
x1 = c(seq(0.5, column + 0.5), rep(7.5, column))
y1 = c(rep(6.5, column + 1), seq(0.5, row + 0.5))
segments(x0, y0, x1, y1)

board = matrix(rep("E", times=42), nrow=6, ncol=7)

player = "X"
for (i in 1:42) {
  if (player == "X") {
    repeat {
      index = identify(x, y, n = 1, plot = FALSE, tolerance = 0.8) #plot = FALSE: hide the index
      col = x[index]
      row = y[largest.empty.row(board,col)]
      # a user click in a column indicates that a checker should
      # go to that column's lowest empty row (unless the column is full)
      
      if (largest.empty.row(board,col) == 0) {
        text(x=4,y=7,labels="The column is full.", col="red");
      } 
      else{
        if (board[row, col] == "E") {
          break
        }
      }
    }
  }
  
  else{
    index_empty_square = which(c(board) == "E") # computer should click empty box.
    open = length(index_empty_square)
    index = index_empty_square[sample.int(open, size=1)]
    col = x[index]
    row = y[largest.empty.row(board,col)]
  }
  
  board[row, col] = player
  text(x = col, y = row, labels = player)
  
  cat(sep = "", "i = ", i, ", player = ", player, ", index = ", index,
      ", row = ", row, ", col = ", col, ", board:", "\n")
  print(board)

  if (won(player, board, row, col, debug = TRUE)) { #already win?
    text(x = 2, y = 1/3, labels = paste(player, " won!"), col = "red") #announce the winner on the top
    break #quit
  }
  
  player = ifelse(test = (player == "X"), yes = "O", no = "X")
}



# Note that a user click in a column indicates that a checker should
# go to that column's lowest empty row (unless the column is full).

# Note that you should implement a computer player. At the least, it
# should choose randomly from among the non-full columns. (Feel free
# to do much more!)
