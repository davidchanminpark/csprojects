import org.junit.Test;

import java.util.Iterator;
import java.util.Map;
import java.util.NoSuchElementException;
import org.junit.Before;
import static org.junit.Assert.*;

public class HashMapTest {
    static class MockHashObject {
        private final int hashCode;

        public MockHashObject(int hashCode) { 
            this.hashCode = hashCode; 
        }

        @Override
        public int hashCode() { 
            return hashCode; 
        }
    }
    
    private HashMap<MockHashObject, Integer> testMap; 
    
    @Before
    public void setup() {
        testMap = new HashMap<MockHashObject, Integer>(4); 
    }
    
    @Test
    public void sizeEmpty() {
        assertSame(0, testMap.size()); 
    }
    
    @Test
    public void sizeOne() {
        MockHashObject a = new MockHashObject(1); 
        testMap.put(a, 1); 
        
        assertSame(1, testMap.size()); 
    }
    
    @Test
    public void containsKeyTrue() {
        MockHashObject a = new MockHashObject(1); 
        testMap.put(a, 1); 
        
        assertTrue(testMap.containsKey(a)); 
    }
    
    @Test
    public void containsKeyFalse() {
        MockHashObject a = new MockHashObject(1); 
        MockHashObject b = new MockHashObject(2); 
        testMap.put(a, 1); 
        
        assertFalse(testMap.containsKey(b)); 
    }
    
    @Test
    public void containsKeyTrue2() {
        MockHashObject a = new MockHashObject(1); 
        MockHashObject b = new MockHashObject(1); 
        testMap.put(a, 1); 
        testMap.put(b, 1); 
        
        assertTrue(testMap.containsKey(a)); 
    }
    
    @Test
    public void getNull() {
        MockHashObject a = new MockHashObject(0); 
        
        testMap.put(a, 0); 
        assertNull(testMap.get(null));
    }
    
    @Test
    public void get1() {
        MockHashObject a = new MockHashObject(1); 
        MockHashObject b = new MockHashObject(1); 
        testMap.put(a, 1); 
        testMap.put(b, 2); 
        
        assertSame(1, testMap.get(a)); 
    }
    
    @Test
    public void getNull2() {
        MockHashObject a = null;
        MockHashObject b = new MockHashObject(0); 
        testMap.put(a, 1); 
        testMap.put(b, 2); 
        
        assertSame(1, testMap.get(null)); 
    }
    
    @Test
    public void putResize() {
        MockHashObject a = new MockHashObject(1); 
        MockHashObject b = new MockHashObject(1); 
        MockHashObject c = new MockHashObject(1); 
        
        testMap.put(a, 1); 
        testMap.put(b, 2); 
        testMap.put(c, 3); 
        
        assertSame(6, testMap.getThreshold()); 
    }
    
    @Test
    public void putUpdate() {
        MockHashObject a = new MockHashObject(1); 
        
        testMap.put(a, 1); 
        
        assertSame(1, testMap.put(a, 2)); 
    }
    
    @Test
    public void remove1() {
        MockHashObject a = new MockHashObject(1); 
        MockHashObject b = new MockHashObject(1); 
        MockHashObject c = new MockHashObject(1); 
        
        testMap.put(a, 1); 
        testMap.put(b, 2); 
        testMap.put(c, 3); 
        
        testMap.remove(b); 
        assertFalse(testMap.containsKey(b)); 
        assertFalse(testMap.containsValue(2));
        testMap.remove(c); 
        testMap.containsValue(1); 
    }
    
    @Test
    public void clear() {
        MockHashObject a = new MockHashObject(1); 
        
        testMap.put(a, 1); 
        testMap.clear(); 
        
        assertSame(0, testMap.size()); 
        assertFalse(testMap.containsKey(a)); 
    }
    
    @Test
    public void iterator() {
        MockHashObject a = new MockHashObject(1); 
        MockHashObject b = new MockHashObject(1); 
        
        testMap.put(a, 1); 
        testMap.put(b, 2); 
        
        HashMap.Entry<MockHashObject, Integer> entryA = 
                new HashMap.Entry<MockHashObject, Integer>(a, 1, null); 
        HashMap.Entry<MockHashObject, Integer> entryB = 
                new HashMap.Entry<MockHashObject, Integer>(b, 2, entryA); 
        

        Iterator<Map.Entry<MockHashObject, Integer>> iter = testMap.entryIterator(); 
        
        entryA.toString(); 
        entryA.hashCode(); 
        assertTrue(entryA.equals(entryA)); 
        assertFalse(entryA.equals(null)); 
        
        assertTrue(iter.hasNext()); 
        assertTrue(entryB.equals(iter.next())); 
        assertTrue(iter.hasNext()); 
        assertTrue(entryA.equals(iter.next()));            
        assertFalse(iter.hasNext()); 
    }
    
    @Test(expected = NoSuchElementException.class)
    public void iteratorException() {
        Iterator<Map.Entry<MockHashObject, Integer>> iter = testMap.entryIterator(); 
        iter.next(); 
    }
    
    @Test
    public void headRemove() {
        MockHashObject a = new MockHashObject(1); 
        MockHashObject b = new MockHashObject(1); 
        
        testMap.put(a, 1); 
        testMap.put(b, 2); 
        
        assertSame(2, testMap.remove(b)); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constIll() {
        new HashMap<Integer, Integer>(-3, 0.75f); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constIll2() {
        new HashMap<Integer, Integer>(20, -0.75f); 
    }
    
    @Test
    public void constIll3() {
        new HashMap<Integer, Integer>(); 
        testMap.containsKey(null); 
        testMap.remove(null); 
    }
}