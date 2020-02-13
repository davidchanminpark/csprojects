 /*  Name: Chanmin Park
   *  PennKey: ddpp
   *  Recitation: 217
   * 
   *  This class is an object class of Piece that has methods to check for four
   *  in a row and draw the piece on the screen. 
   */
import java.awt.Color;

public class Piece {
    
    private Color color;
    private Column column;
    private int colIndex;
    
    /** Creates a piece
      * @param color - the color of the piece, which represents player
      * @param column - the column that the piece belongs to 
      * @param colIndex - the index of the column that the piece is located in 
      */
    public Piece(Color color, Column column, int colIndex) {
        this.color = color; 
        this.column = column;
        this.colIndex = colIndex;
        
    }
    
    /** Checks if the piece is part of a four in a row 
      * @return boolean - true if it's part of a four in a row, false otherwise
      */
    public boolean checkFour() {
        if (checkCol() || checkRow() || checkDiagTopLeft() || 
            checkDiagTopRight()) {
            return true;
        }
        return false;
    }
    
    /** Checks for four in a row in the vertical direction
      * @return boolean - true if there is, false if there isn't 
      */
    private boolean checkCol() {
        
        // no need to check if its colIndex is not the fourth or above
        if (colIndex < 3) {
            return false; 
        }
        
        for (int i = 1; i < 4; i++) {
            if (color != column.get(colIndex - i).getColor()) {
                return false; 
            }
        }
        return true;
    }
    
    /** Checks for four in a row in the horizontal direction
      * @return boolean - true if there is, false if there isn't 
      */
    private boolean checkRow() {
        int count = 0;
        
        // check to the right 
        for (int i = 1; i < 4; i++) {
            
            // if column's index goes beyond grid, stop count
            if (column.getIndex() + i > 6) {
                break;
            }
            
            // obtain the piece with same index in the desired column 
            Piece checkNext = 
                ConnectFour.getColumns()[column.getIndex() + i].get(colIndex);
            
            // if there is no piece or the color doesn't match, stop count 
            if (checkNext == null || color != checkNext.getColor()) {
                break;
            }
            count++;
        }
        
        //check to the left
        for (int i = 1; i < 4; i++) {
            
            // if column's index goes beyond grid, stop count
            if (column.getIndex() - i < 0) {
                break; 
            }
            
            // obtain the piece with same index in the desired column
            Piece checkNext = 
                ConnectFour.getColumns()[column.getIndex() - i].get(colIndex);
            
            // if there is no piece or the color doesn't match, stop count
            if (checkNext == null || color != checkNext.getColor()) {
                break; 
            }
            count++;
        }
        
        // if there is less than three with same color, return false 
        if (count < 3) {
            return false; 
        }
        return true;
    }
    
    /** Checks for four in a row in the diagonal direction going to top left 
      * @return boolean - true if there is, false if there isn't 
      */
    private boolean checkDiagTopLeft() {
        int count = 0;
        
        // check to the left
        for (int i = 1; i < 4; i++) {
            
            // if column's index goes beyond grid, stop count
            if (column.getIndex() - i < 0) {
                break;
            }
            
            // if the piece's index within column goes beyond grid, stop count
            if (colIndex + i > 6) {
                break;
            }
            
            // obtain piece in the diagonal direction to top left 
            Piece checkNext = 
                ConnectFour.getColumns()[column.getIndex() - i].get(colIndex + i);
            
            // if there is no piece or the color doesn't match, stop count
            if (checkNext == null || color != checkNext.getColor()) {
                break;
            }
            count++;  
        }
        
        // check to the right
        for (int i = 1; i < 4; i++) {
            
            // if column's index goes beyond grid, stop count
            if (column.getIndex() + i > 6) {
                break;
            }
            
            // if the piece's index within column goes beyond grid, stop count
            if (colIndex - i < 0) {
                break;
            }
            
            // obtain piece in the diagonal direction to bottom right  
            Piece checkNext = 
                ConnectFour.getColumns()[column.getIndex() + i].get(colIndex - i);
            
            // if there is no piece or the color doesn't match, stop count
            if (checkNext == null || color != checkNext.getColor()) {
                break;
            }
            count++;
        }
        
        // if there is less than three with same color, return false
        if (count < 3) {
            return false;
        }
        return true;
    }
    
    /** Checks for four in a row in the diagonal direction going to top right 
      * @return boolean - true if there is, false if there isn't 
      */
    private boolean checkDiagTopRight() {
        int count = 0;
        // check to the left
        for (int i = 1; i < 4; i++) {
            
            // if column's index goes beyond grid, stop count
            if (column.getIndex() - i < 0) {
                break;
            }
            
            // if the piece's index within column goes beyond grid, stop count
            if (colIndex - i < 0) {
                break;
            }
            
            // obtain piece in the diagonal direction to bottom left 
            Piece checkNext = 
                ConnectFour.getColumns()[column.getIndex() - i].get(colIndex - i);
            
            // if there is no piece or the color doesn't match, stop count
            if (checkNext == null || color != checkNext.getColor()) {
                break;
            }
            count++;  
        }
        
        // check to the right
        for (int i = 1; i < 4; i++) {
            
            // if column's index goes beyond grid, stop count
            if (column.getIndex() + i > 6) {
                break;
            }
            
            // if the piece's index within column goes beyond grid, stop count
            if (colIndex + i > 6) {
                break;
            }
            
            // obtain piece in the diagonal direction to top right 
            Piece checkNext = 
                ConnectFour.getColumns()[column.getIndex() + i].get(colIndex + i);
            
            // if there is no piece or the color doesn't match, stop count
            if (checkNext == null || color != checkNext.getColor()) {
                break;
            }
            count++;
        }
        
        // if there is less than three with same color, return false
        if (count < 3) {
            return false;
        }
        return true;
    }
    
    /** Draws the piece on the screen in the appropriate spot in the grid
     */
    public void draw() {
        PennDraw.setPenColor(color);
        PennDraw.filledCircle(column.getX(), 0.25 + colIndex * 0.1, 0.05); 
    }
    
    /** Returns color of the piece
     * @return piece's color 
     */
    public Color getColor() {
        return color; 
    }
}
