import org.junit.Test;
import java.util.NoSuchElementException;
import org.junit.Before;
import static org.junit.Assert.*;

public class BinaryMinHeapImplTest {
    private BinaryMinHeapImpl<Integer, Integer> emptyHeap;
    private BinaryMinHeapImpl<Integer, Integer> sizeOneHeap;
    private BinaryMinHeapImpl<Integer, Integer> testHeap;
    private BinaryMinHeapImpl<Integer, Integer> testHeapSame;
    private BinaryMinHeapImpl<Integer, Integer> dijk;

    @Before 
    public void setup() {
        emptyHeap = new BinaryMinHeapImpl<Integer, Integer>();
        sizeOneHeap = new BinaryMinHeapImpl<Integer, Integer>();
        sizeOneHeap.add(3, 3);
        
        testHeap = new BinaryMinHeapImpl<Integer, Integer>();
        testHeap.add(1, 1);
        testHeap.add(2, 2);
        testHeap.add(3, 3);
        testHeap.add(4, 4);
        testHeap.add(5, 5);
        
        testHeapSame = new BinaryMinHeapImpl<Integer, Integer>();
        testHeapSame.add(1, 6);
        testHeapSame.add(1, 3);
        testHeapSame.add(1, 4);
        testHeapSame.add(1, 5);
        
        dijk = new BinaryMinHeapImpl<Integer, Integer>();
        
        
    }
    
    @Test
    public void testSize() {
        assertEquals(1, sizeOneHeap.size()); 
    }
    
    @Test
    public void testIsEmptyTrue() {
        assertTrue(emptyHeap.isEmpty()); 
    }
    
    @Test
    public void testIsEmptyFalse() {
        assertFalse(sizeOneHeap.isEmpty()); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void addNullKey() {
        sizeOneHeap.add(null, 5);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void addSameValue() {
        sizeOneHeap.add(10, 3);
    }
    
    @Test
    public void addToEmpty() {
        emptyHeap.add(4, 5);
        Integer[] correct = {null, 4}; 
        assertArrayEquals(correct, emptyHeap.getKeys().toArray()); 
    }
    
    @Test
    public void addToEmptyTwo() {
        emptyHeap.add(4, 4);
        emptyHeap.add(3, 3);
        Integer[] correct = {null, 3, 4}; 
        assertArrayEquals(correct, emptyHeap.getKeys().toArray()); 
    }
    
    @Test
    public void addToEmptyThree() {
        emptyHeap.add(4, 4);
        emptyHeap.add(3, 3);
        emptyHeap.add(3, 2);
        Integer[] correct = {null, 3, 4, 3}; 
        assertArrayEquals(correct, emptyHeap.getKeys().toArray()); 
    }
    
    @Test(expected = NoSuchElementException.class)
    public void peekEmpty() {
        emptyHeap.peek();
    }
    
    @Test
    public void peekSizeOne() {
        assertSame(3, sizeOneHeap.peek());
    }
    
    @Test(expected = NoSuchElementException.class)
    public void extractMinEmpty() {
        emptyHeap.extractMin(); 
    }
    
    @Test
    public void extractMinSizeOne() {
        assertSame(3, sizeOneHeap.extractMin()); 
    }
    
    @Test
    public void extractMinTestHeap() {
        testHeap.extractMin(); 
        assertSame(2, testHeap.extractMin()); 
    }
    
    @Test
    public void extractMinTestHeap2() {
        testHeap.extractMin();
        testHeap.extractMin(); 
        assertSame(3, testHeap.extractMin()); 
    }
    
    @Test
    public void valuesSame() {
        Integer[] values = {3, 4, 5, 6}; 
        assertArrayEquals(values, testHeapSame.values().toArray()); 
    }
    
    @Test
    public void valuesSame2() {
        testHeapSame.extractMin(); 
        Integer[] values = {3, 4, 5}; 
        assertArrayEquals(values, testHeapSame.values().toArray()); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void decreaseKeyNull() {
        testHeap.decreaseKey(3, null);
    }
    
    @Test(expected = NoSuchElementException.class)
    public void decreaseKeyNotContain() {
        testHeap.decreaseKey(6, 5);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void decreaseKeyNewGreaterThanCurr() {
        testHeap.decreaseKey(5, 6);
    }
    
    @Test
    public void decreaseKeySizeOneHeap() {
        sizeOneHeap.decreaseKey(3, 2); 
        Integer[] correct = {null, 2}; 
        assertArrayEquals(correct, sizeOneHeap.getKeys().toArray()); 
    }
    
    @Test
    public void decreaseKey() {
        testHeapSame.decreaseKey(5, 0); 
        Integer[] correct = {null, 0, 1, 1, 1}; 
        assertArrayEquals(correct, testHeapSame.getKeys().toArray()); 
    }
    
    @Test
    public void decreaseKeyDijkstra() {
        dijk.add(0, 1);
        dijk.extractMin(); 
        Integer[] values = {}; 
        assertArrayEquals(values, dijk.values().toArray()); 
    }
    
    @Test
    public void decreaseKeyDijkstra1() {
        dijk.add(0, 1);
        dijk.extractMin();
        dijk.add(12, 2); 
        dijk.add(15, 3);
        Integer[] values = {2, 3}; 
        assertArrayEquals(values, dijk.values().toArray()); 
    }
    
    @Test
    public void decreaseKeyDijkstra2() {
        dijk.add(0, 1);
        dijk.extractMin(); 
        dijk.add(12, 2); 
        dijk.add(15, 3);
        dijk.add(4, 7);
        Integer[] keys = {null, 4, 15, 12}; 
        assertArrayEquals(keys, dijk.getKeys().toArray()); 
    }
    
    @Test
    public void decreaseKeyDijkstra3() {
        dijk.add(0, 1);
        dijk.extractMin(); 
        dijk.add(12, 2); 
        dijk.add(15, 3);
        dijk.add(4, 7);
        
        assertSame(7, dijk.peek()); 
    }
    
    @Test
    public void decreaseKeyDijkstra4() {
        dijk.add(0, 1);
        dijk.extractMin(); 
        dijk.add(12, 2); 
        dijk.add(15, 3);
        dijk.add(4, 7);
        dijk.extractMin(); 
        dijk.add(11, 2);
        
        Integer[] keys = {null, 10, 15, 11}; 
        assertArrayEquals(keys, dijk.getKeys().toArray()); 
    }
    
    
}