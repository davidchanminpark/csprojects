// Full Name: Chanmin Park
// PennKey: ddpp
// CIS 121: Fall 2019
import java.util.*; 
/**
 * @author sshaik, 19fa
 */
public class MazeSolverImpl {
    
    /**
     * You should write your code within this method. A good rule of thumb,
     * especially with recursive problems like this, is to write your input
     * exception handling within this method and then use helper methods to carry
     * out the actual recursion.
     *A
     * How you set up the recursive methods is up to you, but note that since this
     * is a *static* method, all helper methods that it calls must *also* be static.
     * Make them package-private (i.e. without private or public modifiers) so you
     * can test them individually.
     *
     * @param maze        See the writeup for more details about the format of the
     *                    input maze.
     * @param sourceCoord The source (starting) coordinate
     * @param goalCoord   The goal (ending) coordinate
     * @return a matrix of the same dimension as the input maze containing the
     *         solution path marked with 1's, or null if no path exists. See the
     *         writeup for more details.
     *
     * @throws IllegalArgumentException in the following instances: 1. If the maze
     *                                  is null 2. If m * n <= 1 where m and n are
     *                                  the dimensions of the maze 3. If either the
     *                                  source coordinate OR the goal coordinate are
     *                                  out of the matrix bounds. 4. If your source
     *                                  or goal coordinate are on a blocked tile.
     */
    public static int[][] solveMaze(int[][] maze, Coordinate sourceCoord, Coordinate goalCoord) {
        
        int sourceX = sourceCoord.getX(); 
        int sourceY = sourceCoord.getY(); 
        int goalX = goalCoord.getX(); 
        int goalY = goalCoord.getY();
        
        // throw error if input is null
        if (maze == null) {
            throw new IllegalArgumentException();
        }

        // throw error if input is empty or has length/width of 1
        if (maze.length <= 1 || maze[0].length <= 1) {
            throw new IllegalArgumentException();
        }

        // throw error if source is out of bounds
        if (sourceX < 0 || sourceX >= maze[0].length || sourceY < 0
                || sourceY >= maze.length) {
            throw new IllegalArgumentException();
        }
        
        // throw error if goal is out of bounds
        if (goalX < 0 || goalX >= maze[0].length || goalY < 0
                || goalY >= maze.length) {
            throw new IllegalArgumentException();
        }
        
        // throw error if source or goal is in blocked tile
        if (maze[sourceY][sourceX] == 1 || maze[goalY][goalX] == 1) {
            throw new IllegalArgumentException();
        }
        ArrayList<Coordinate> path = new ArrayList<Coordinate>(); 
        int[][] returnedPath = helperSolveMaze(maze, sourceCoord, goalCoord, path); 
        
        return returnedPath;
    }
    
    // main helper function - performs recursion
    static int[][] helperSolveMaze(int[][] maze, Coordinate sourceCoord, Coordinate goalCoord, 
            ArrayList<Coordinate> path) {
        
        // get x and y coords for source and goal
        int sourceX = sourceCoord.getX(); 
        int sourceY = sourceCoord.getY(); 
        
        // booleans to check if surrounding four (down, up, left, right) 
        // are open; if more than one is open, then intersection == true
        boolean downOpen = false; 
        boolean upOpen = false; 
        boolean leftOpen = false; 
        boolean rightOpen = false; 
        
        int numPaths = 0; 
        boolean intersection = false; 
        
        if (sourceY + 1 < maze.length && maze[sourceY + 1][sourceX] == 0) {
            numPaths++; 
            downOpen = true; 
        }
        
        if (sourceY - 1 >= 0 && maze[sourceY - 1][sourceX] == 0) {
            numPaths++; 
            upOpen = true; 
        }
        
        if (sourceX - 1 >= 0 && maze[sourceY][sourceX - 1] == 0) {
            numPaths++; 
            leftOpen = true; 
        }
        
        if (sourceX + 1 < maze[0].length && maze[sourceY][sourceX + 1] == 0) {
            numPaths++; 
            rightOpen = true; 
        }
        
        if (numPaths > 1) {
            intersection = true; 
        }

        // check if at goal
        if (sourceCoord.equals(goalCoord)) {
            path.add(sourceCoord);
            int[][] finalMaze = convertFinal(path, maze.length, maze[0].length); 
            return finalMaze; 
            
        // check if down is open
        } else if (downOpen) {
            if (intersection) {
                maze[sourceY][sourceX] = 2; 
            } else {
                maze[sourceY][sourceX] = 1; 
            }
            path.add(sourceCoord);
            return helperSolveMaze(maze, new Coordinate(sourceX, sourceY + 1), goalCoord, path); 
            
        // check if up is open
        } else if (upOpen) {
            if (intersection) {
                maze[sourceY][sourceX] = 2; 
            } else {
                maze[sourceY][sourceX] = 1; 
            }
            path.add(sourceCoord);
            return helperSolveMaze(maze, new Coordinate(sourceX, sourceY - 1), goalCoord, path);
        
        // check if left is open
        } else if (leftOpen) {
            if (intersection) {
                maze[sourceY][sourceX] = 2; 
            } else {
                maze[sourceY][sourceX] = 1; 
            }
            path.add(sourceCoord);
            return helperSolveMaze(maze, new Coordinate(sourceX - 1, sourceY), goalCoord, path);  
            
        // check if right is open
        } else if (rightOpen) {
            if (intersection) {
                maze[sourceY][sourceX] = 2; 
            } else {
                maze[sourceY][sourceX] = 1; 
            }
            path.add(sourceCoord);
            return helperSolveMaze(maze, new Coordinate(sourceX + 1, sourceY), goalCoord, path);
        
        // if blocked    
        } else { 
            Coordinate recentIntersection = findRecIntersect(maze, path);
            maze[sourceY][sourceX] = 1; 
            if (recentIntersection == null) {
                return null; 
            } else {
                return helperSolveMaze(maze, recentIntersection, goalCoord, path); 
            }
        }
    }
    
    // convert ArrayList of coordinates from beginning to end into 2d array with 1s filled in 
    // for the coordinates
    static int[][] convertFinal(ArrayList<Coordinate> path, int height, int width) {
        ListIterator<Coordinate> iter = path.listIterator(); 
        
        int[][] finalPath = new int[height][width]; 
        
        while (iter.hasNext()) {
            Coordinate c = iter.next(); 
            int currX = c.getX(); 
            int currY = c.getY(); 
            
            finalPath[currY][currX] = 1; 
        }
        return finalPath; 
    }
    
    // check array list of coordinates, to see if there is an intersection
    // return the most recently added intersection (coord with 0 in maze grid)
    // if there is no prev intersection return null
    static Coordinate findRecIntersect(int[][] maze, ArrayList<Coordinate> path) {
        ListIterator<Coordinate> iter = path.listIterator(path.size());
        
        while (iter.hasPrevious()) {
            Coordinate c = iter.previous(); 
            int currX = c.getX(); 
            int currY = c.getY(); 
            
            if (maze[currY][currX] == 2) {
                iter.remove(); 
                return c; 
            } else {
                iter.remove(); 
            }
        }
        return null; 
    }
}
