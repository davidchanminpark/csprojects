// Full Name: Chanmin Park
// PennKey: ddpp
// CIS 121: Fall 2019

import java.util.Iterator;
import java.util.*; 

public class BSTNodeImpl<E extends Comparable<E>> implements BSTNode<E> {

    /*
     * We've created this stub file as a starting point. Note we've included a skeleton of the
     * header for you to fill out. This header must be included in EVERY file you submit. Please
     * complete the methods below and reference BSTNode.java for method details.
     *
     * To view documentation directly on Eclipse, hover over the method name.
     */
    
    private E value; 
    private BSTNodeImpl<E> left, right; 

    /**
     * ! Do not delete this constructor !
     * Please implement your logic inside this constructor without modifying the signature
     * of this method, or else your code won't compile.
     *
     * @param v element to put into the tree
     * @throws IllegalArgumentException if v is null
     */
    public BSTNodeImpl(E v) {
        if (v == null) {
            throw new IllegalArgumentException(); 
        }
        value = v; 
    }

    @Override
    public boolean add(E element) {
        
        if (element.compareTo(value) == 0) {
            return false; 
        } else if (element.compareTo(value) < 0) {
            if (left == null) {
                left = new BSTNodeImpl<E>(element); 
                return true; 
            } else {
                return left.add(element); 
            }
        } else {
            if (right == null) {
                right = new BSTNodeImpl<E>(element); 
                return true; 
            } else {
                return right.add(element); 
            }
        }
    }

    @Override
    public boolean contains(E element) {
        if (element.compareTo(value) == 0) {
            return true; 
        } else if (element.compareTo(value) < 0) {
            if (left == null) {
                return false; 
            } else {
                return left.contains(element); 
            }
        } else {
            if (right == null) {
                return false; 
            } else {
                return right.contains(element); 
            }
        }
    }

    @Override
    public int size() {
        if (left != null && right != null) {
            return 1 + left.size() + right.size(); 
        } else if (left != null && right == null) {
            return 1 + left.size(); 
        } else if (left == null && right != null) {
            return 1 + right.size(); 
        } else {
            return 1; 
        }
    }

    @Override
    public BSTNode<E> getLeftChild() {
        return left; 
    }

    @Override
    public BSTNode<E> getRightChild() {
        return right; 
    }

    @Override
    public E getValue() {
        return value; 
    }

    @Override
    public Iterator<E> getPreOrderTraversal() {
        class BSTIterator implements Iterator<E> {
            
            private BSTNodeImpl<E> currNode; 
            
            ArrayList<BSTNodeImpl<E>> twoChild = new ArrayList<BSTNodeImpl<E>>(); 
            
            public BSTIterator(BSTNodeImpl<E> bst) {  
                currNode = bst; 
            }
            @Override
            public boolean hasNext() {
                if (currNode.left == null && currNode.right == null) {
                    return !(twoChild.size() == 0);
                } else {
                    return true; 
                }
            }
            
            @Override
            public E next() {
                if (hasNext()) {
                    E currVal = currNode.value; 
                    // if two children 
                    if (currNode.left != null && currNode.right != null) {
                        twoChild.add(currNode); 
                        currNode = currNode.left;
                        return currVal; 
                    // if one left child     
                    } else if (currNode.left != null) {
                        currNode = currNode.left; 
                        return currVal; 
                    // if one right child
                    } else if (currNode.right != null) {
                        currNode = currNode.right; 
                        return currVal; 
                    // if no child then go back to most recently added two child and go to its right
                    } else {
                        int lastIndex = twoChild.size() - 1; 
                        BSTNodeImpl<E> twoChildRecent = twoChild.get(lastIndex); 
                        twoChild.remove(lastIndex); 
                        currNode = twoChildRecent.right; 
                        return currVal; 
                    }
                } else {
                    throw new NoSuchElementException(); 
                }
            }
        }
        BSTIterator iter = new BSTIterator(this); 
        return iter; 
    }

    @Override
    public boolean isValidBST() {
        BSTNodeImpl<E> tempTree = new BSTNodeImpl<E>(value);
        return isBSTUnique(tempTree) && isBSTOrdered(); 
    }
    
    /**
     * helper function for isValidBST() to check if the order is properly maintained
     * function is broken down into cases to check for null
     * 
     * errors would arise if the right child of the root's left is greater than the root value
     * or if the left child of the root's right is less than the root value
     *
     * @return true if all elements in BST is maintained in a valid order, false otherwise
     */
    boolean isBSTOrdered() {
     // if no children
        if (left == null && right == null) {
            return true; 
        // if one right child
        } else if (left == null) {
            if (right.getLeftChild() == null) {
                return true; 
            }
            return right.getLeftChild().getValue().compareTo(value) > 0 && right.isBSTOrdered(); 
        // if one left child
        } else if (right == null) {
            if (left.getRightChild() == null) {
                return true; 
            }
            return left.getRightChild().getValue().compareTo(value) < 0 && left.isBSTOrdered(); 
        // if two children
        } else {
            if (left.getRightChild() == null && right.getLeftChild() == null) {
                return true; 
            } else if (left.getRightChild() == null) {
                return right.getLeftChild().getValue().compareTo(value) > 0 && 
                        right.isBSTOrdered() && left.isBSTOrdered(); 
            } else if (right.getLeftChild() == null) {
                return left.getRightChild().getValue().compareTo(value) < 0 && 
                        left.isBSTOrdered() && right.isBSTOrdered(); 
            } else {
                return right.getLeftChild().getValue().compareTo(value) > 0 && 
                    left.getRightChild().getValue().compareTo(value) < 0 && 
                    right.isBSTOrdered() && left.isBSTOrdered(); 
            }
        }
    }
    
    /**
     * helper function for isValidBST() to check that there are no duplicates
     * uses add() function to check if there are duplicates
     *
     * @return true if all elements in BST is maintained in a valid order, false otherwise
     */
    boolean isBSTUnique(BSTNodeImpl<E> tempTree) {
        // if no child
        if (left == null && right == null) {
            return true; 
        // if right child
        } else if (left == null) {
            return tempTree.add(right.getValue()) && right.isBSTUnique(tempTree);
        // if left child
        } else if (right == null) {
            return tempTree.add(left.getValue()) && left.isBSTUnique(tempTree);
        // if two children
        } else {
            return tempTree.add(left.getValue()) && tempTree.add(right.getValue()) && 
                    left.isBSTUnique(tempTree) && right.isBSTUnique(tempTree); 
        }
    }

    @Override
    public boolean isStructurallyIdentical(BSTNode<E> other) {
        // to ensure that if recursively called and other's children are null 
        // while this's children are not, they are not identical
        if (other == null) {
            return false; 
        }
        // if values are the same
        if (value == other.getValue()) {
            // no children
            if (left == null && right == null) {
                return other.getLeftChild() == null && other.getRightChild() == null;
            // right child
            } else if (left == null) {
                if (other.getLeftChild() == null) {
                    return right.isStructurallyIdentical(other.getRightChild());
                } else {
                    return false; 
                }
            // left child 
            } else if (right == null) {
                if (other.getRightChild() == null) {
                    return left.isStructurallyIdentical(other.getLeftChild()); 
                } else {
                    return false; 
                }
            // both children
            } else {
                return right.isStructurallyIdentical(other.getRightChild()) &&
                        left.isStructurallyIdentical(other.getLeftChild()); 
            }
        // if values are not the same 
        } else {
            return false; 
        }
    }
}
