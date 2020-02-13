import org.junit.Test;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.junit.Before;
import static org.junit.Assert.*;

public class ConnectedComponentsTest {
    private WDGraph test; 
    private WDGraph testNull; 
    
    @Before
    public void setup() {
        test = new WDGraph(5); 
        testNull = null; 
        
        test.addEdge(1, 0, 0); 
        test.addEdge(0, 2, 0);
        test.addEdge(2, 1, 0);
        test.addEdge(0, 3, 0);
        test.addEdge(3, 4, 0);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void sccNull() {
        ConnectedComponents.stronglyConnectedComponents(testNull); 
    }
    
    @Test
    public void scc() {
        Integer[] correct1 = {0, 1, 2}; 
        Integer[] correct2 = {3}; 
        Integer[] correct3 = {4}; 
        Set<Set<Integer>> returned = ConnectedComponents.stronglyConnectedComponents(test);
        List<Set<Integer>> returnedList = new ArrayList<Set<Integer>>(); 
        for (Set<Integer> s : returned) {
            returnedList.add(s); 
        }
        Object[] returned1 = returnedList.get(0).toArray();
        Object[] returned2 = returnedList.get(1).toArray();
        Object[] returned3 = returnedList.get(2).toArray(); 
        
        assertArrayEquals(correct1, returned1); 
        assertArrayEquals(correct2, returned2);
        assertArrayEquals(correct3, returned3);

    }
}


