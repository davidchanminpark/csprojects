import org.junit.Test;
import java.util.NoSuchElementException;
import org.junit.Before;
import static org.junit.Assert.*;

public class UnionFindTest {
    private UnionFind test; 
    
    @Before
    public void setup() {
        test = new UnionFind(5); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void illegalUF() {
        new UnionFind(-2); 
    }
    
    @Test(expected = NoSuchElementException.class)
    public void noSuchUnion1() {
        test.union(-2, 3);
    }
    
    @Test(expected = NoSuchElementException.class)
    public void noSuchUnion2() {
        test.union(6, 3);
    }
    
    @Test(expected = NoSuchElementException.class)
    public void noSuchUnion3() {
        test.union(0, -3);
    }
    
    @Test(expected = NoSuchElementException.class)
    public void noSuchUnion4() {
        test.union(0, 6);
    }
    
    @Test(expected = NoSuchElementException.class)
    public void noSuchFind1() {
        test.find(-2);
    }
    
    @Test(expected = NoSuchElementException.class)
    public void noSuchFind2() {
        test.find(6);
    }
    
    @Test
    public void findBasic() {
        assertSame(test.find(3), 3); 
    }
    
    @Test
    public void findParent() {
        test.union(1, 3);
        assertSame(test.find(3), 1); 
        assertSame(test.find(1), 1); 
    }
    
    @Test
    public void unionBigger() {
        test.union(0, 1);
        test.union(1, 2);
        test.union(3, 4);
        test.union(4, 0);
        
        assertSame(test.find(4), 0); 
        assertSame(test.find(3), 0); 
        assertSame(test.find(2), 0); 
    }
    
    
}