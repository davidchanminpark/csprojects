import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;

public class KruskalTest {
    private Graph g; 
    
    @Before
    public void setup() {
        
        g = new Graph(9); 
        
        g.addEdge(3, 5, 14); 
        g.addEdge(1, 7, 11);
        g.addEdge(5, 4, 10);
        g.addEdge(3, 4, 9);
        g.addEdge(1, 2, 8);
        g.addEdge(0, 7, 8);
        g.addEdge(7, 8, 7);
        g.addEdge(2, 3, 7);
        g.addEdge(8, 6, 6);
        g.addEdge(2, 5, 4);
        g.addEdge(0, 1, 4);
        g.addEdge(6, 5, 2);
        g.addEdge(8, 2, 2);
        g.addEdge(7, 6, 1);
        
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void nullGraph() {
        Kruskal.getMST(null); 
    }
    
    @Test
    public void getMST() {
        Graph res = Kruskal.getMST(g); 
        
        assertSame(9, res.getSize()); 
        
        assertTrue(res.hasEdge(7, 6)); 
        assertTrue(res.hasEdge(2, 8)); 
        assertTrue(res.hasEdge(5, 6)); 
        assertTrue(res.hasEdge(0, 1));
        assertTrue(res.hasEdge(5, 2));
        assertTrue(res.hasEdge(2, 3));
        assertTrue(res.hasEdge(7, 0)); 
        assertTrue(res.hasEdge(3, 4)); 
        
    }
    
    @Test
    public void compareEdges() {
        Kruskal.Edge e = new Kruskal.Edge(5, 3, 3);
        Kruskal.Edge e2 = new Kruskal.Edge(4, 3, 3);

        assertTrue(e.equals(e)); 
        assertFalse(e.equals(e2)); 
        assertFalse(e.equals(null)); 
        assertTrue(e.equals(new Kruskal.Edge(3, 5, 3))); 
        
    }
    
    
    
}