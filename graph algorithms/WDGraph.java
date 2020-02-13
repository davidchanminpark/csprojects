import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Set;

/**
 * Type for a simple, weighted directed graph. By convention, the n vertices will be labeled
 * 0,1,...,n-1. The edge weights can be any double value. Self loops and parallel edges are not
 * allowed. Your implementation should use O(m + n) space.
 *
 * Also note that the runtimes given are worst-case runtimes. As a result, you shouldn't be 
 * implementing your graph using a HashMap as the primary data structure for the adjacency list
 * (you may use HashMaps/HashSets in other places as long as you meet the provided runtimes). 
 *
 */
public class WDGraph {

    public WDGraph() {} // Do NOT delete/modify this constructor!
    
    /**
     * Initializes a graph of size {@code n}. All valid vertices in this graph thus have integer
     * indices in the half-open range {@code [0, n)}.
     * <p/>
     * Do NOT modify this constructor header.
     *
     * @param n the number of vertices in the graph
     * @throws IllegalArgumentException if {@code n} is negative
     * @implSpec This method should run in O(n) time
     */
    public WDGraph(int n) {
        if (n < 0) {
            throw new IllegalArgumentException(); 
        }
        outNeighbors = new HashMap<Integer, Set<Integer>>();
        inNeighbors = new HashMap<Integer, Set<Integer>>();
        weights = new HashMap<String, Double>(); 
        for (int i = 0; i < n; i++) {
            inNeighbors.put(i, new HashSet<Integer>());
            outNeighbors.put(i, new HashSet<Integer>()); 
        }
        size = n; 
    }
    
    private Map<Integer, Set<Integer>> outNeighbors; 
    private Map<Integer, Set<Integer>> inNeighbors;
    private int size; 
    private Map<String, Double> weights;

    /**
     * Returns the number of vertices in the graph.
     * <p/>
     * Do NOT modify this method header.
     *
     * @return the number of vertices in the graph
     * @implSpec This method should run in O(1) time.
     */
    public int getSize() {
        return size; 
    }
    
    public boolean hasEdge(int u, int v) {
        if (u < 0 || u >= size || v < 0 || v >= size) {
            throw new IllegalArgumentException(); 
        }
        
        Set<Integer> uNeighbors = outNeighbors.get(u); 
        return uNeighbors.contains(v); 
    }

    /**
     * Creates an edge from {@code u} to {@code v} if it does not already exist. A call to this
     * method should <em>not</em> modify the edge weight if the {@code u-v} edge already exists.
     * <p/>
     * Do NOT modify this method header.
     *
     * @param u the source vertex to connect
     * @param v the target vertex to connect
     * @param weight the edge weight
     * @return {@code true} if the graph changed as a result of this call, false otherwise (i.e. if
     *         the edge is already present)
     * @throws IllegalArgumentException if a specified vertex does not exist or if u == v
     * @implSpec This method should run in O(deg(u)) time
     */
    public boolean addEdge(int u, int v, double weight) {
        if (u < 0 || u >= size || v < 0 || v >= size || u == v) {
            throw new IllegalArgumentException(); 
        }
        
        String edge = Integer.toString(u) + Integer.toString(v); 
        
        if (hasEdge(u, v)) {
            return false; 
        } else {
            outNeighbors.get(u).add(v); 
            inNeighbors.get(v).add(u); 
            weights.put(edge, weight); 
            return true; 
        }
    }

    /**
     * Returns the weight of an edge.
     * <p/>
     * Do NOT modify this method header.
     *
     * @param u source vertex
     * @param v target vertex
     * @return the edge weight of {@code u-v}
     * @throws NoSuchElementException if the {@code u-v} edge does not exist
     * @throws IllegalArgumentException if a specified vertex does not exist
     * @implSpec This method should run in O(deg(u)) time.
     */
    public double getWeight(int u, int v) {
        if (u < 0 || u >= size || v < 0 || v >= size) {
            throw new IllegalArgumentException(); 
        }
        
        if (!hasEdge(u, v)) {
            throw new NoSuchElementException(); 
        }
        
        String edge = Integer.toString(u) + Integer.toString(v); 
        
        return weights.get(edge); 
    }

    /**
     * Returns the out-neighbors of the specified vertex.
     * <p/>
     * Do NOT modify this method header.
     *
     * @param v the vertex
     * @return all out neighbors of the specified vertex or an empty set if there are no out
     *         neighbors
     * @throws IllegalArgumentException if the specified vertex does not exist
     * @implSpec This method should run in O(outdeg(v)) time.
     */
    public Set<Integer> outNeighbors(int v) {
        if (v < 0 || v >= size) {
            throw new IllegalArgumentException(); 
        }
        
        return outNeighbors.get(v);
    }

    /**
     * Returns the in-neighbors of the specified vertex.
     * <p/>
     * Do NOT modify this method header.
     *
     * @param v the vertex
     * @return all in neighbors of the specified vertex or an empty set if there are no in neighbors
     * @throws IllegalArgumentException if the specified vertex does not exist
     * @implSpec This method should run in O(indeg(v)) time.
     */
    public Set<Integer> inNeighbors(int v) {
        if (v < 0 || v >= size) {
            throw new IllegalArgumentException(); 
        }
        return inNeighbors.get(v);
    }

}
