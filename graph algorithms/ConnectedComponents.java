import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * Provides access to the strongly connected components for a graph.
 */
public class ConnectedComponents {
    private ConnectedComponents() {}
    
    /**
     * Computes the strongly connected components of the specified graph.
     *
     * HINT: In order to compute the transpose graph of G, it will be helpful to use the wrapper
     * class below that transposes a graph in constant time.
     *
     * @param graph the graph
     * @return an immutable set of sets of vertices that comprise the strongly connected components
     *         of the specified graph
     * @throws IllegalArgumentException if the graph is null
     */
    public static Set<Set<Integer>> stronglyConnectedComponents(WDGraph graph) {
        
        if (graph == null) {
            throw new IllegalArgumentException(); 
        }
        
        List<Integer> revFinished = DFS.dfsReverseFinishingTime(graph, 0);
        
        
        WDGraph transposed = new TransposeGraph(graph); 
        
        Set<Set<Integer>> output = new HashSet<Set<Integer>>(); 
        
        boolean[] visited = new boolean[revFinished.size()]; 

        while (revFinished.size() > 0) {
            Set<Integer> scc = new HashSet<Integer>(); 
            ResizingDequeImpl<Integer> stack = new ResizingDequeImpl<Integer>(); 
            int curr = revFinished.get(0); 
            
            stack.addFirst(curr);
            
            while (stack.size() != 0) {
                int currVert = stack.pollFirst(); 
                scc.add(currVert); 
                if (!visited[currVert]) {
                    visited[currVert] = true; 
                }
                Set<Integer> outNeighbors = transposed.outNeighbors(currVert); 
                Iterator<Integer> iter = outNeighbors.iterator();
                
                while (iter.hasNext()) {
                    int neighbor = iter.next(); 
                    if (!visited[neighbor]) {
                        stack.addFirst(neighbor);
                        visited[neighbor] = true; 
                    }
                }
            }
            output.add(scc); 
            revFinished.removeAll(scc); 
        }

        return output; 
    }
    
    // A little hacky since we didn't use interface files, so we're providing it to you.
    // This wrapper class transposes the graph in O(1) time.
    static class TransposeGraph extends WDGraph {
        private WDGraph g;
        
        public TransposeGraph(WDGraph g) {
            super(); // constant time, but is required since we're extending the WDGraph class.
            this.g = g;
        }
        
        @Override
        public Set<Integer> outNeighbors(int v) {
            return g.inNeighbors(v); // Transposes edges
        }
        
        @Override
        public Set<Integer> inNeighbors(int v) {
            return g.outNeighbors(v); // Transposes edges
        }
        
        @Override
        public int getSize() {
            return g.getSize();
        }
        
        @Override
        public boolean addEdge(int u, int v, double weight) {
            return g.addEdge(v, u, weight);
        }
        
        @Override
        public double getWeight(int u, int v) {
            return g.getWeight(v, u);
        }
    }
}
