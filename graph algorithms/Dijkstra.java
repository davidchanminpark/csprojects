import java.util.ArrayList;
import java.util.List;

/**
 * Provides access to Dijkstra's algorithm for a weighted, directed graph.
 * 
 */
public class Dijkstra {
    private Dijkstra() {}

    /**
     * Computes the shortest path between two nodes in a weighted, directed graph
     *
     * @param G the graph to compute the shortest path on
     * @param src the source node
     * @param tgt the target node
     * @return an Iterable containing the nodes in the path, including the start and end nodes. If
     *         the start and end nodes are the same, or if there is no path from the start node to
     *         the end node, it returns an empty Iterable.
     * @throws IllegalArgumentException if g is null
     * @throws IllegalArgumentException if src is not in g
     * @throws IllegalArgumentException if tgt is not in g
     */
    public static Iterable<Integer> getShortestPath(WDGraph g, int src, int tgt) {
        if (g == null) {
            throw new IllegalArgumentException(); 
        }
        
        if (src < 0 || src >= g.getSize() || tgt < 0 || tgt >= g.getSize()) {
            throw new IllegalArgumentException(); 
        }
        
        List<Integer> path = new ArrayList<Integer>(); 
        Integer[] prevNode = new Integer[g.getSize()]; 
        double[] distTo = new double[g.getSize()];
        BinaryMinHeapImpl<Double, Integer> pq = new BinaryMinHeapImpl<Double, Integer>();
        
        if (src == tgt) {
            return path; 
        }
        
        for (int i = 0; i < g.getSize(); i++) {
            distTo[i] = Double.POSITIVE_INFINITY; 
        }
        distTo[src] = 0.0; 
        
        pq.add(0.0, src);
        
        while (!pq.isEmpty()) {
            int currNode = pq.extractMin(); 
            for (int neighbor : g.outNeighbors(currNode)) {
                double currEdge = g.getWeight(currNode, neighbor); 
                if (distTo[neighbor] > distTo[currNode] + currEdge) {
                    distTo[neighbor] = distTo[currNode] + currEdge; 
                    prevNode[neighbor] = currNode; 
                    
                    if (pq.containsValue(neighbor)) {
                        pq.decreaseKey(neighbor, distTo[neighbor]);
                    } else {
                        pq.add(distTo[neighbor], neighbor);
                    }
                }
            }
        }
        
        if (prevNode[tgt] == null) {
            return path; 
        } else {
            path.add(0, tgt);
            Integer prev = prevNode[tgt]; 
            while (prev != null) {
                path.add(0, prev); 
                prev = prevNode[prev]; 
            }
            return path; 
        }
        
    }
    
}
