import org.junit.Test;

import static org.junit.Assert.*;

public class QuadTreeNodeImplTest {
    private int[][] imageOneByOne = {
            {7}
    }; 
    
    private int[][] imageNoLength = new int[3][0]; 
    private int[][] imageTwoByTwo = {
            {7, 8}, 
            {4, 5}
    }; 
    
    private int[][] imageTwoByTwoSame = {
            {3, 3}, 
            {3, 3}
    };
            
    private int[][] imageInvalid1 = {
            {2, 3, 3, 4}, 
            {2, 4, 3, -2}
    }; 
        
    private int[][] imageInvalid2 = {
            {4, 2, 7}, 
            {4, 3, 35}, 
            {6, 3, -2}
    }; 
    
    private int[][] imageFourByFourAllDiff = {
            {2, 3, 4, 5}, 
            {3, 7, 0, -4}, 
            {20, 20, 20, 20}, 
            {4, 90, 20842, 9}
    }; 
    
    private int[][] imageFourByFour1 = {
            {2, 2, 4, 5}, 
            {2, 2, 0, -4}, 
            {20, 20, 20, 20}, 
            {4, 90, 20, 20}
    }; 
    
    private int[][] imageFourByFour2 = {
            {2, 9, 0, 0}, 
            {2, 2, 0, 0}, 
            {210, 20, 22, 20}, 
            {4, 90, 20, 20}
    }; 
    
    private int[][] imageFourByFour2Rev = {
            {2, 9, 0, 92}, 
            {2, 2, 0, 0}, 
            {210, 20, 20, 20}, 
            {4, 90, 20, 20}
    }; 
    
    private int[][] imageFourByFourSame = {
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}
    }; 
    
    private int[][] imageFourByFourSameRev = {
            {0, 0, 0, 0}, 
            {0, 0, 0, 0}, 
            {0, 0, 1, 0}, 
            {0, 0, 0, 0}
    }; 
    
    
    @Test(expected = IllegalArgumentException.class)
    public void testBuildNull() {
        QuadTreeNodeImpl.buildFromIntArray(null); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testBuildPowerTwo() {
        QuadTreeNodeImpl.buildFromIntArray(imageInvalid2); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testBuildRectangle() {
        QuadTreeNodeImpl.buildFromIntArray(imageInvalid1); 
    }
    
    @Test
    public void testBuildOneByOneGetColor() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne);
        int col = testNode.getColor(0, 0);
        assertEquals(7, col); 
    }
    
    @Test
    public void testBuildTwoByTwoGetColor() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo);
        int col = testNode.getColor(0, 0);
        assertEquals(7, col); 
    }
    
    @Test
    public void testBuildTwoByTwoGetColor2() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo);
        int col = testNode.getColor(0, 1);
        assertEquals(4, col); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testBuildTwoByTwoGetColorOutOfBounds() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo);
        testNode.getColor(3, 0);
    }
    
    @Test
    public void testBuildTwoByTwoGetColorSame() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwoSame);
        int col = testNode.getColor(1, 1);
        assertEquals(3, col); 
    }
    
    @Test
    public void testBuildFourByFourGetColorSame() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFourSame);
        int col = testNode.getColor(3, 1);
        assertEquals(0, col); 
    }
    
    @Test
    public void testBuildFourByFourGetColorAllDiff() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFourAllDiff);
        int col = testNode.getColor(2, 2);
        assertEquals(20, col); 
    }
    
    @Test
    public void testBuildFourByFourGetColor1() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFour1);
        int col = testNode.getColor(0, 3);
        assertEquals(4, col); 
    }
    
    @Test
    public void testBuildFourByFourGetColor2() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFour1);
        int col = testNode.getColor(3, 2);
        assertEquals(20, col); 
    }
    
    @Test
    public void testDecompress1() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFour1);
        int[][] testImage = testNode.decompress(); 
        assertArrayEquals(imageFourByFour1, testImage); 
    }
    
    @Test
    public void testDecompress2() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne);
        int[][] testImage = testNode.decompress(); 
        assertArrayEquals(imageOneByOne, testImage); 
    }
    
    @Test
    public void testDecompress3() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo);
        int[][] testImage = testNode.decompress(); 
        assertArrayEquals(imageTwoByTwo, testImage); 
    }
    
    @Test
    public void testDecompress4() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFourSame);
        int[][] testImage = testNode.decompress(); 
        assertArrayEquals(imageFourByFourSame, testImage); 
    }
    
    @Test
    public void testSetColor() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFourSame);
        testNode.setColor(2, 2, 1); 
        int[][] testImage = testNode.decompress(); 
        assertArrayEquals(imageFourByFourSameRev, testImage); 
    }
    
    @Test
    public void testGetColor() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFourSameRev);
        int col = testNode.getColor(2, 2); 
        assertEquals(1, col); 
    }
    
    @Test
    public void testGetSizeMerge() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwoSame);
        int testSize = testNode.getSize(); 
        assertEquals(1, testSize); 
    }
    
    @Test
    public void testGetSizeNonMerge() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo);
        int testSize = testNode.getSize(); 
        assertEquals(5, testSize); 
    }
    
    @Test
    public void testGetSizeSpecial() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFour1);
        int testSize = testNode.getSize(); 
        assertEquals(13, testSize); 
    }
    
    @Test
    public void testSetGetColor1() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne);
        testNode.setColor(0, 0, 3); 
        int newCol = testNode.getColor(0, 0); 
        assertEquals(3, newCol); 
    }
    
    @Test
    public void testSetGetColor2() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo);
        testNode.setColor(1, 1, -3); 
        int newCol = testNode.getColor(1, 1); 
        assertEquals(-3, newCol); 
    }
    
    @Test
    public void testSetGetColor() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFourSame);
        testNode.setColor(2, 2, 1); 
        int newCol = testNode.getColor(2, 2); 
        assertEquals(1, newCol); 
    }
    
    @Test
    public void testSetGetColor3() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFour2);
        testNode.setColor(2, 2, 1); 
        testNode.setColor(3, 0, 92);
        testNode.setColor(2, 2, 20); 
        int[][] testImage = testNode.decompress(); 
        assertArrayEquals(imageFourByFour2Rev, testImage); 
    }
    
    @Test
    public void testGetSizeSpecial3() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFour2);
        int testSize = testNode.getSize(); 
        assertEquals(17, testSize); 
    }
    
    @Test
    public void testGetSizeSpecial4() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFour2Rev);
        int testSize = testNode.getSize(); 
        assertEquals(17, testSize); 
    }
    
    @Test
    public void testIsLeaf() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        assertTrue(testNode.isLeaf()); 
    }
    
    @Test
    public void testIsLeafFalse() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo); 
        assertFalse(testNode.isLeaf()); 
    }
    
    @Test
    public void testCompressionRatio() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        assertEquals(1.0, testNode.getCompressionRatio(), 0);
    }
    
    @Test
    public void testCompressionRatio2() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo); 
        assertEquals(1.25, testNode.getCompressionRatio(), 0);
    }
    
    @Test
    public void testCompressionRatio3() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFour2); 
        assertEquals(17.0 / 16.0, testNode.getCompressionRatio(), 0);
    }
    
    @Test
    public void testGetQuadrant() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        assertSame(null, testNode.getQuadrant(QuadTreeNode.QuadName.TOP_LEFT));
    }
    
    @Test
    public void testGetQuadrant2() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        assertSame(null, testNode.getQuadrant(QuadTreeNode.QuadName.TOP_RIGHT));
    }
    
    @Test
    public void testGetQuadrant3() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        assertSame(null, testNode.getQuadrant(QuadTreeNode.QuadName.BOTTOM_LEFT));
    }
    
    @Test
    public void testGetQuadrant4() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        assertSame(null, testNode.getQuadrant(QuadTreeNode.QuadName.BOTTOM_RIGHT));
    }
    
    @Test
    public void testSizeOne() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        assertSame(1, testNode.getSize());
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testNoLength() {
        QuadTreeNodeImpl.buildFromIntArray(imageNoLength); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testSetColorError() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        testNode.setColor(-3, 4, 2);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testSetColorError2() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        testNode.setColor(2, 0, 2);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testSetColorError3() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        testNode.setColor(0, 3, 2);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testSetColorError4() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        testNode.setColor(0, -3, 2);
    }
    
    @Test
    public void testSetColorNoChange() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageOneByOne); 
        testNode.setColor(0, 0, 7);
    }
    
    @Test
    public void testSetGetColorA() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFourSame);
        testNode.setColor(1, 1, 1); 
        int newCol = testNode.getColor(1, 1); 
        assertEquals(1, newCol); 
    }
    
    @Test
    public void testSetGetColorB() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFourSame);
        testNode.setColor(1, 3, 1); 
        int newCol = testNode.getColor(1, 3); 
        assertEquals(1, newCol); 
    }
    
    @Test
    public void testSetGetColorC() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageFourByFourSame);
        testNode.setColor(2, 0, 1); 
        int newCol = testNode.getColor(2, 0); 
        assertEquals(1, newCol); 
    }
    
    @Test
    public void testSetGetColorD() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo);
        testNode.setColor(1, 1, 1); 
        int newCol = testNode.getColor(1, 1); 
        assertEquals(1, newCol); 
    }
    
    @Test
    public void testSetGetColorE() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo);
        testNode.setColor(1, 0, 1); 
        int newCol = testNode.getColor(1, 0); 
        assertEquals(1, newCol); 
    }
    
    @Test
    public void testSetGetColorF() {
        QuadTreeNode testNode = QuadTreeNodeImpl.buildFromIntArray(imageTwoByTwo);
        testNode.setColor(0, 1, 1); 
        int newCol = testNode.getColor(0, 1); 
        assertEquals(1, newCol); 
    }
}

