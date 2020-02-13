import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;
import java.util.Iterator;

public class DijkstraTest {
    private WDGraph g; 
    
    @Before
    public void setup() {
        g = new WDGraph(8); 
        
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
        Dijkstra.getShortestPath(null, 0, 5); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidSrc1() {
        Dijkstra.getShortestPath(g, -1, 5); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidSrc2() {
        Dijkstra.getShortestPath(g, 9, 5); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidTgt1() {
        Dijkstra.getShortestPath(g, 3, -3); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void invalidTgt2() {
        Dijkstra.getShortestPath(g, 3, 9); 
    }
    
    @Test
    public void noPath() {
        Iterable<Integer> path = Dijkstra.getShortestPath(g, 6, 3);
        Iterator<Integer> pathIter = path.iterator(); 
        assertFalse(pathIter.hasNext()); 
    }
    
    @Test
    public void singlePath1() {
        Iterable<Integer> path = Dijkstra.getShortestPath(g, 3, 6);
        Iterator<Integer> pathIter = path.iterator(); 
        assertTrue(pathIter.hasNext()); 
        assertSame(pathIter.next(), 3); 
        assertSame(pathIter.next(), 6); 
        assertFalse(pathIter.hasNext()); 
    }
    
    @Test
    public void singlePath2() {
        Iterable<Integer> path = Dijkstra.getShortestPath(g, 1, 3);
        Iterator<Integer> pathIter = path.iterator(); 
        assertTrue(pathIter.hasNext()); 
        assertSame(pathIter.next(), 1); 
        assertSame(pathIter.next(), 7);
        assertSame(pathIter.next(), 2);
        assertSame(pathIter.next(), 3); 
        assertFalse(pathIter.hasNext()); 
    }
    
    @Test
    public void doublePath1() {
        Iterable<Integer> path = Dijkstra.getShortestPath(g, 4, 6);
        Iterator<Integer> pathIter = path.iterator(); 
        assertTrue(pathIter.hasNext()); 
        assertSame(pathIter.next(), 4); 
        assertSame(pathIter.next(), 5); 
        assertSame(pathIter.next(), 2);
        assertSame(pathIter.next(), 6);
        assertFalse(pathIter.hasNext()); 
    }
    
    @Test
    public void doublePath2() {
        Iterable<Integer> path = Dijkstra.getShortestPath(g, 2, 6);
        Iterator<Integer> pathIter = path.iterator(); 
        assertTrue(pathIter.hasNext()); 
        assertSame(pathIter.next(), 2); 
        assertSame(pathIter.next(), 6); 
        assertFalse(pathIter.hasNext()); 
    }
    
    @Test
    public void crazyPath() {
        Iterable<Integer> path = Dijkstra.getShortestPath(g, 0, 6);
        Iterator<Integer> pathIter = path.iterator(); 
        assertTrue(pathIter.hasNext()); 
        assertSame(pathIter.next(), 0); 
        assertSame(pathIter.next(), 4);
        assertSame(pathIter.next(), 5);
        assertSame(pathIter.next(), 2);
        assertSame(pathIter.next(), 6);
        assertFalse(pathIter.hasNext()); 
    }
    
    
    
    
    
    
}