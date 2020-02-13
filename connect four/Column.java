 /*  Name: Chanmin Park
   *  PennKey: ddpp
   *  Recitation: 217
   * 
   *  This class is an object class of Column that has methods to return its 
   *  fields, set iteration, and return a piece within the column. It uses an 
   *  ArrayList to store the pieces. 
   */
import java.util.ArrayList; 

public class Column {
    
    private double x; 
    private ArrayList<Piece> column;
    private int iter;
    private int index;
    
    /** Creates a column as an ArrayList of size 6; iteration is set to 0
     * @param x - double that represents the column's location in the grid
     * @param index - int that represents the column's index relative to other 
     * columns 
     */
    public Column(double x, int index) {
        this.x = x; 
        this.index = index;
        column = new ArrayList<Piece>(6);
        iter = 0;
    }
    
    /** Adds the desired piece into the column 
     * @param iter - int that represents the lowest unfilled index of the column
     * @param p - Piece to be added 
     */
    public void add(int iter, Piece p) {
        column.add(iter, p);
    }
    
    /** Returns piece at the desired index
     * @param i - index in the column
     * @return Piece
     * @return null if there is no piece at the given index
     */
    public Piece get(int i) {
        if (column.size() <= i) {
            return null; 
        }
        return column.get(i);
    }
    
    /** Returns the x position of column
     * @return x
     */
    public double getX() {
        return x;
    }
    
    /** Returns current iteration in the column
     * @return iter
     */
    public int getIter() {
        return iter; 
    }
    
    /** Returns the column's index within the grid 
     * @return index
     */
    public int getIndex() {
        return index;
    }
    
    /** Sets iteration to desired iteration
     * @param newIter - int that represents the desired iteration to be set
     */
    public void setIter(int newIter) {
        iter = newIter;
    }
}
    
    
