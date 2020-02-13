import java.util.HashMap;
import java.util.Map;

/**
 * Implements construction, encoding, and decoding logic of the Huffman coding algorithm. Characters
 * not in the given seed or alphabet should not be compressible, and attempts to use those
 * characters should result in the throwing of an {@link IllegalArgumentException} if used in {@link
 * #compress(String)}.
 *
 */
public class Huffman {
    
    class Node implements Comparable<Node> { 
        private int freq; 
        private String str; 
        private Node leftChild, rightChild; 
        private int numOrder; 
        
        public Node(int freq, String str, int numOrder) {
            this.freq = freq; 
            this.str = str; 
            this.numOrder = numOrder; 
        }
        
        public Node(int freq, Character chr, int numOrder) {
            this.freq = freq; 
            this.str = Character.toString(chr); 
            this.numOrder = numOrder; 
        }
        
        public int getFreq() {
            return freq; 
        }
        
        public String getString() {
            return str; 
        }
        
        public char getFirstChar() { 
            return str.charAt(0); 
        }
        
        public int getNumOrder() {
            return numOrder; 
        }
        
        public int getStrLength() {
            return str.length(); 
        }
        
        public Node getLeftChild() {
            return leftChild; 
        }
        
        public Node getRightChild() {
            return rightChild; 
        }
        
        public void setLeftChild(Node n) {
            leftChild = n; 
        }
        
        public void setRightChild(Node n) {
            rightChild = n; 
        }

        @Override
        public int compareTo(Node n) {
            if (freq == n.getFreq()) {
                if (str.length() == 1 && n.getStrLength() == 1) {
                    if (str.charAt(0) < n.getFirstChar()) {
                        return -1; 
                    } else {
                        return 1; 
                    }
                } else {
                    if (numOrder < n.getNumOrder()) {
                        return -1; 
                    } else {
                        return 1; 
                    }
                }
            } else if (freq < n.getFreq()) {
                return -1; 
            } else {
                return 1; 
            }
        }
    }
    
    // private fields for instance of Huffmannnnn
    private MinPQ<Node> huffie; 
    private int order; 
    private Map<Character, String> encodedChars;
    private Map<String, Character> encodedCharsRev; 
    private int inputBits; 
    private int outputBits;
    
    public int getOrder() {
        return order; 
    }
    
    public Map<Character,String> getEncoded() {
        return encodedChars; 
    }
    
    /**
     * Constructs a {@code Huffman} instance from a seed string, from which to deduce the alphabet
     * and corresponding frequencies.
     * <p/>
     * Do NOT modify this constructor header.
     *
     * @param seed the String from which to build the encoding
     * @throws IllegalArgumentException seed is null, seed is empty, or resulting alphabet only has
     * 1 character 
     */ 
    public Huffman(String seed) { 
        if (seed == null || seed.length() == 0) { 
            throw new IllegalArgumentException(); 
        } else if (checkSameChar(seed)) {
            throw new IllegalArgumentException(); 
        }
        Map<Character, Integer> leafStorage = new HashMap<Character, Integer>(); 
        
        for (int i = 0; i < seed.length(); i++) {
            char curr = seed.charAt(i); 
            if (leafStorage.containsKey(curr)) {
                int currFreq = leafStorage.get(curr); 
                leafStorage.put(curr, ++currFreq); 
            } else {
                leafStorage.put(curr, 1); 
            }
        }
        
        huffie = new MinPQ<Node>();
        
        leafStorage.forEach((k, v) -> huffie.add(new Node(v, k, order++)));
        
        makeHuffTree(huffie); 
        
        encodedChars = makeEncodingMap(huffie);
        
        encodedCharsRev = reverseEncoding(encodedChars); 

    }
    
    boolean checkSameChar(String seed) {
        char firstChar = seed.charAt(0); 
        for (int i = 1; i < seed.length(); i++) {
            if (firstChar != seed.charAt(i)) {
                return false; 
            }
        }
        return true; 
    }
    
    /**
     * Constructs a {@code Huffman} instance from a frequency map of the input alphabet.
     * <p/>
     * Do NOT modify this constructor header.
     *
     * @param alphabet a frequency map for characters in the alphabet
     * @throws IllegalArgumentException if the alphabet is null, empty, has fewer than 2 characters,
     * or has any non-positive frequencies
     */
    public Huffman(Map<Character, Integer> alphabet) {
        if (alphabet == null || alphabet.size() < 2) {
            throw new IllegalArgumentException(); 
        }
        
        if (checkNegFreq(alphabet)) {
            throw new IllegalArgumentException(); 
        }
        
        huffie = new MinPQ<Node>();

        alphabet.forEach((k, v) -> huffie.add(new Node(v, k, order++)));
        
        makeHuffTree(huffie); 
        
        encodedChars = makeEncodingMap(huffie);
        
        encodedCharsRev = reverseEncoding(encodedChars); 
    }
    
    boolean checkNegFreq(Map<Character, Integer> alphbi) {
        for (Integer i : alphbi.values()) {
            if (i <= 0) {
                return true; 
            }
        }
        return false; 
    }
    
    void makeHuffTree(MinPQ<Node> huffie) {
        if (huffie.size() == 1) {
            return; 
        }
        
        Node min = huffie.extractMin(); 
        Node secondMin = huffie.extractMin(); 
        
        int newFreq = min.getFreq() + secondMin.getFreq(); 
        String newStr = min.getString() + secondMin.getString(); 
        Node newNode = new Node(newFreq, newStr, order++); 
        
        newNode.setLeftChild(min);
        newNode.setRightChild(secondMin);
        
        huffie.add(newNode);
        
        makeHuffTree(huffie);
        
    }
    
    Map<Character, String> makeEncodingMap(MinPQ<Node> huffie) {
        Map<Character, String> encodedMap = new HashMap<Character, String>(); 
        Node root = huffie.peek(); 
        findLeaf(root, encodedMap, ""); 
        return encodedMap; 
    }
    
    void findLeaf(Node root, Map<Character, String> map, String path) {
        if (root.getLeftChild() == null && root.getRightChild() == null &&
                root.getStrLength() == 1) {
            map.put(root.getFirstChar(), path); 
        } else {
            findLeaf(root.getLeftChild(), map, path + "0"); 
            findLeaf(root.getRightChild(), map, path + "1"); 
        }
    }
    
    Map<String, Character> reverseEncoding(Map<Character, String> orig) {
        Map<String, Character> reversedMap = new HashMap<String, Character>(); 
        for (Map.Entry<Character,String> entry : orig.entrySet()) {
            reversedMap.put(entry.getValue(), entry.getKey()); 
        }
        return reversedMap; 
    }
    
    /**
     * Compresses the input string.
     *
     * @param input the string to compress, can be the empty string
     * @return a string of ones and zeroes, representing the binary encoding of the inputted String.
     * @throws IllegalArgumentException if the input is null or if the input contains characters
     * that are not compressible
     */
    public String compress(String input) {
        if (input == null) {
            throw new IllegalArgumentException(); 
        }
        
        if (input.length() == 0) {
            return ""; 
        }
        
        StringBuilder binaryStr = new StringBuilder(); 
        
        for (int i = 0; i < input.length(); i++) {
            char currChar = input.charAt(i); 
            if (encodedChars.containsKey(currChar)) {
                String encoded = encodedChars.get(currChar); 
                binaryStr.append(encoded); 
            } else {
                throw new IllegalArgumentException(); 
            }
        }
        inputBits += input.length() * 16; 
        outputBits += binaryStr.length(); 
        
        return binaryStr.toString(); 
    }


    /**
     * Decompresses the input string.
     *
     * @param input the String of binary digits to decompress, given that it was generated by a
     * matching instance of the same compression strategy
     * @return the decoded version of the compressed input string
     * @throws IllegalArgumentException if the input is null, or if the input contains characters
     * that are NOT 0 or 1, or input contains a sequence of bits that is not decodable
     */
    public String decompress(String input) {
        if (input == null) {
            throw new IllegalArgumentException(); 
        } 
        
        StringBuilder decodedStr = new StringBuilder();
        
        StringBuilder currBinary = new StringBuilder(); 
        
        int maxLengthPath = encodedChars.size() - 1; 
        
        for (int i = 0; i < input.length(); i++) {
            char currChar = input.charAt(i); 
            
            if (currChar != '1' && currChar != '0') {
                throw new IllegalArgumentException(); 
            }
            currBinary.append(currChar); 
            
            if (currBinary.length() > maxLengthPath) {
                throw new IllegalArgumentException(); 
            }
            
            String curr = currBinary.toString(); 
            Character result = encodedCharsRev.get(curr); 
            
            if (result != null) {
                decodedStr.append(result); 
                currBinary = new StringBuilder(); 
            }
        }
        
        return decodedStr.toString(); 
    }

  /**
     * Computes the compression ratio so far. This is the length of all output strings from {@link
     * #compress(String)} divided by the length of all input strings to {@link #compress(String)}.
     * Assume that each char in the input string is a 16 bit int.
     *
     * @return the ratio of the total output length to the total input length in bits
     * @throws IllegalStateException if no calls have been made to {@link #compress(String)} before
     * calling this method
     */
    public double compressionRatio() {
        double output = outputBits; 
        double input = inputBits; 
        
        if (output == 0) {
            throw new IllegalStateException(); 
        }
        
        return output / input; 
    }

    /**
     * Computes the expected encoding length of an arbitrary character in the alphabet based on the
     * objective function of the compression.
     * 
     * The expected encoding length is simply the sum of the length of the encoding of each 
     * character multiplied by the probability that character occurs. 
     *
     * @return the expected encoding length of an arbitrary character in the alphabet
     */
    public double expectedEncodingLength() {
        double totalFreq = huffie.peek().getFreq(); 
        
        String allChars = huffie.peek().getString(); 
        
        int numChars = allChars.length(); 
        
        double sum = 0; 
        
        for (int i = 0; i < numChars; i++) {
            char currChar = allChars.charAt(i); 
            double currFreq = findFreq(currChar, huffie.peek()); 
            double prob = currFreq / totalFreq; 
            double encodedLength = encodedChars.get(currChar).length(); 
            sum += encodedLength * prob; 
        }
        
        return sum; 
    }
    
    int findFreq(char c, Node n) {
        if (n.getStrLength() == 1 && n.getFirstChar() == c) {
            return n.getFreq(); 
        } else if (n.getLeftChild().getString().indexOf(c) >= 0) {
            return findFreq(c, n.getLeftChild()); 
        } else {
            return findFreq(c, n.getRightChild()); 
        }
    }
}
