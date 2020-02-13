import org.junit.Test;
import java.util.List;
import org.junit.Before;
import static org.junit.Assert.*;

public class BFSTest { 
    private Graph test; 
    private Graph testNull; 
    
    @Before
    public void setup() {
        test = new Graph(5); 
        test.addEdge(3, 1, 0);
        test.addEdge(0, 1, 0); 
        test.addEdge(0, 2, 0);
        test.addEdge(0, 3, 0); 
        test.addEdge(1, 2, 0); 
        test.addEdge(2, 3, 0); 
        testNull = null; 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void nullGraph() {
        BFS.getShortestPath(testNull, 3, 4); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidVert1() {
        BFS.getShortestPath(test, -1, 0); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidVert2() {
        BFS.getShortestPath(test, 5, 0); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidVert3() {
        BFS.getShortestPath(test, 3, -1); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidVert4() {
        BFS.getShortestPath(test, 3, 7); 
    }
    
    @Test
    public void sameVert() {
        List<Integer> shortest = BFS.getShortestPath(test, 0, 0); 
        Integer[] correct = {0}; 
        assertArrayEquals(correct, shortest.toArray()); 
    }
    
    @Test
    public void shortestPath1() {
        List<Integer> shortest = BFS.getShortestPath(test, 1, 3); 
        Integer[] correct = {1, 3}; 
        assertArrayEquals(correct, shortest.toArray()); 
    }
    
    @Test
    public void shortestPath2() {
        List<Integer> shortest = BFS.getShortestPath(test, 0, 3); 
        Integer[] correct = {0, 3}; 
        assertArrayEquals(correct, shortest.toArray());
    }
    
    @Test
    public void noPath() {
        List<Integer> shortest = BFS.getShortestPath(test, 0, 4); 
        Integer[] correct = {}; 
        assertArrayEquals(correct, shortest.toArray());
    }
}