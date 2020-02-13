import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * 
 * @author davidpark
 *
 * @param <E>
 */
public class ResizingDequeImpl<E> implements ResizingDeque<E> {
    
    private int size;
    private int head; 
    private int tail; 
    private E[] array; 
    
    int getHead() {
        return head; 
    }
    
    int getTail() {
        return tail; 
    }
    
    class Iter implements Iterator<E> {
        
        int pointer; 
        int count; 
        
        public Iter() {
            pointer = head;   
            count = 0; 
        }

        @Override
        public boolean hasNext() {
            return count < size; 
        }

        @Override
        public E next() {
            E temp; 
            if (!hasNext()) {
                throw new NoSuchElementException(); 
            }
            if (pointer == array.length - 1) {
                pointer = 0; 
            }
            temp = array[pointer++]; 
            count++; 
            return temp; 
        }
    }
    
    @SuppressWarnings("unchecked")
    public ResizingDequeImpl() {
        size = 0; 
        array = (E[]) new Object[2]; 
        head = 0; 
        tail = 0; 
    }

    @Override
    public int size() {
        return size; 
    }

    @Override
    public E[] getArray() {
        return array; 
    }

    @Override
    public void addFirst(E e) {
        
        if (size == 0) {
            array[0] = e; 
            size++; 
            return; 
        }
        
        if (size == array.length) {
            resizeUp(); 
        }
        
        // wrap around to end
        if (head == 0) {
            array[array.length - 1] = e; 
            head = array.length - 1; 
        } else { 
            array[--head] = e; 
        } 
        size++; 
    }

    @Override
    public void addLast(E e) {
        
        if (size == 0) {
            array[0] = e; 
            size++; 
            return; 
        }
        
        if (size == array.length) {
            resizeUp(); 
        }
        
        // wrap around to front
        if (tail == array.length - 1) {
            array[0] = e; 
            tail = 0; 
        } else {
            array[++tail] = e; 
        }
        size++; 
    }
    
    @SuppressWarnings("unchecked")
    void resizeUp() {
        int tempSize = size; 
        int currIndex = 0; 
        int tempHead = head; 
        E[] newArray = (E[]) new Object[array.length * 2];  
        while (tempSize > 0) {
            if (tempHead == array.length) {
                tempHead = 0; 
            }
            newArray[currIndex++] = array[tempHead++]; 
            tempSize--; 
        }
        array = newArray; 
        head = 0; 
        tail = size - 1; 
    }

    @Override
    public E pollFirst() {
        if (size == 0) {
            throw new NoSuchElementException(); 
        }
        
        if (size - 1 < array.length / 4 && array.length != 2) {
            resizeDown(); 
        }
        
        E firstE = array[head]; 
        array[head] = null; 
        
        // update head
        if (head == tail) {
            head = 0; 
            tail = 0; 
        } else if (head == array.length - 1) {
            head = 0; 
        } else {
            head++;  
        }
        size--; 
        return firstE; 
    } 

    @Override 
    public E pollLast() { 
        if (size == 0) { 
            throw new NoSuchElementException(); 
        }
        
        if (size - 1 < array.length / 4 && array.length != 2) {
            resizeDown(); 
        }
        
        E lastE = array[tail]; 
        array[tail] = null; 
        
        // update tail
        if (head == tail) {
            head = 0; 
            tail = 0; 
        } else if (tail == 0) {
            tail = array.length - 1;
        } else {
            tail--;
        }
        size--; 
        return lastE; 
    }
    
    @SuppressWarnings("unchecked")
    void resizeDown() {
        int tempSize = size; 
        int currIndex = 0; 
        int tempHead = head; 
        E[] newArray = (E[]) new Object[array.length / 2];  
        while (tempSize > 0) {
            if (tempHead == array.length) {
                tempHead = 0; 
            }
            newArray[currIndex++] = array[tempHead++]; 
            tempSize--; 
        }
        array = newArray; 
        head = 0; 
        tail = size - 1; 
    }

    @Override
    public E peekFirst() {
        if (size == 0) {
            throw new NoSuchElementException(); 
        }
        
        return array[head]; 
    }

    @Override
    public E peekLast() {
        if (size == 0) {
            throw new NoSuchElementException(); 
        }
        
        return array[tail]; 
    }
    
    @Override
    public Iterator<E> iterator() {
        return new Iter(); 
    }
    
}