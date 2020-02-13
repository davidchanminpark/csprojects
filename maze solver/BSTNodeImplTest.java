// Full Name: Chanmin Park
// PennKey: ddpp
// CIS 121: Fall 2019

import org.junit.Before;
import java.util.*;
import org.junit.Test;
import static org.junit.Assert.*;

public class BSTNodeImplTest {
    private BSTNodeImpl<Integer> testTree; 
    
    @Before
    public void setup() {
        testTree = new BSTNodeImpl<Integer>(10); 
    }
    
    @Test 
    public void testAddEqual() {
        assertFalse(testTree.add(10)); 
    }
    
    @Test 
    public void testOutputAddLess() {
        assertTrue(testTree.add(8)); 
    }
    
    @Test 
    public void testAddLess() {
        testTree.add(8); 
        assertSame(8, testTree.getLeftChild().getValue()); 
    }
    
    @Test 
    public void testOutputAddMore() {
        assertTrue(testTree.add(11)); 
    }
    
    @Test 
    public void testAddMore() {
        testTree.add(11); 
        assertSame(11, testTree.getRightChild().getValue()); 
    }
    
    @Test
    public void testContainsAtRoot() {
        assertTrue(testTree.contains(10)); 
    }
    
    @Test
    public void testContainsAtLeft() {
        testTree.add(5); 
        assertTrue(testTree.contains(5)); 
    }
    
    @Test
    public void testContainsReturnFalse() {
        testTree.add(5);
        testTree.add(12); 
        testTree.add(15); 
        assertFalse(testTree.contains(13)); 
    }
    
    @Test
    public void testContainsAtRight() {
        testTree.add(12); 
        assertTrue(testTree.contains(12)); 
    }
    
    @Test
    public void testSizeOne() {
        assertEquals(1, testTree.size()); 
    }
    
    @Test
    public void testSizeLarge() {
        testTree.add(1); 
        testTree.add(5); 
        testTree.add(7); 
        testTree.add(29); 
        testTree.add(19); 
        testTree.add(24); 
        assertEquals(7, testTree.size()); 
    }
    
    @Test
    public void testNoLeftChild() {
        assertNull(testTree.getLeftChild()); 
    }
    
    @Test
    public void testLeftChild() {
        testTree.add(6); 
        assertSame(6, testTree.getLeftChild().getValue()); 
    }
    
    @Test
    public void testNoRightChild() {
        assertNull(testTree.getRightChild()); 
    }
    
    @Test
    public void testRightChild() {
        testTree.add(12); 
        assertSame(12, testTree.getRightChild().getValue()); 
    }
    
    @Test
    public void testPreOrderHasNextFalse() {
        Iterator<Integer> iter = testTree.getPreOrderTraversal(); 
        assertFalse(iter.hasNext()); 
    }
    
    @Test
    public void testPreOrderHasNextTrue() {
        testTree.add(9);
        testTree.add(11); 
        Iterator<Integer> iter = testTree.getPreOrderTraversal();
        assertTrue(iter.hasNext()); 
    }
    
    @Test
    public void testPreOrderHasNextTrueTwoPath() {
        testTree.add(9);
        testTree.add(8);
        testTree.add(11);  
        Iterator<Integer> iter = testTree.getPreOrderTraversal();
        iter.next();
        iter.next();
        assertTrue(iter.hasNext()); 
    }
    
    @Test(expected = NoSuchElementException.class)
    public void testPreOrderNextReturnException() {
        Iterator<Integer> iter = testTree.getPreOrderTraversal();
        iter.next(); 
    }
    
    @Test
    public void testPreOrderNextTwoChildren() {
        testTree.add(9); 
        testTree.add(11); 
        Iterator<Integer> iter = testTree.getPreOrderTraversal();
        assertSame(10, iter.next()); 
    }
    
    @Test
    public void testPreOrderNextLeftChild() {
        testTree.add(9);  
        Iterator<Integer> iter = testTree.getPreOrderTraversal();
        assertSame(10, iter.next()); 
    }
    
    @Test
    public void testPreOrderNextRightChild() {
        testTree.add(11);  
        Iterator<Integer> iter = testTree.getPreOrderTraversal();
        assertSame(10, iter.next()); 
    }
    
    @Test
    public void testPreOrderNoChildren() {
        testTree.add(9);
        testTree.add(8);
        testTree.add(11);  
        Iterator<Integer> iter = testTree.getPreOrderTraversal();
        iter.next();
        iter.next(); 
        assertSame(8, iter.next()); 
    }
    
    @Test
    public void testIsValidBSTNoChild() {
        assertTrue(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTTwoChildren() {
        testTree.add(5); 
        testTree.add(12); 
        assertTrue(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTRightChild() {
        testTree.add(12); 
        assertTrue(testTree.isValidBST()); 

    }
    
    @Test
    public void testIsValidBSTLeftChild() {
        testTree.add(7); 
        assertTrue(testTree.isValidBST()); 

    }
    
    @Test
    public void testIsValidBSTRightChildDepth2() {
        testTree.add(12); 
        testTree.add(11); 
        assertTrue(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTLeftChildDepth2() {
        testTree.add(5); 
        testTree.add(7); 
        assertTrue(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTRightChildFalse() {
        testTree.add(15); 
        testTree.getRightChild().add(7); 
        assertFalse(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTLeftChildFalse() {
        testTree.add(5); 
        testTree.getLeftChild().add(11); 
        assertFalse(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTRightChildDepth3() {
        testTree.add(15); 
        testTree.add(13);
        testTree.getRightChild().getLeftChild().add(16); 
        assertFalse(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTLeftChildDepth3() {
        testTree.add(5); 
        testTree.add(7);
        testTree.getLeftChild().getRightChild().add(4); 
        assertFalse(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTBothChildComplex() {
        testTree.add(15);
        testTree.add(5); 
        testTree.add(7);
        testTree.getRightChild().add(11); 
        assertTrue(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTBothChildComplex2() {
        testTree.add(15);
        testTree.add(5); 
        testTree.getRightChild().add(11); 
        assertTrue(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTBothChildComplex2False() {
        testTree.add(15);
        testTree.add(5); 
        testTree.getRightChild().add(9); 
        assertFalse(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTBothChildComplex3() {
        testTree.add(15);
        testTree.add(5); 
        testTree.getLeftChild().add(9); 
        assertTrue(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsValidBSTBothChildComplex3False() {
        testTree.add(15);
        testTree.add(5); 
        testTree.getLeftChild().add(12); 
        assertFalse(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsBSTValidDuplicateBothChild() {
        testTree.add(12);
        testTree.add(5);
        testTree.getLeftChild().add(12);
        assertFalse(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsBSTValidDuplicateLeftChild() {
        testTree.add(5);
        testTree.getLeftChild().add(10);
        assertFalse(testTree.isValidBST()); 

    }
    
    @Test
    public void testIsBSTValidDuplicateRightChild() {
        testTree.add(12);
        testTree.getRightChild().add(10);
        assertFalse(testTree.isValidBST()); 
    }
    
    @Test
    public void testIsStructurallyIdenticalNoChild() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10); 
        assertTrue(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalNoChildFalse() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(4); 
        assertFalse(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalNoChildFalse2() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(11); 
        assertFalse(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalNoChildFalse3() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(9); 
        assertFalse(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalLeftChild() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(9); 
        testTree.add(9); 
        assertTrue(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalLeftChildFalse() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(9); 
        testTree.add(11); 
        assertFalse(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalLeftChildFalse2() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(9); 
        testTree.add(8); 
        assertFalse(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalRightChild() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(11); 
        testTree.add(11); 
        assertTrue(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalRightChildFalse() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(11); 
        testTree.add(8); 
        assertFalse(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalRightChildFalse2() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(11); 
        testTree.add(12); 
        assertFalse(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalBothChild() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(11); 
        testTreeTwo.add(9);
        testTree.add(9); 
        testTree.add(11); 
        assertTrue(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalBothChildFalse() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(11); 
        testTreeTwo.add(9);
        testTree.add(9); 
        testTree.add(12); 
        assertFalse(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test
    public void testIsStructurallyIdenticalBothChildFalse2() {
        BSTNodeImpl<Integer> testTreeTwo = new BSTNodeImpl<Integer>(10);
        testTreeTwo.add(11); 
        testTreeTwo.add(9);
        testTree.add(9); 
        testTree.add(11);
        testTree.add(204); 
        assertFalse(testTree.isStructurallyIdentical(testTreeTwo)); 
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testNullInput() {
        new BSTNodeImpl<Integer>(null); 
    }
    
}