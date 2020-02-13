import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Set;

/**
 *
 * @param <V> {@inheritDoc}
 * @param <Key> {@inheritDoc}
 *
 */
public class BinaryMinHeapImpl<Key extends Comparable<Key>, V> implements BinaryMinHeap<Key, V> {
    
    private int size; 
    private ArrayList<Entry<Key, V>> minHeap; 
    private Map<V, Integer> mapIndices; 
    
    public BinaryMinHeapImpl() {
        size = 0; 
        minHeap = new ArrayList<>(); 
        minHeap.add(0, null); 
        mapIndices = new HashMap<V, Integer>(); 
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int size() {
        return size; 
    }

    @Override
    public boolean isEmpty() {
        return size == 0; 
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean containsValue(V value) {
        return mapIndices.containsKey(value);  
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void add(Key key, V value) {
        if (key == null) {
            throw new IllegalArgumentException(); 
        }
        if (this.containsValue(value)) {
            throw new IllegalArgumentException(); 
        }
        minHeap.add(++size, new Entry<Key, V>(key, value));
        mapIndices.put(value, size); 
        checkParent(size); 
    }
    
    void checkParent(int childIndex) {
        if (childIndex == 1) {
            return; // do nothing
        }
        int parentIndex = childIndex / 2; 
        Entry<Key, V> curr = minHeap.get(childIndex); 
        Entry<Key, V> parent = minHeap.get(parentIndex); 
        int res = curr.getKey().compareTo(parent.getKey()); 
        if (res < 0) {
            minHeap.set(parentIndex, curr); 
            minHeap.set(childIndex, parent);
            mapIndices.replace(curr.getValue(), parentIndex); 
            mapIndices.replace(parent.getValue(), childIndex); 
            checkParent(parentIndex); 
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public V peek() {
        if (size == 0) {
            throw new NoSuchElementException(); 
        }
        Entry<Key, V> minKey = minHeap.get(1); 
        return minKey.getValue(); 
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public V extractMin() {
        if (size == 0) {
            throw new NoSuchElementException(); 
        } else if (size == 1) {
            Entry<Key, V> min = minHeap.remove(1);
            mapIndices.remove(min.getValue()); 
            size--; 
            return min.getValue(); 
        } else {
            
            Entry<Key, V> last = minHeap.get(size);
            Entry<Key, V> min = minHeap.get(1);
            minHeap.set(1, last); 
            minHeap.remove(size);
            mapIndices.replace(last.getValue(), 1); 
            mapIndices.remove(min.getValue()); 
            size--; 
            checkChildren(1); 
            return min.getValue(); 
        }
    }
    
    void checkChildren(int parentIndex) {
        
        int leftChildIndex = parentIndex * 2; 
        int rightChildIndex = (parentIndex * 2) + 1;
         
        Entry<Key, V> parent = minHeap.get(parentIndex);
        Entry<Key, V> smallestKey = parent;
        int smallestKeyIndex = parentIndex; 
        
        if (leftChildIndex <= size) { 
            Entry<Key, V> leftChild = minHeap.get(leftChildIndex); 
            if (leftChild.getKey().compareTo(parent.getKey()) < 0) { 
                smallestKey = leftChild; 
                smallestKeyIndex = leftChildIndex; 
            }
        }
        
        if (rightChildIndex <= size) {
            Entry<Key, V> rightChild = minHeap.get(rightChildIndex); 
            if (rightChild.getKey().compareTo(smallestKey.getKey()) < 0) {
                smallestKey = rightChild; 
                smallestKeyIndex = rightChildIndex; 
            }
        }
        
        if (!smallestKey.equals(parent)) {
            minHeap.set(parentIndex, smallestKey); 
            minHeap.set(smallestKeyIndex, parent); 
            mapIndices.replace(smallestKey.getValue(), parentIndex); 
            mapIndices.replace(parent.getValue(), smallestKeyIndex); 
            checkChildren(smallestKeyIndex); 
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Set<V> values() {
        Set<V> vals = new HashSet<V>(); 
        Iterator<BinaryMinHeapImpl<Key, V>.Entry<Key, V>> it = minHeap.iterator(); 
        
        while (it.hasNext()) {
            Entry<Key, V> curr = it.next();
            if (curr != null) {
                vals.add(curr.getValue()); 
            } 
        } 
        return vals; 
    }
    /**
     * Helper entry class for maintaining value-key pairs.
     * The underlying indexed list for your heap will contain
     * these entries.
     *
     * You are not required to use this, but we recommend it.
     */
    class Entry<A, B> {

        private A key;
        private B value;

        public Entry(A key, B value) {
            this.value = value;
            this.key = key;
        }

        /**
         * @return  the value stored in the entry
         */
        public B getValue() {
            return this.value;
        }

        /**
         * @return  the key stored in the entry
         */
        public A getKey() {
            return this.key;
        }

        /**
         * Changes the key of the entry.
         *
         * @param key  the new key
         * @return  the old key
         */
        public A setKey(A key) {
            A oldKey = this.key;
            this.key = key;
            return oldKey;
        }
    }
    ArrayList<Key> getKeys() {
        ArrayList<Key> keys = new ArrayList<Key>(); 
        Iterator<BinaryMinHeapImpl<Key, V>.Entry<Key, V>> it = minHeap.iterator(); 
            
        while (it.hasNext()) {
            Entry<Key, V> curr = it.next();
            if (curr != null) {
                keys.add(curr.getKey()); 
            } else {
                keys.add(null); 
            }
        } 
        return keys; 
    }
    
    /**
     * {@inheritDoc}
     */
    @Override
    public void decreaseKey(V value, Key newKey) {
        if (newKey == null) {
            throw new IllegalArgumentException(); 
        }
        if (!containsValue(value)) {
            throw new NoSuchElementException(); 
        } else {
            int indexOfValue = mapIndices.get(value);
            Entry<Key, V> curr = minHeap.get(indexOfValue);
             
            int res = newKey.compareTo(curr.getKey());
            if (res > 0) {
                throw new IllegalArgumentException(); 
            } else {
                curr.setKey(newKey); 
                minHeap.add(indexOfValue, curr); 
                checkParent(indexOfValue); 
            }
        }
    }
}