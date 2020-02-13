import org.junit.Test;
import java.util.List;
import org.junit.Before;
import static org.junit.Assert.*;

public class WidestPathTest {
    private Graph g; 
    private Graph testNull; 
    
    @Before
    public void setup() {
        g = new Graph(8); 
        testNull = null; 
        
        g.addEdge(0, 1, 5); 
        g.addEdge(0, 7, 8);
        g.addEdge(0, 4, 9);
        g.addEdge(1, 3, 15);
        g.addEdge(1, 2, 12);
        g.addEdge(1, 7, 4);
        g.addEdge(2, 3, 3);
        g.addEdge(2, 6, 11);
        g.addEdge(3, 6, 9);
        g.addEdge(4, 7, 5);
        g.addEdge(4, 5, 4);
        g.addEdge(4, 6, 20);
        g.addEdge(5, 2, 1);
        g.addEdge(5, 6, 13);
        g.addEdge(7, 2, 7);
        g.addEdge(7, 5, 6);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void nullGraph() {
        WidestPath.getWidestPath(testNull, 3, 4); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidVert1() {
        WidestPath.getWidestPath(testNull, -1, 4); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidVert2() {
        WidestPath.getWidestPath(testNull, 10, 4); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidVert3() {
        WidestPath.getWidestPath(testNull, 3, -1); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidVert4() {
        WidestPath.getWidestPath(testNull, 3, 10);
    }
    
    @Test
    public void singlePath() {
        List<Integer> widest = WidestPath.getWidestPath(g, 4, 6); 
        Integer[] correct = {4, 6}; 
        assertArrayEquals(correct, widest.toArray()); 
    }
    
    @Test
    public void singlePath2() {
        List<Integer> widest = WidestPath.getWidestPath(g, 2, 3); 
        Integer[] correct = {2, 1, 3}; 
        assertArrayEquals(correct, widest.toArray()); 
    }
    
    @Test
    public void complexPath1() {
        List<Integer> widest = WidestPath.getWidestPath(g, 4, 3); 
        Integer[] correct = {4, 6, 2, 1, 3}; 
        assertArrayEquals(correct, widest.toArray()); 
    }
    
    @Test
    public void sameVert() {
        List<Integer> widest = WidestPath.getWidestPath(g, 0, 0); 
        Integer[] correct = {0}; 
        assertArrayEquals(correct, widest.toArray()); 
    }
}