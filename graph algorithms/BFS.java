import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * Facade for computing an unweighted shortest path between two vertices in a graph. We represent
 * paths as ordered lists of integers corresponding to vertices.
 *
 */
public final class BFS {
    private BFS() {}

    /**
     * Returns a shortest path from {@code src} to {@code tgt} by executing a breadth-first search.
     * If there are multiple shortest paths, this method may return any one of them. Please note, 
     * you MUST use your ResizingDeque implementation as the BFS queue for this method. 
     * <p/>
     * Do NOT modify this method header.
     *
     * @param g the graph
     * @param src the vertex from which to search
     * @param tgt the vertex to find via {@code src}
     * @return an ordered list of vertices on a shortest path from {@code src} to {@code tgt}, or an
     *         empty list if there is no path from {@code src} to {@code tgt}. The first element
     *         should be {@code src} and the last element should be {@code tgt}. If
     *         {@code src == tgt}, a list containing just that element is returned.
     * @throws IllegalArgumentException if {@code src} or {@code tgt} is not in the graph
     * @throws IllegalArgumentException if the specified graph is null
     */
    public static List<Integer> getShortestPath(Graph g, int src, int tgt) {
        if (g == null) {
            throw new IllegalArgumentException(); 
        }
        
        int numVertices = g.getSize(); 
        
        if (src < 0 || src >= numVertices || tgt < 0 || tgt >= numVertices) {
            throw new IllegalArgumentException(); 
        }
        
        boolean[] discovered = new boolean[numVertices]; 
        Integer[] parent = new Integer[numVertices]; 
        List<Integer> shortestPath = new ArrayList<Integer>(); 
        
        if (src == tgt) {
            shortestPath.add(src); 
            return shortestPath; 
        }
        
        ResizingDequeImpl<Integer> queue = new ResizingDequeImpl<Integer>();
        
        queue.addFirst(src);
        discovered[src] = true; 
        
        while (queue.size() != 0) {
            int v = queue.pollFirst(); 
            Set<Integer> neighbors = g.getNeighbors(v); 
            Iterator<Integer> iter = neighbors.iterator(); 
            
            while (iter.hasNext()) {
                int neighbor = iter.next(); 
                if (!discovered[neighbor]) {
                    discovered[neighbor] = true; 
                    queue.addFirst(neighbor);
                    parent[neighbor] = v; 
                    
                    if (neighbor == tgt) {
                        return getShortestPath(parent, src, tgt); 
                    }
                }
            }
        }
        // if empty - helper function was not called at any point
        return shortestPath; 
    }
    
    static List<Integer> getShortestPath(Integer[] parent, int src, int tgt) {
        int curr = tgt; 
        List<Integer> shortestPath = new ArrayList<Integer>();
        shortestPath.add(0, curr);
        while (curr != src) {
            curr = parent[curr]; 
            shortestPath.add(0, curr); 
        }
        
        return shortestPath; 
    }
}
