import java.util.ArrayDeque;
import java.util.Arrays;
import java.util.Deque;
import java.util.Iterator;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Objects;

/**
 * Implementation of a {@link AbstractTrieMap} using a trie.
 * <p>
 * There are two main variables to keep in mind regarding a running time for a trie implementation:
 * <dl> <dt>{@code N}</dt> <dd>the number of nodes in the trie</dd> <dt>{@code H}</dt> <dd>the
 * height of the trie (length of the longest key)</dd> </dl>
 * <p>
 * Note that N is bounded by H * (# of keys/values in the mapping), but it will typically be
 * significantly smaller due to key overlap.
 * <p>
 * Keys are of type {@link CharSequence}. This allows the implementation to make assumptions as to
 * how data is stored, since we cannot break a key down into individual characters if the key is
 * not made up of characters to begin with. For simplicity, keys must consist entirely of lowercase
 * letters. The empty string is a valid key. 
 * <p>
 * Null keys are not permitted because keys correspond directly to paths in a trie. Null values are
 * not permitted because rather than using a sentinel node, the implementation uses null to
 * indicate that a node does not have an associated value.
 *
 * @param <V> the type of mapped values
 */
public class TrieMap<V> extends AbstractTrieMap<V> {
    
    /**
     * The size of our key alphabet or character set. Here, we use 26 for the standard lowercase
     * alphabet. We might like to be more flexible and support full alphanumeric or even full ASCII
     * but that would increase our overhead. Since we know something about our use case, we can
     * stick to the lowercase alphabet and keep our overhead down.
     */
    private static final int BRANCH_FACTOR = 26;

    /**
     * The root node of the trie.
     */
    private Node<V> root;

    /**
     * The size of the trie.
     */
    private int size;

    /**
     * Constructs an empty TrieMap.
     */
    public TrieMap() {
        root = new Node<>(null);
    }

    /**
     * Converts a {@code char} into an array index.
     * <p>
     * Effectively maps {@code a -> 0, b -> 1, ..., z -> 25}.
     *
     * @param c the character
     * @return the array index corresponding to the specified character
     * @throws IllegalArgumentException if the specified character is not valid as an index
     */
    private static int convertToIndex(char c) {
        if (c < 'a' || c > 'z') {
            throw new IllegalArgumentException("Character must be in the range [a..z]");
        }
        return c - 'a';
    }

    /**
     * Converts an array index into a {@code char} in the key.
     * <p>
     * Effectively maps {@code 0 -> a, b -> 1, ..., 25 -> z}.
     *
     * @param i the index
     * @return the character corresponding to the specified array index
     * @throws IllegalArgumentException if the specified index is out of bounds
     */
    private static char convertToChar(int i) {
        if (i < 0 || i >= BRANCH_FACTOR) {
            throw new IllegalArgumentException("Index must be in the range [0..BRANCH_FACTOR]");
        }
        return (char) (i + 'a');
    }

    public Node<V> getRoot() {
        return root;
    }

    /**
     * Returns the number of key-value mappings in this map.
     *
     * @return the number of key-value mappings in this map
     * @implSpec This method should run in O(1) time.
     */
    @Override
    public int size() {
        return size;
    }

    /* NOTE: Please do not modify anything above this line. */

    /**
     * @throws IllegalArgumentException {@inheritDoc}
     * @throws IllegalArgumentException if the specified key contains characters other than
     *                                  lowercase letters
     * @implSpec This method should run in O(H) time.
     * @implSpec This method should use O(1) space.
     */
    @Override
    public V put(CharSequence key, V value) {
        // You'll want to use a Node reference to iteratively walk down the trie
        // to where you want to store the value. Remember, you can reach a
        // Node's child for a particular char value by using that char and the
        // convertToIndex helper to index into the node's children array.
        //
        // Don't forget to update the size appropriately!
        //
        // NOTE: you should return the previous value associated with key, or null if there
        // was no mapping for key.
        
        if (key == null || value == null) {
            throw new IllegalArgumentException(); 
        }
        
        if (key == "") {
            V preVal = root.getValue(); 
            if (preVal == null) {
                size++; 
            }
            root.setValue(value);
            return preVal; 
        }
        
        Node<V> currNode = root; 
        
        // iterate the first n-1 chars
        for (int i = 0; i < key.length() - 1; i++) {
            char currChar = key.charAt(i);
            
            if (currNode.getChild(currChar) == null) {
                currNode.setChild(currChar, new Node<V>(null));
            }
            currNode = currNode.getChild(currChar); 
        }
        
        // last char 
        char lastChar = key.charAt(key.length() - 1); 
        Node<V> lastNode = currNode.getChild(lastChar); 
        if (lastNode == null) {
            currNode.setChild(lastChar, new Node<V>(value));
            size++; 
            return null; 
        } else {
            V prevVal = lastNode.getValue(); 
            lastNode.setValue(value);
            return prevVal; 
        }
    }

    /**
     * @throws IllegalArgumentException {@inheritDoc}
     * @throws IllegalArgumentException if the specified key contains characters other than
     *                                  lowercase letters
     * @implSpec This method should run in O(H) time.
     * @implSpec This method should use O(1) space.
     */
    @Override
    public V get(CharSequence key) {
        if (key == null) {
            throw new IllegalArgumentException(); 
        }
        
        if (key == "") {
            return root.getValue(); 
        }
        
        Node<V> currNode = root; 
        
        for (int i = 0; i < key.length(); i++) {
            char currChar = key.charAt(i);
            
            if (currNode.getChild(currChar) == null) {
                return null; 
            }
            currNode = currNode.getChild(currChar); 
        }
        
        // if last char/node has a value - then valid key, else return null
        return currNode.getValue(); 
    }

    /**
     * @throws IllegalArgumentException {@inheritDoc}
     * @throws IllegalArgumentException if the specified key contains characters other than
     *                                  lowercase letters
     * @implSpec This method should run in O(H) time.
     * @implSpec This method should use O(1) space.
     */
    @Override
    public boolean containsKey(CharSequence key) {
        if (key == null) {
            throw new IllegalArgumentException(); 
        }
        
        if (key == "") {
            return root.getValue() != null; 
        }
        
        Node<V> currNode = root; 
        
        for (int i = 0; i < key.length(); i++) {
            char currChar = key.charAt(i);
            
            if (currNode.getChild(currChar) == null) {
                return false; 
            }
            currNode = currNode.getChild(currChar); 
        }
        
        // if it gets to the last char - check if it has a value 
        return currNode.getValue() != null; 
    }

    /**
     * @throws IllegalArgumentException if the value provided is null
     * @implSpec This method should run in O(N) time.
     */
    @Override
    public boolean containsValue(Object value) {
        // It's possible to implement this just in terms of keySet and get,
        // but that would need to traverse from the root to retrieve each
        // value. A simple tree search manages to be more efficient by just
        // traversing the entire tree once. You can do this recursively, or
        // iteratively with a queue or a stack. If you use a stack, use the
        // Deque class because the Stack class is deprecated.
        if (value == null) {
            throw new IllegalArgumentException(); 
        }
        
        Node<V> currNode = root;
        
        return helperContainsValue(currNode, value); 
    }
    
    boolean helperContainsValue(Node<V> currNode, Object value) {
        Object currVal = currNode.getValue(); 
        
        if (currVal != null && currVal.equals(value)) {
            return true; 
        }
        
        for (int i = 0; i < BRANCH_FACTOR; i++) {
            char currChar = convertToChar(i); 
            if (currNode.getChild(currChar) != null) {
                if (helperContainsValue(currNode.getChild(currChar), value)) {
                    return true; 
                }
            }
        }
        return false; 
    }

    /**
     * @throws IllegalArgumentException {@inheritDoc}
     * @throws IllegalArgumentException if the specified key contains characters other than
     *                                  lowercase letters
     * @implSpec This method should run in O(H) time.
     * @implSpec This method should use O(1) space.
     */
    @Override
    public V remove(CharSequence key) {
        // Part of this will feel like put, but there's more to it than that.
        // Remember, we can't store null values in a TrieMap, but we can store
        // null values in a Node to represent the lack of a value.
        //
        // We also need to make sure that if we remove a key, we don't
        // leave any dangling nodes in the tree. If we put keys "pen" and
        // "penguin", then we remove "penguin", the internal state of the trie
        // should be the same as if we had never even put "penguin"; the
        // four nodes corresponding to "guin" need to be removed.
        //
        // Keep in mind the space requirement when implementing this method;
        // constant space usually means recursion is not possible! (Stack usage
        // counts as space usage.) Also, don't forget to check for exceptions!
        if (key == null) {
            throw new IllegalArgumentException(); 
        }
        
        if (key == "") {
            if (root.getValue() != null) {
                V preVal = root.getValue(); 
                root.setValue(null);
                size--; 
                return preVal; 
            } else {
                return null; 
            }
            
        }
        
        Node<V> currNode = root;
        
        Character marker = null; 
        
        // iterate through n chars
        for (int i = 0; i < key.length() - 1; i++) {
            char currChar = key.charAt(i);
            
            if (currNode.getChild(currChar) == null) {
                return null; 
            }
            
            // determine if marker should be set 
            if (currNode.getValue() != null) {
                marker = currChar; 
            } else {
                for (int j = 0; j < BRANCH_FACTOR; j++) {
                    char otherChar = convertToChar(j); 
                    if (otherChar != currChar && currNode.getChild(otherChar) != null) {
                        marker = currChar; 
                        break; 
                    }
                }
            }

            currNode = currNode.getChild(currChar); 
        }
        
        // last char
        char lastChar = key.charAt(key.length() - 1); 
        Node<V> lastNode = currNode.getChild(lastChar); 
        V oldValue; 
        if (lastNode == null) { 
            return null; 
        } else if (lastNode.getValue() == null) {
            return null; 
        } else {
            oldValue = lastNode.getValue();
            lastNode.setValue(null);
        }
        
        // if last node has children, then just delete value 
        if (lastNode.hasChildren()) {
            size--; 
            return oldValue; 
        }
        // delete from the last marker
        currNode = root;
        if (marker == null) {
            currNode.setChild(key.charAt(0), null);
            size--; 
            return oldValue; 
        }
    
        for (int i = 0; i < key.length(); i++) {
            char currChar = key.charAt(i);
                    
            if (currChar == marker) {
                currNode = currNode.getChild(currChar);
                currNode.setChild(key.charAt(i + 1), null);
                size--;
                return oldValue; 
            }
            currNode = currNode.getChild(currChar); 
        }
        return null; 
    }

    /**
     * @implSpec This method should run in O(1) time.
     */
    @Override
    public void clear() {
        // At first, you might want to do this in terms of keySet and remove.
        // Resist the temptation and find an easier way. Note the running time!
        for (int i = 0; i < BRANCH_FACTOR; i++) {
            char currChar = convertToChar(i); 
            if (root.getChild(currChar) != null) {
                root.setChild(currChar, null);
            }
        }
        size = 0; 
    }

    /**
     * {@inheritDoc}
     * <p>
     * The {@link CharSequence} keys of the {@link java.util.Map.Entry} instances in the resulting 
     * iteration
     * are mutable and should not be referenced directly. Instead, one should call
     * {@link CharSequence#toString()} on the key to get an immutable reference.
     * <p>
     * The iterator must produce entries in lexicographic order. For example, {@code ("party", 99),
     * ("pen", 24), ("penguin", 2), ("q", 17)}
     * <p>
     * This method is for extra credit.
     * To receive full credit, your implementation must satisfy the asymptotic complexities for
     * running time and space. An optimal implementation will use space proportional to at most the
     * height of the trie.
     *
     * @implSpec This method should run in O(H) time.
     * @implSpec The returned iterator should have O(H) operations.
     * @implSpec The returned iterator should use O(H) space.
     * @implNote For partial credit, the space usage of this method can be relaxed to O(V).
     * @implNote You will receive no credit if you dump all of the elements of the trie into a
     * collection and return an iterator over that collection.
     */
    @Override
    public Iterator<Entry<CharSequence, V>> entryIterator() {
        return new Iterator<Entry<CharSequence, V>>() {
            
            Deque<Entry<StringBuilder, Character>> deque = 
                    new ArrayDeque<Entry<StringBuilder, Character>>(); 
            boolean first = true; 
            int count = size; 

            @Override
            public boolean hasNext() {
                return count != 0; 
            }

            @Override
            public Entry<CharSequence, V> next() {
                if (count == 0) {
                    throw new NoSuchElementException(); 
                }
                
                // first time (starting from root) 
                if (first) {
                    Node<V> currNode = root; 
                    StringBuilder str = new StringBuilder(""); 
                    
                    currNode = findKeyValue(currNode, str); 
                    
                    // if currNode has value - it's a key-value pair
                    V value = currNode.getValue(); 
                    
                    if (currNode.hasChildren()) {
                        Entry<StringBuilder, Character> e = new SimpleEntry<StringBuilder, 
                                Character>(str, null); 
                        deque.addFirst(e); 
                    }
                    
                    CharSequence cs = str; 
                    
                    Map.Entry<CharSequence, V> e = new SimpleEntry<CharSequence, V>(cs, value);
                    first = false; 
                    count--; 
                    return e;  
                    
                    // not first time
                } else {
                    Entry<StringBuilder, Character> lastBranch = deque.pollFirst(); 
                    
                    
                    StringBuilder str = lastBranch.getKey(); 
                    Character marker = lastBranch.getValue(); 
                    Node<V> currNode; 
                    // set currNode
                    // if first off the stack is at root
                    if (str.toString().equals("_root_") || str.toString().equals("")) { 
                        currNode = root; 
                        str = new StringBuilder(""); 
                    // iterate until the end of string 
                    } else {
                        currNode = root; 
                        for (int i = 0; i < str.length(); i++) {
                            char currChar = str.charAt(i); 
                            currNode = currNode.getChild(currChar); 
                        }
                    }
                    
                    // if there is no marker
                    if (marker == null) {
                        for (int i = 0; i < BRANCH_FACTOR; i++) {
                            char currChar = convertToChar(i);
                            if (currNode.getChild(currChar) != null) {
                             // check if it has multiple branches - then add to deque
                                checkToAdd(i, currNode, deque, str); 
                                // add currChar to str and go to next node
                                str.append(currChar); 
                                currNode = currNode.getChild(currChar); 
                                break;
                            }
                        }
                    // has a marker
                    } else {
                        checkToAdd(convertToIndex(marker), currNode, deque, str); 
                        
                        str.append(marker); 
                        currNode = currNode.getChild(marker);

                    }

                    currNode = findKeyValue(currNode, str); 
                    
                    // if currNode has value - it's a key-value pair
                    V value = currNode.getValue(); 
                    
                    if (currNode.hasChildren()) {
                        Entry<StringBuilder, Character> e = new SimpleEntry<StringBuilder, 
                                Character>(str, null); 
                        deque.addFirst(e); 
                    }
                    
                    CharSequence cs = str; 
                    
                    Map.Entry<CharSequence, V> e = new SimpleEntry<CharSequence, V>(cs, value); 
                    first = false; 
                    count--; 
                    return e; 
                }
            }
            
            void checkToAdd(int i, Node<V> currNode, Deque<Entry<StringBuilder, 
                    Character>> deque, StringBuilder str) {
                StringBuilder rootStr = new StringBuilder("_root_"); 
                for (int j = i + 1; j < BRANCH_FACTOR; j++) {
                    char otherChar = convertToChar(j); 
                    if (currNode.getChild(otherChar) != null) {
                        if (currNode == root) {
                            Entry<StringBuilder, Character> e = new SimpleEntry<StringBuilder, 
                                    Character>(rootStr, otherChar); 
                            deque.addFirst(e);
                        } else {
                            Entry<StringBuilder, Character> e = new SimpleEntry<StringBuilder, 
                                    Character>(str, otherChar); 
                            deque.addFirst(e);
                        }
                        break; 
                    }
                }
            }
            
            Node<V> findKeyValue(Node<V> currNode, StringBuilder str) {
                while (currNode.getValue() == null) {
                    // find first branch
                    for (int i = 0; i < BRANCH_FACTOR; i++) {
                        char currChar = convertToChar(i); 
                        if (currNode.getChild(currChar) != null) {
                            // check if it has multiple branches - then add to deque
                            checkToAdd(i, currNode, deque, str); 
                            // add currChar to str and go to next node
                            str.append(currChar); 
                            currNode = currNode.getChild(currChar); 
                            break; 
                        }
                    }
                }
                return currNode; 
            } 
        }; 
    }

    /**
     * Carrier for a value and an array of children.
     * You MAY modify this class if you want.
     */
    static class Node<V> {
        private Node<V>[] children;
        private V value;

        Node(V value) {
            this.value = value;
            this.children = null;
        }

        @SuppressWarnings("unchecked")
        public void initChildren() {
            this.children = (Node<V>[]) new Node<?>[BRANCH_FACTOR];
        }

        /**
         * @return {@code true} if this node has child nodes
         */
        public boolean hasChildren() {
            return children != null && Arrays.stream(children).anyMatch(Objects::nonNull);
        }

        /**
         * @param c the character
         * @return the child node for the specified character, or {@code null} if there is no such
         * child
         */
        public Node<V> getChild(char c) {
            if (children == null) {
                return null;
            }
            return children[convertToIndex(c)];
        }
        
        public void setValue(V value) {
            this.value = value; 
        }
        
        /**
         * Sets the child node corresponding to the specified character to the specified node.
         * @param c the character corresponding to the child to set
         * @param node the node to add as a child
         */
        public void setChild(char c, Node<V> node) {
            if (children == null) {
                initChildren();
            }
            children[convertToIndex(c)] = node;
            
        }
        
        public void setParent(Node<V> node) {
            
        }

        /**
         * @return {@code true} if this node has a value
         */
        public boolean hasValue() {
            return value != null;
        }

        /**
         * @return the value at this node
         */
        public V getValue() {
            return value;
        }
    }
}
