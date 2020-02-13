import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * Contains methods to run DFS on a {@link WDGraph}.
 *
 * Iterative implementations of DFS MUST use your ResizingDeque as the DFS stack. 
 *
 */
public final class DFS {
    private DFS() {}
    
    /**
     * Runs depth-first search on the input graph {@code g} and returns the list of nodes explored
     * in reverse order of node finishing time. For the purposes of testing, we also ask you to
     * adhere to the following constraints:
     * <ul>
     * <li>When visiting a node's neighbors, the neighbors should be visited in increasing order.
     * You may use {@link java.util.Collections#sort(List)} for this.</li>
     * <li>If DFS finishes on the source/root node but not the entire graph has been explored, DFS
     * should start again on the smallest node that hasn't yet been visited.</li>
     * </ul>
     * Do NOT modify this method header.
     *
     * @param g the graph
     * @param src the vertex from which to begin search
     * @return a list containing all vertices of the graph in reverse order of finish time
     * @throws IllegalArgumentException if {@code src} is not in the graph
     * @throws IllegalArgumentException if the specified graph is null
     */
    public static List<Integer> dfsReverseFinishingTime(WDGraph g, int src) {
        if (g == null) {
            throw new IllegalArgumentException(); 
        }
        
        int numVertices = g.getSize(); 
        
        if (src < 0 || src >= numVertices) {
            throw new IllegalArgumentException(); 
        }
        
        List<Integer> output = new ArrayList<Integer>(); 
        
        boolean[] visited = new boolean[numVertices]; 
        
        dfsVisit(g, src, visited, output);
        
        for (int i = 0; i < numVertices; i++) {
            if (!visited[i]) {
                dfsVisit(g, i, visited, output); 
            }
        }
        return output;  
    }
    
    static void dfsVisit(WDGraph g, int currVert, boolean[] visited, List<Integer> output) {

        visited[currVert] = true; 
        Set<Integer> outNeighbors = g.outNeighbors(currVert);
        List<Integer> outNeighborsList = new ArrayList<Integer>(); 
        outNeighborsList.addAll(outNeighbors); 
        Collections.sort(outNeighborsList);
        Iterator<Integer> iter = outNeighborsList.iterator();
        
        while (iter.hasNext()) {
            int neighbor = iter.next(); 
            if (!visited[neighbor]) {
                visited[neighbor] = true; 
                dfsVisit(g, neighbor, visited, output); 
            }
        }
        
        output.add(0, currVert); 
    }
    
    
    /**
     * Runs depth-first search on the input graph {@code g} and returns the set of nodes reachable
     * from {@code src}.
     * <p/>
     * Do NOT modify this method header.
     *
     * @param g the graph
     * @param src the vertex from which to begin search
     * @return a set containing all vertices reachable from {@code src}, including {@code src}
     * @throws IllegalArgumentException if {@code src} is not in the graph
     * @throws IllegalArgumentException if the specified graph is null
     */
    public static Set<Integer> dfsExploreComponent(WDGraph g, int src) {
        if (g == null) {
            throw new IllegalArgumentException(); 
        }
        
        int numVertices = g.getSize(); 
        
        if (src < 0 || src >= numVertices) {
            throw new IllegalArgumentException(); 
        }
        
        boolean[] visited = new boolean[numVertices]; 
        
        ResizingDequeImpl<Integer> stack = new ResizingDequeImpl<Integer>();
        
        Set<Integer> output = new HashSet<Integer>(); 
        
        stack.addFirst(src);
        
        while (stack.size() != 0) {
            int currVert = stack.pollFirst(); 
            output.add(currVert); 
            if (!visited[currVert]) {
                visited[currVert] = true;
            }
            Set<Integer> outNeighbors = g.outNeighbors(currVert); 
            Iterator<Integer> iter = outNeighbors.iterator();
            
            while (iter.hasNext()) {
                int neighbor = iter.next(); 
                if (!visited[neighbor]) {
                    stack.addFirst(neighbor);
                    visited[neighbor] = true; 
                }
            }
        }
        
        return output; 
    }
}
