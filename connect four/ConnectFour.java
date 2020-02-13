/*  Name: Chanmin Park
 *  PennKey: ddpp
 *  Recitation: 217
 *
 *  Execution: java ConnectFour
 *
 *  Executes a game of Connect4. The game has 1-player and 2 player modes. 
 *  Click on desired column to add new piece in. The player who first gets 
 *  four in a row horizonontally, vertically, or diagonally wins. 
 *
 */
import java.awt.Color;

public class ConnectFour {
    
    // radius of a Piece and also half width of a square
    public static final double RADIUS = 0.05;
    
    // create an array of columns
    private static Column[] columns = new Column[7];
    
    public static Column[] getColumns() {
        return columns;
    }
    
    public static void main(String[] args) {
        PennDraw.enableAnimation(5);
        
        // boolean to check whether the game is in 1 player or 2 player mode
        boolean isOnePlayer;
        
        // boolean to check whether game has started
        boolean startGame;
        
        // boolean to check whether game is over
        boolean isGameOver;
        
        // counts how many pieces has been added into the grid 
        int numPieces;
        
        // array of Pieces - used to draw them in the grid 
        Piece[] pieces;
        
        while (true) {
            isOnePlayer = false; 
            startGame = false;
            isGameOver = false;
            numPieces = 0;
            
            pieces = new Piece[42];
            
            // sets each column in the columns array with x location and index
            for (int i = 0; i < columns.length; i++) {
                columns[i] = new Column(0.2 + i * 0.1, i);
            }
            
            startScreen();
            
            // if user clicks which mode to play, draw grid and start game
            while (startGame == false) {
                if (PennDraw.mousePressed()) {
                    while (PennDraw.mousePressed()) {
                        // prevent multiple clicks
                    }
                    PennDraw.clear(); 
                    drawGrid();
                    PennDraw.advance();
                    
                    double y = PennDraw.mouseY();
                    
                    if (y > 0.5) {
                        isOnePlayer = true; 
                    } else {
                        isOnePlayer = false;
                    }
                    startGame = true; 
                }
            }
            
            // executes 2 player mode 
            while (!isOnePlayer && startGame && !isGameOver) {
                PennDraw.clear(); 
                drawGrid();
                
                if (PennDraw.mousePressed()) {
                    while (PennDraw.mousePressed()) {
                        // prevent multiple clicks
                    }
                    double xClick = PennDraw.mouseX();
                    
                    // if mouse click was on a column, assign variables 
                    if (xClick <= 0.85 && xClick > 0.15) {
                        
                        // assign column to one in the columns array
                        Column col = columns[getColIndex(xClick)];
                        
                        // alternate color with each turn
                        Color c = PennDraw.BLUE;
                        if (numPieces % 2 == 0) {
                            c = PennDraw.RED;
                        }
                        
                        // if column is not filled, add new piece and draw all
                        // the pieces that have been added to the grid 
                        if (col.getIter() < 6) {
                            
                            Piece newPiece = addNewPiece(c, col);
                            
                            pieces[numPieces++] = newPiece;
                            drawAll(pieces, numPieces);
                            PennDraw.advance();
                            
                            // if the new piece completes a four in a row, 
                            // display winner and end game 
                            if (newPiece.checkFour()) {
                                displayWinner(newPiece);
                                PennDraw.advance();
                                isGameOver = true;
                            }
                            
                            // if the new piece is the last piece to be added, 
                            // declare a tie and end game
                            if (numPieces == 42) {
                                displayTie();
                                PennDraw.advance();
                                isGameOver = true;
                            }
                            
                            // if game is not over, display whose turn it is 
                            if (isGameOver == false) {
                                displayTurn(newPiece);
                                PennDraw.advance();
                            }
                        }
                    }
                }
            }
            
            // booleans to be used only if user clicks on 1 player mode 
            
            // boolean that checks whether it's the first time through the while
            // loop
            boolean isFirstTime = true;
            
            // boolean to check whose turn it is
            boolean playerTurn = false;
            
            // boolean to check whether computer starts or player starts 
            boolean compStart;
            if (Math.random() > 0.5) {
                compStart = true;
            } else {
                compStart = false;
            }
            
            // executes 1 player mode 
            while (isOnePlayer && startGame && !isGameOver) {
                PennDraw.clear();
                drawGrid();
                
                // computer's turn
                if ((!isFirstTime || compStart) && !playerTurn) {
                    Color c = PennDraw.BLUE;
                    
                    if (numPieces % 2 == 0) {
                        c = PennDraw.RED;
                    }
                    Column col = columns[0];
                    
                    // randomly choose a column that is not filled in the grid
                    while (true) {
                        Column randomCol = columns[(int) (Math.random() * 7)];
                        if (randomCol.getIter() < 6) {
                            col = randomCol;
                            break;
                        } else {
                            continue;
                        }
                    }    
                    
                    Piece newPiece = addNewPiece(c, col);
                    
                    // draw all that have been added so far
                    pieces[numPieces++] = newPiece;
                    drawAll(pieces, numPieces);
                    PennDraw.advance();
                    
                    // if the new piece completes a four in a row, 
                    // display winner and end game
                    if (newPiece.checkFour()) {
                        displayWinner(newPiece);
                        PennDraw.advance();
                        isGameOver = true;
                    }
                    
                    // if the new piece is the last piece to be added, 
                    // declare a tie and end game
                    if (numPieces == 42) {
                        displayTie();
                        PennDraw.advance();
                        isGameOver = true;
                    }
                    
                    // if game is not over, display whose turn it is 
                    if (isGameOver == false) {
                        displayTurn(newPiece);
                        PennDraw.advance();
                    }
                    
                    // end computer's turn, it is now player's turn 
                    playerTurn = true;
                }
                // player's turn 
                if (!isGameOver && PennDraw.mousePressed()) {
                    while (PennDraw.mousePressed()) {
                        // prevent multiple clicks
                    }
                    
                    double xClick = PennDraw.mouseX();
                    
                    // if mouse click was on a column, assign variables
                    if (xClick <= 0.85 && xClick > 0.15) {
                        
                        // assign column to one in the columns array
                        Column col = columns[getColIndex(xClick)];
                        
                        // alternate color with each turn
                        Color c = PennDraw.BLUE;
                        if (numPieces % 2 == 0) {
                            c = PennDraw.RED;
                        }
                        
                        // if column is not filled, add new piece and draw all
                        // the pieces that have been added to the grid 
                        if (col.getIter() < 6) {
                            
                            Piece newPiece = addNewPiece(c, col);
                            
                            pieces[numPieces++] = newPiece;
                            drawAll(pieces, numPieces);
                            PennDraw.advance();
                            
                            // if the new piece completes a four in a row, 
                            // display winner and end game
                            if (newPiece.checkFour()) {
                                displayWinner(newPiece);
                                PennDraw.advance();
                                isGameOver = true;
                            }
                            
                            // if the new piece is the last piece to be added, 
                            // declare a tie and end game
                            if (numPieces == 42) {
                                displayTie();
                                PennDraw.advance();
                                isGameOver = true;
                            }
                            
                            // if game is not over, display whose turn it is 
                            if (isGameOver == false) {
                                displayTurn(newPiece);
                                PennDraw.advance();
                            }
                            // it is now the computer's turn
                            playerTurn = false;
                            
                            // it is now not the first time 
                            isFirstTime = false;
                        }
                    }
                }
            }
            
            // after game is over, if user clicks again, it returns to start 
            // screen - loop starts again 
            while (isGameOver) {
                PennDraw.clear();
                if (PennDraw.mousePressed()) {
                    while (PennDraw.mousePressed()) {
                        // prevent multiple clicks
                    }
                    PennDraw.advance();
                    isGameOver = false;
                }
            }
        }
    }
    
    /** Draws canvas and displays options for 1 player and 2 player modes
      */
    private static void startScreen() {
        PennDraw.clear();
        PennDraw.setCanvasSize(500, 500);
        PennDraw.text(0.5, 0.75, "1-Player Mode"); 
        PennDraw.text(0.5, 0.25, "2-Player Mode");
        PennDraw.advance();
    }
    
    /** Draws grid with 7 columns and 6 rows
      */
    private static void drawGrid() {
        for (int row = 0; row < 6; row++) {
            for (int col = 0; col < 7; col++) {
                PennDraw.setPenColor(PennDraw.BLACK);
                PennDraw.square(0.2 + 0.1 * col, 0.25 + 0.1 * row, RADIUS);
            }
        }
    }
    
    /** Converts x position of the mouse click to index of column clicked
      * @param x - double that represents x coordinate in the canvas
      * @return index of index in the columns array 
      */
    public static int getColIndex(double x) {
        for (int i = 0; i < 7; i++) {
            if (x > 0.15 + i * 0.1 && x <= 0.25 + i * 0.1) {
                return i;
            }
        }
        return -1;
    }
    
    /** Draws all the pieces that have been added so far
      * @param pieces - array of all the pieces that have been added so far
      * @param numPieces - number of pieces in the array
      */
    public static void drawAll(Piece[] pieces, int numPieces) {
        for (int i = 0; i < numPieces; i++) {
            pieces[i].draw();
        }
    }
    
    /** Displays next turn 
     * @param p - Piece that has just been added 
     */
    private static void displayTurn(Piece p) {
        PennDraw.setPenColor(PennDraw.BLACK);
        if (p.getColor() == PennDraw.RED) {
            PennDraw.text(0.5, 0.1, "It is blue's turn"); 
        }
        if (p.getColor() == PennDraw.BLUE) {
            PennDraw.text(0.5, 0.1, "It is red's turn");
        }
    }
    
    /** Displays winner
     * @param p - Piece that has just been added
     */
    public static void displayWinner(Piece p) {
        if (p.getColor() == PennDraw.RED) {
            PennDraw.text(0.5, 0.12, 
                          "WINNER WINNER CHICKEN DINNER! congrats Player RED!");
            PennDraw.text(0.5, 0.05, "Click again to restart");
        }
        if (p.getColor() == PennDraw.BLUE) {
            PennDraw.text(0.5, 0.12, "WINNER WINNER" + 
                          " CHICKEN DINNER! congrats Player BLUE!");
            PennDraw.text(0.5, 0.05, "Click again to restart");
        }
    }
    
    /** Creates and adds new piece into column
     * @param c - Color of the piece
     * @param col - column in which the piece is added to
     * @return the piece that has just been added
     */
    public static Piece addNewPiece(Color c, Column col) {
        
        // creates new piece
        Piece newPiece = new Piece(c, col, col.getIter());
        
        // adds piece into column at the current iteration in the column
        col.add(col.getIter(), newPiece);
        
        // advances the iterator 
        col.setIter(col.getIter() + 1);
        
        return newPiece;
    }
    
    /** Displays tie 
     */
    public static void displayTie() {
        PennDraw.setPenColor(PennDraw.BLACK);
        PennDraw.text(0.5, 0.12, "It's a tie!");
        PennDraw.text(0.5, 0.05, "Click again to restart");
    }
}

