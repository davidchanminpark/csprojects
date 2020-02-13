import java.util.Iterator;

/**
 * BSTNode is an interface for your implementation of a Binary Search Tree. A BST is represented by
 * a single BSTNode as the root of the tree. An empty BST is a null-valued object, and a BSTNode
 * must contain a non-null value. Therefore, when constructing the tree, we will always give you a
 * non-null element to act on.
 * <p>
 * Our Binary Search Tree invariant includes:
 * 1. no duplicate values in the tree,
 * 2. all values on the left sub-tree is strictly less than the value at the root,
 * 3. all values on the right sub-tree is strictly larger than the value at the root, and
 * 4. the invariant holds true for all sub-trees.
 *
 * @param <E> the type of elements put into this BST
 * @author hanbangw, 19fa
 */
public interface BSTNode<E extends Comparable<E>> {
    /**
     * Adds the specified element to this tree if it is not already present. If this tree already
     * contains the value, the call leaves the tree unchanged and returns false. This ensures that
     * the tree never contains duplicate values.
     *
     * For efficiency, you should *not* call contains() in this method.
     *
     * @param element the element to be added to this set
     * @return true if this tree did not already contain the specified element
     * @throws IllegalArgumentException if the specified element is null
     */
    boolean add(E element);

    /**
     * Returns true if this tree contains the specified value. More formally, returns true if and
     * only if this tree contains an element e such that {@code e.compareTo(element) == 0}.
     *
     * @param element whose presence in this tree is to be tested
     * @return true, if this set contains the specified value
     * @throws IllegalArgumentException if the specified element is null
     */
    boolean contains(E element);

    /**
     * Returns the number of elements in this tree. The tree is empty if and only if the size is 0.
     *
     * @return the number of elements in this tree
     */
    int size();

    /**
     * Get the left child of this node. If the left child doesn't exist, return null. Changes made
     * to the returned node should reflect on this tree.
     *
     * @return the left child of this node
     */
    BSTNode<E> getLeftChild();

    /**
     * Get the right child of this node. If the right child doesn't exist, return null. Changes made
     * to the returned node should reflect on this tree.
     *
     * @return the right child of this node
     */
    BSTNode<E> getRightChild();

    /**
     * Get the value of the current node.
     *
     * @return the value of the current node
     */
    E getValue();

    /**
     * Returns an iterator over the elements in this tree. The values are returned in the order of
     * pre-order traversal of the tree. Pre-order traversal access the root first, then traverse the
     * left sub-tree of the root, and then traverse its right sub-tree. The iterator needs to be a
     * lazy-iterator, which means you should access elements in the tree one at a time.
     *
     * See the write-up for additional instructions.
     *
     * @return an iterator over the values in this set
     */
    Iterator<E> getPreOrderTraversal();

    /**
     * This method compares the current tree with another BST, and judges whether they are
     * structurally the same. More formally, two BSTs are structurally identical if both trees are
     * empty, or all of the following conditions hold: 
     * 1. both trees are not empty,
     * 2. their roots hold the same value,
     * 3. their left sub-trees are structurally identical, and
     * 4. their right sub-trees are structurally identical.
     *
     * @param other the other BST to compare with
     * @return true, if the other tree is structurally identical with this tree.
     */
    boolean isStructurallyIdentical(BSTNode<E> other);

    /**
     * This method detects if the tree still holds BST invariants. For example, the user may call
     * {@code root.getLeftChild().add()} to add an element to the left sub-tree of the current root,
     * but the newly added element may violate the invariant of the whole tree.
     *
     * @return true, if the BST invariant still holds.
     */
    boolean isValidBST();
}
