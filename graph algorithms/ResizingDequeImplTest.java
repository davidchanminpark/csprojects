import org.junit.Test;

import java.util.Iterator;
import java.util.NoSuchElementException;

import org.junit.Before;
import static org.junit.Assert.*;

public class ResizingDequeImplTest {
    private ResizingDequeImpl<Integer> empty; 
    private ResizingDequeImpl<Integer> testSizeTwo;
    private ResizingDequeImpl<Integer> testBfs; 
    
    @Before
    public void setup() {
        empty = new ResizingDequeImpl<Integer>(); 
        testSizeTwo = new ResizingDequeImpl<Integer>(); 
        testSizeTwo.addFirst(1);
        testSizeTwo.addLast(3); // head = 1, tail = 3
        testBfs = new ResizingDequeImpl<Integer>(); 
    }
    
    @Test
    public void testSizeEmpty() {
        assertEquals(0, empty.size()); 
    }
    
    @Test
    public void testSizeTwo() {
        assertEquals(2, testSizeTwo.size()); 
    }
    
    @Test
    public void getArrayEmpty() {
        Integer[] correct = {null, null}; 
        assertArrayEquals(correct, empty.getArray()); 
    }
    
    @Test
    public void getArrayTwo() {
        Integer[] correct = {1, 3}; 
        assertArrayEquals(correct, testSizeTwo.getArray()); 
    }
    
    @Test
    public void addToEmpty() {
        Integer[] correct = {1, null};
        empty.addLast(1);
        assertArrayEquals(correct, empty.getArray());
    }
    
    @Test
    public void resizeUp() {
        Integer[] correct = {1, 3, null, null};
        testSizeTwo.resizeUp();
        assertArrayEquals(correct, testSizeTwo.getArray()); 
    }
    
    @Test
    public void addFirstTwo() {
        testSizeTwo.addFirst(7);
        Integer[] correct = {1, 3, null, 7}; 
        assertArrayEquals(correct, testSizeTwo.getArray()); 
    }
    
    @Test
    public void addLastTwo() {
        testSizeTwo.addLast(7);
        Integer[] correct = {1, 3, 7, null}; 
        assertArrayEquals(correct, testSizeTwo.getArray()); 
    }
    
    @Test
    public void pollFirst() {
        testSizeTwo.pollFirst();
        Integer[] correct = {null, 3}; 
        assertArrayEquals(correct, testSizeTwo.getArray()); 
    }
    
    @Test(expected = NoSuchElementException.class)
    public void pollFirstEmpty() {
        empty.pollFirst();  
    }
    
    @Test
    public void resizeDown() {
        Integer[] correct = {1, 3};
        testSizeTwo.resizeUp();
        testSizeTwo.resizeDown();
        assertArrayEquals(correct, testSizeTwo.getArray()); 
    }
    
    @Test
    public void pollLastResizeDown() {
        testSizeTwo.addLast(5);
        testSizeTwo.pollFirst(); 
        testSizeTwo.pollLast(); 
        testSizeTwo.pollLast(); 
        Integer[] correct = {null, null}; 
        assertArrayEquals(correct, testSizeTwo.getArray()); 
    }
    
    @Test
    public void pollFirstResizeDown() {
        testSizeTwo.addLast(5);
        testSizeTwo.pollFirst(); 
        testSizeTwo.pollLast(); 
        testSizeTwo.pollFirst(); 
        Integer[] correct = {null, null}; 
        assertArrayEquals(correct, testSizeTwo.getArray()); 
    }
    
    @Test(expected = NoSuchElementException.class)
    public void peekFirstEmpty() {
        empty.peekFirst();
    }
    
    @Test(expected = NoSuchElementException.class)
    public void peekLastEmpty() {
        empty.peekLast();
    }
   
    
    @Test(expected = NoSuchElementException.class)
    public void pollLastEmpty() {
        empty.pollLast();
    }
    
    @Test
    public void peekFirstTwo() {
        assertSame(1, testSizeTwo.peekFirst()); 
    }
    
    @Test
    public void peekLastTwo() {
        assertSame(3, testSizeTwo.peekLast()); 
    }
    
    @Test
    public void iterHasNextTrue() {
        Iterator<Integer> iter = testSizeTwo.iterator(); 
        assertTrue(iter.hasNext());
    }
    
    @Test
    public void iterHasNextFalse() {
        Iterator<Integer> iter = empty.iterator(); 
        assertFalse(iter.hasNext());
    }
    
    @Test(expected = NoSuchElementException.class)
    public void iterNextEmpty() {
        Iterator<Integer> iter = empty.iterator(); 
        iter.next(); 
    }
    
    @Test
    public void iterNextTwo() {
        Iterator<Integer> iter = testSizeTwo.iterator(); 
        assertSame(1, iter.next()); 
    }
    
    @Test
    public void addFirstTwoNoWrap() {
        Integer[] correct = {1, 3, 5, 7}; 
        testSizeTwo.addLast(5);
        testSizeTwo.addLast(7);
        testSizeTwo.pollFirst(); 
        testSizeTwo.addLast(1);
        assertArrayEquals(correct, testSizeTwo.getArray()); 
    }
    
    @Test 
    public void testBfs() {
        testBfs.addFirst(0);
        testBfs.pollFirst(); 
        testBfs.addFirst(1);
        testBfs.addFirst(2);
        testBfs.addFirst(3);
        Integer[] correct = {2, 1, null, 3}; 
        assertArrayEquals(correct, testBfs.getArray());
        assertSame(3, testBfs.getHead()); 
        assertSame(1, testBfs.getTail());
    }
    
    @Test 
    public void testBfs2() {
        testBfs.addFirst(0);
        testBfs.pollFirst(); 
        testBfs.addFirst(1);
        testBfs.addFirst(2);
        testBfs.addFirst(3);
        testBfs.pollFirst(); 
        testBfs.pollFirst(); 
        testBfs.pollFirst(); 
        Integer[] correct = {null, null}; 
        assertArrayEquals(correct, testBfs.getArray());
        assertSame(0, testBfs.size()); 
    }
    
    @Test 
    public void testBfs3() {
        testBfs.addFirst(0);
        testBfs.pollFirst(); 
        testBfs.addFirst(1);
        testBfs.addFirst(2);
        testBfs.addFirst(3);
        testBfs.pollFirst();
        testBfs.pollFirst(); 
        Integer[] correct = {null, 1, null, null};
        assertArrayEquals(correct, testBfs.getArray());
        assertSame(1, testBfs.getHead()); 
        assertSame(1, testBfs.getTail());
    }
    
    @Test
    public void testBfs4() {
        testBfs.addFirst(0);
        testBfs.pollFirst(); 
        testBfs.addFirst(1);
        testBfs.addFirst(2);
        testBfs.addFirst(3);
        testBfs.pollFirst();
        testBfs.pollFirst();
        assertSame(1, testBfs.pollFirst()); 
    }
    
    
}