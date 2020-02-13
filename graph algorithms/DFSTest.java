import org.junit.Test;

import java.util.List;
import java.util.Set;

import org.junit.Before;
import static org.junit.Assert.*;

public class DFSTest {
    private WDGraph test; 
    private WDGraph testNull; 
    private WDGraph testSimple; 
    private WDGraph testSimple2; 
    private WDGraph lecPage7; 
    
    @Before
    public void setup() {
        test = new WDGraph(5); 
        test.addEdge(3, 1, 0);
        test.addEdge(0, 1, 0); 
        test.addEdge(0, 2, 0);
        test.addEdge(0, 3, 0); 
        test.addEdge(1, 2, 0); 
        test.addEdge(2, 3, 0); 
        testNull = null; 
        
        testSimple = new WDGraph(2); 
        testSimple.addEdge(0, 1, 0); 
        testSimple.addEdge(1, 0, 0); 
        
        testSimple2 = new WDGraph(2); 
        testSimple2.addEdge(0, 1, 0); 
        
        lecPage7 = new WDGraph(5); 
        lecPage7.addEdge(0, 1, 0); 
        lecPage7.addEdge(1, 3, 0); 
        lecPage7.addEdge(1, 4, 0); 
        lecPage7.addEdge(4, 0, 0); 
        lecPage7.addEdge(2, 0, 0);  
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void revNullGraphR() {
        DFS.dfsReverseFinishingTime(testNull, 3); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void revOutOfBounds() {
        DFS.dfsReverseFinishingTime(testNull, -2); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void revOutOfBounds2() {
        DFS.dfsReverseFinishingTime(testNull, 5); 
    }
    
    @Test
    public void revTestSimple() {
        Integer[] correct = {0, 1}; 
        List<Integer> returned = DFS.dfsReverseFinishingTime(testSimple, 0); 
        assertArrayEquals(correct, returned.toArray()); 
    }
    
    @Test
    public void revTestSimple2() {
        Integer[] correct = {1, 0}; 
        List<Integer> returned = DFS.dfsReverseFinishingTime(testSimple, 1); 
        assertArrayEquals(correct, returned.toArray()); 
    }
    
    @Test
    public void revTestComplex() {
        Integer[] correct = {2, 0, 1, 4, 3}; 
        List<Integer> returned = DFS.dfsReverseFinishingTime(lecPage7, 0); 
        assertArrayEquals(correct, returned.toArray()); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void expNullGraphR() {
        DFS.dfsExploreComponent(testNull, 3); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void expOutOfBounds() {
        DFS.dfsExploreComponent(testNull, -2); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void expOutOfBounds2() {
        DFS.dfsExploreComponent(testNull, 5); 
    }
    
    @Test
    public void expTestSimple1() {
        Integer[] correct = {0, 1}; 
        Set<Integer> returned = DFS.dfsExploreComponent(testSimple, 0); 
        assertArrayEquals(correct, returned.toArray()); 
    }
    
    @Test
    public void expTestSimple2() {
        Integer[] correct = {1}; 
        Set<Integer> returned = DFS.dfsExploreComponent(testSimple2, 1); 
        assertArrayEquals(correct, returned.toArray()); 
    }
    
    @Test
    public void revLecPage7() {
        Integer[] correct = {0, 1, 3, 4}; 
        Set<Integer> returned = DFS.dfsExploreComponent(lecPage7, 0);
        assertArrayEquals(correct, returned.toArray()); 
    }
    
    @Test
    public void revLecPage72() {
        Integer[] correct = {0, 1, 3, 4}; 
        Set<Integer> returned = DFS.dfsExploreComponent(lecPage7, 4);
        assertArrayEquals(correct, returned.toArray()); 
    }
}