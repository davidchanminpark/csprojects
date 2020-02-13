import org.junit.Test;

import java.util.Iterator;
import java.util.Map.Entry;
import java.util.NoSuchElementException;
import org.junit.Before;
import static org.junit.Assert.*;

public class TrieMapTest {
    private TrieMap<Integer> testMap; 
    
    @Before
    public void setup() {
        testMap = new TrieMap<Integer>(); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void putIllegal1() {
        testMap.put(null, 3); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void putIllegal2() {
        testMap.put("david", null); 
    }
    
    @Test
    public void putSimple() {
        assertNull(testMap.put("david", 1)); 
    }
    
    @Test
    public void putSimple2() {
        testMap.put("david", 1); 
        assertSame(1, testMap.put("david", 3)); 
    }
    
    @Test
    public void putSimple3() {
        testMap.put("david", 1); 
        testMap.put("davsef", 5); 
        assertSame(5, testMap.put("davsef", 6)); 
    }
    
    @Test
    public void putSimple4() {
        testMap.put("david", 1); 
        testMap.put("davsef", 5); 
        assertSame(null, testMap.put("wef", 6)); 
    }
    
    @Test
    public void get() {
        testMap.put("david", 1); 
        assertSame(1, testMap.get("david")); 
    }
    
    @Test
    public void get1() {
        testMap.put("david", 1); 
        testMap.put("davsef", 5); 
        assertSame(null, testMap.get("wef")); 
    }
    
    @Test
    public void get2() {
        testMap.put("david", 1); 
        testMap.put("davsef", 5); 
        assertSame(5, testMap.get("davsef")); 
    }
    
    @Test
    public void containsKey1() {
        testMap.put("david", 1); 
        testMap.put("davsef", 5); 
        assertTrue(testMap.containsKey("davsef")); 
    }
    
    @Test
    public void containsKey2() {
        testMap.put("david", 1); 
        testMap.put("davsef", 5); 
        testMap.put("dog", 5);
        assertTrue(testMap.containsKey("dog")); 
    }
    
    @Test
    public void containsValue() {
        testMap.put("david", 1); 
        assertTrue(testMap.containsValue(1)); 
    }
    
    @Test
    public void containsValue2() {
        testMap.put("david", 1); 
        testMap.put("daved", 3); 
        assertTrue(testMap.containsValue(3)); 
    }
    
    @Test
    public void containsValue3() {
        testMap.put("david", 1); 
        testMap.put("daved", 3); 
        testMap.put("cdsf", 2);
        assertTrue(testMap.containsValue(2)); 
    }
    
    @Test
    public void containsValue4() {
        testMap.put("david", 1); 
        testMap.put("daved", 3); 
        testMap.put("cdsf", 2);
        testMap.put("dsfpoj", 10);
        assertTrue(testMap.containsValue(10)); 
    }
    
    @Test
    public void remove1() {
        testMap.put("david", 1); 
        assertSame(1, testMap.remove("david")); 
    }
    
    @Test
    public void remove2() {
        testMap.put("david", 1); 
        testMap.put("dspj", 2); 
        testMap.put("davee", 3); 
        assertNull(testMap.remove("daved")); 
    }
    
    @Test
    public void remove3() {
        testMap.put("david", 1); 
        testMap.put("dspj", 2); 
        testMap.put("davee", 3); 
        assertSame(2, testMap.remove("dspj"));
        assertTrue(testMap.containsKey("davee")); 
        assertTrue(testMap.containsKey("david"));
        assertFalse(testMap.containsKey("dspj")); 
        assertSame(3, testMap.get("davee")); 
    }
    
    @Test
    public void clear1() {
        testMap.put("david", 1); 
        testMap.put("dspj", 2); 
        testMap.put("davee", 3); 
        testMap.clear();
        assertSame(0, testMap.size()); 
        assertFalse(testMap.containsKey("david")); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void putIllegal5() {
        testMap.put("23-08", 3); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void getIllegal5() {
        testMap.get(null); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void getIllegal4() {
        testMap.containsKey(null); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void getIllegal30() {
        testMap.containsValue(null); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void getIllegal32() {
        testMap.remove(null); 
    }
    
    @Test
    public void getEmpty() {
        testMap.put("", 5); 
        assertTrue(testMap.containsKey(""));
        assertSame(5, testMap.get("")); 
        assertSame(5, testMap.remove("")); 
        assertNull(testMap.remove("")); 
        
        
    }
    
    @Test
    public void oihoih() {
        testMap.put("dav", 5);
        testMap.put("davi", 5);  
        assertSame(5, testMap.remove("dav")); 
        
        
    }
    
    @Test
    public void iterator() {
        testMap.put("david", 1); 
        testMap.put("dd", 2); 
        testMap.put("chanmin", 3); 
        
        Iterator<Entry<CharSequence, Integer>> iter = testMap.entryIterator();
        
        assertTrue(iter.hasNext());
        iter.next(); 
        iter.next(); 

    }
    
    @Test
    public void iterator2() {
        testMap.put("david", 1); 
        testMap.put("davids", 2); 
        
        Iterator<Entry<CharSequence, Integer>> iter = testMap.entryIterator();
        

        
        assertTrue(iter.hasNext());
        iter.next(); 
        iter.next(); 

    }
    
    @Test(expected = NoSuchElementException.class)
    public void iterator3() {
        testMap.put("david", 1); 
        testMap.put("davids", 2); 
        
        Iterator<Entry<CharSequence, Integer>> iter = testMap.entryIterator();

        
        assertTrue(iter.hasNext());
        iter.next(); 
        iter.next(); 
        iter.next(); 

        //assertEquals(entryA, iter.next()); 
    }
    
    
}