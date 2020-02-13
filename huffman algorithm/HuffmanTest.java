import org.junit.Test;

import java.util.HashMap;
import java.util.Map;
import org.junit.Before;
import static org.junit.Assert.*;

public class HuffmanTest {
    private String sameCharSeed; 
    private Map<Character, Integer> onlyOneMapSeed;
    private String simpleStrSeed;
    private Map<Character, Integer> simpleMapSeed; 
    private Map<Character, Integer> simpleMapSeedSame; 
    private Map<Character, Integer> simpleMapSeedSame2; 

    
    @Before
    public void setup() {
        sameCharSeed = "aaa";
        onlyOneMapSeed = new HashMap<Character, Integer>(); 
        onlyOneMapSeed.put('c', 4); 
        simpleStrSeed = "abcaac"; 
        simpleMapSeed = new HashMap<Character, Integer>(); 
        simpleMapSeed.put('a', 3); 
        simpleMapSeed.put('b', 1);
        simpleMapSeed.put('c', 2);
        simpleMapSeedSame = new HashMap<Character, Integer>(); 
        simpleMapSeedSame.put('a', 2); 
        simpleMapSeedSame.put('b', 2);
        simpleMapSeedSame.put('c', 2);
        simpleMapSeedSame2 = new HashMap<Character, Integer>(); 
        simpleMapSeedSame2.put('a', 2); 
        simpleMapSeedSame2.put('b', 2);
        simpleMapSeedSame2.put('c', 2);
        simpleMapSeedSame2.put('d', 2);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructorSameSeed() {
        new Huffman(sameCharSeed); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructorNullStr() {
        String nul = null; 
        new Huffman(nul); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructorNullMap() {
        HashMap<Character,Integer> nul = null; 
        new Huffman(nul); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructorMapOneSeed() {
        new Huffman(onlyOneMapSeed); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructorMapNegFreq() {
        onlyOneMapSeed.put('_', -5);
        new Huffman(onlyOneMapSeed); 
    }
    
    @Test
    public void constructorCompareSimpleSeed() {
        Huffman mapSimple = new Huffman(simpleMapSeed);
        Huffman strSimple = new Huffman(simpleStrSeed); 
        
        assertSame(mapSimple.getOrder(), strSimple.getOrder()); 
    }
    
    @Test
    public void constructorCompareSimpleSeed2() {
        Huffman mapSimple = new Huffman(simpleMapSeed);
        Huffman strSimple = new Huffman(simpleStrSeed); 
        
        assertEquals(mapSimple.getEncoded(), strSimple.getEncoded()); 
    }
    
    @Test
    public void compressSimpleSeed() {
        Huffman strSimple = new Huffman(simpleStrSeed); 
        String binary = strSimple.compress("b"); 
        
        assertEquals("10", binary); 
    }
    
    @Test
    public void compressSimpleSeed2() {
        Huffman strSimple = new Huffman(simpleStrSeed); 
        String binary = strSimple.compress("c"); 
        
        assertEquals("11", binary); 
    }
    
    @Test
    public void compressSimpleSeed3() {
        Huffman strSimple = new Huffman(simpleStrSeed); 
        String binary = strSimple.compress("a"); 
        
        assertEquals("0", binary); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void compressSimpleSeedNull() {
        Huffman strSimple = new Huffman(simpleStrSeed); 
        strSimple.compress(null); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void compressSimpleSeedInvalidChar() {
        Huffman strSimple = new Huffman(simpleStrSeed); 
        strSimple.compress("abcd"); 
    }
    
    @Test
    public void compressSimpleSeedEmpty() {
        Huffman strSimple = new Huffman(simpleStrSeed); 
        String binary = strSimple.compress(""); 
        
        assertEquals("", binary); 
    }
    
    @Test
    public void compressSimpleSeed4() {
        Huffman strSimple = new Huffman(simpleMapSeed); 
        String binary = strSimple.compress("b"); 
        
        assertEquals("10", binary); 
    }
    
    @Test
    public void compressSimpleSeedLong() {
        Huffman strSimple = new Huffman(simpleMapSeed); 
        String binary = strSimple.compress("abcccbbba"); 
        
        assertEquals("0101111111010100", binary); 
    }
    
    @Test(expected = IllegalStateException.class)
    public void compressionRatioNone() {
        Huffman strSimple = new Huffman(simpleMapSeed); 
        strSimple.compressionRatio(); 
    }
    
    @Test
    public void compressionRatioOnce() {
        Huffman strSimple = new Huffman(simpleMapSeed); 
        strSimple.compress("abcccbbba"); 
        double result = strSimple.compressionRatio();
        double correct = (double) 16 / 144; 
        assertEquals(correct, result, 0.0); 
    }
    
    @Test
    public void compressionRatioTwice() {
        Huffman strSimple = new Huffman(simpleMapSeed); 
        strSimple.compress("abcccbbba");
        strSimple.compress("a");
        double result = strSimple.compressionRatio();
        double correct = (double) 17 / 160; 
        assertEquals(correct, result, 0.0); 
    }
    
    @Test
    public void decompressSimpleSeed1() {
        Huffman strSimple = new Huffman(simpleMapSeed); 
        String decoded = strSimple.decompress("0101111111010100");
        assertEquals("abcccbbba", decoded); 
    }
    
    @Test(expected = IllegalArgumentException.class)    
    public void decompressNull() {
        Huffman strSimple = new Huffman(simpleMapSeed); 
        strSimple.decompress(null);
    }
    
    @Test(expected = IllegalArgumentException.class)    
    public void decompressNullNotBinary() {
        Huffman strSimple = new Huffman(simpleMapSeed); 
        strSimple.decompress("012001");
    }
    
    @Test
    public void compressSimpleSeedSame1() {
        Huffman strSimple = new Huffman(simpleMapSeedSame); 
        String binary = strSimple.compress("a"); 
        
        assertEquals("10", binary); 
    }
    
    @Test
    public void compressSimpleSeedSame2() {
        Huffman strSimple = new Huffman(simpleMapSeedSame); 
        String binary = strSimple.compress("b"); 
        
        assertEquals("11", binary); 
    }
    
    @Test
    public void compressSimpleSeedSame3() {
        Huffman strSimple = new Huffman(simpleMapSeedSame); 
        String binary = strSimple.compress("c"); 
        
        assertEquals("0", binary); 
    }
    
    @Test
    public void expectedEncodingLength() {
        Huffman strSimple = new Huffman(simpleMapSeed); 
        double eel = strSimple.expectedEncodingLength(); 
        
        assertEquals(1.5, eel, 0); 
    }
    
    @Test
    public void compressSimpleSeedABCD() {
        Huffman strSimple = new Huffman(simpleMapSeedSame2); 
        String binary = strSimple.compress("a"); 
        
        assertEquals("00", binary); 
    }
    
    @Test
    public void compressSimpleSeedABCD2() {
        Huffman strSimple = new Huffman(simpleMapSeedSame2); 
        String binary = strSimple.compress("b"); 
        
        assertEquals("01", binary); 
    }
    
    
    
    
   
    
}