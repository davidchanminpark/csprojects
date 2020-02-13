// Full Name: Chanmin Park
// PennKey: ddpp
// CIS 121: Fall 2019

import org.junit.Before;
import java.util.*;
import org.junit.Test;
import static org.junit.Assert.*;

public class MazeSolverImplTest {

    private int[][] smallWriteupMaze;
    private int[][] bigWriteupMaze;

    @Before
    public void setupTestMazes() {
        smallWriteupMaze = new int[][] {
            {0, 0, 0, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 1},
            {0, 0, 1, 0}
        };

        bigWriteupMaze = new int[][] {
            {0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
            {0, 1, 1, 1, 1, 1, 0, 1, 1, 0},
            {0, 0, 0, 1, 0, 1, 0, 1, 1, 0},
            {1, 1, 0, 1, 1, 0, 1, 0, 1, 0},
            {0, 1, 0, 1, 0, 0, 0, 0, 1, 0},
            {0, 1, 0, 0, 1, 0, 0, 0, 1, 0},
            {0, 1, 1, 0, 0, 1, 1, 0, 1, 0},
            {0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
            {1, 0, 0, 0, 0, 1, 1, 1, 1, 1},
            {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
        };

    }

    @Test
    public void testReturnsSmallMazeSolutionPathInWriteup() {
        int[][] solutionPath = {
            {1, 1, 1, 0},
            {0, 0, 1, 0},
            {1, 1, 1, 0},
            {1, 1, 0, 0}
        };
        assertArrayEquals(solutionPath, MazeSolverImpl.solveMaze(smallWriteupMaze,
                        new Coordinate(0, 0), new Coordinate(0, 2)));
    }

    @Test
    public void testReturnsBigMazeSolutionPathInWriteup() {
        int[][] bigWriteupSolution = new int[][] {
            {1, 1, 1, 0, 1, 1, 1, 1, 1, 1},
            {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
            {1, 1, 1, 0, 0, 0, 0, 0, 0, 1},
            {0, 0, 1, 0, 0, 0, 0, 0, 0, 1},
            {0, 0, 1, 0, 0, 0, 0, 0, 0, 1},
            {0, 0, 1, 1, 0, 0, 0, 0, 0, 1},
            {0, 0, 0, 1, 1, 0, 0, 0, 0, 1},
            {0, 0, 0, 0, 1, 1, 1, 1, 1, 1},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        };
        int[][] returnedPath = MazeSolverImpl.solveMaze(bigWriteupMaze, new Coordinate(2, 0),
                        new Coordinate(4, 0));
        assertArrayEquals(bigWriteupSolution, returnedPath);
    }
    
    /**
     * Note: the above tests are the ones included in the writeup and NOT exhaustive. The autograder
     * uses other test cases not listed above. Please thoroughly read all stub files, including
     * CoordinateTest.java!
     *
     * For help with creating test cases, please see this link:
     * https://www.seas.upenn.edu/~cis121/current/testing_guide.html
     */
    
    // test illegal argument for null maze input 
    @Test(expected = IllegalArgumentException.class)
    public void testNullMazeThrowsException() {
        MazeSolverImpl.solveMaze(null, new Coordinate(2, 0), new Coordinate(4, 0));
    }
    
    // test illegal argument for empty array
    @Test(expected = IllegalArgumentException.class)
    public void testEmptyArrayThrowsException() {
        int[][] zero = new int[0][0];
        MazeSolverImpl.solveMaze(zero, new Coordinate(2, 0), new Coordinate(4, 0));
    }
    
    // test illegal argument for width equaling 1
    @Test(expected = IllegalArgumentException.class)
    public void testOneWidthThrowsException() {
        int[][] widthOne = new int[10][1];
        MazeSolverImpl.solveMaze(widthOne, new Coordinate(2, 0), new Coordinate(4, 0));
    }
    
    // test illegal argument for length equaling 1
    @Test(expected = IllegalArgumentException.class)
    public void testOneLengthThrowsException() {
        int[][] lengthOne = new int[1][10];
        MazeSolverImpl.solveMaze(lengthOne, new Coordinate(2, 0), new Coordinate(4, 0));
    }
    
    // test illegal argument for source out of bounds in row
    @Test(expected = IllegalArgumentException.class)
    public void testSourceOutOfBoundsRowThrowsException() {
        MazeSolverImpl.solveMaze(smallWriteupMaze, new Coordinate(4, 3), new Coordinate(2, 0));
    }
    
    // test illegal argument for source out of bounds in col
    @Test(expected = IllegalArgumentException.class)
    public void testSourceOutOfBoundsColThrowsException() {
        MazeSolverImpl.solveMaze(smallWriteupMaze, new Coordinate(2, 803), new Coordinate(2, 0));
    }
    
    // test illegal argument for goal out of bounds in row
    @Test(expected = IllegalArgumentException.class)
    public void testGoalOutOfBoundsRowThrowsException() {
        MazeSolverImpl.solveMaze(smallWriteupMaze, new Coordinate(2, 0), new Coordinate(4, 3));
    }
    
    // test illegal argument for goal out of bounds in col
    @Test(expected = IllegalArgumentException.class)
    public void testGoalOutOfBoundsColThrowsException() {
        MazeSolverImpl.solveMaze(smallWriteupMaze, new Coordinate(2, 0), new Coordinate(2, 803));
    }
    
    // test illegal argument for source in blocked tile
    @Test(expected = IllegalArgumentException.class)
    public void testSourceInBlockedThrowsException() {
        MazeSolverImpl.solveMaze(smallWriteupMaze, new Coordinate(0, 1), new Coordinate(2, 0));
    }
    
    // test illegal argument for goal in blocked tile
    @Test(expected = IllegalArgumentException.class)
    public void testGoalInBlockedThrowsException() {
        MazeSolverImpl.solveMaze(smallWriteupMaze, new Coordinate(0, 0), new Coordinate(0, 1));
    }
    
    // test source and goal in same position
    @Test
    public void testSourceGoalSamePos() {
        int[][] solutionPath = {
                {1, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0},
                {0, 0, 0, 0}
        };
        assertArrayEquals(solutionPath, MazeSolverImpl.solveMaze(smallWriteupMaze, 
                new Coordinate(0, 0), new Coordinate(0, 0)));
    }
    
    // test null output for no solution path possible
    @Test
    public void testNullOutput() {
        int[][] noSolMaze = {
            {0, 0, 0, 0},
            {1, 1, 1, 1},
            {0, 0, 0, 0},
            {1, 1, 1, 1}
        };
        assertArrayEquals(null, MazeSolverImpl.solveMaze(noSolMaze, 
                new Coordinate(0, 0), new Coordinate(0, 2)));
    }
    
    // test helper findRecIntersection
    @Test
    public void testOneInters() {
        ArrayList<Coordinate> testArr = new ArrayList<Coordinate>(); 
        testArr.add(new Coordinate(0, 0)); 
        testArr.add(new Coordinate(0, 1));
        testArr.add(new Coordinate(1, 0));
        testArr.add(new Coordinate(1, 1));
        testArr.add(new Coordinate(0, 2));
        testArr.add(new Coordinate(1, 2));
        
        int[][] maze = { 
                {0, 1}, 
                {1, 2}, 
                {1, 1}
        }; 
        assertEquals(new Coordinate(1, 1), MazeSolverImpl.findRecIntersect(maze, testArr)); 
    }
}
