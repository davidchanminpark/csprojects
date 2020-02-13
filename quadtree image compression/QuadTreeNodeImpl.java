// CIS 121, HW4 QuadTree

public class QuadTreeNodeImpl implements QuadTreeNode {
    
    private Integer color; 
    private QuadTreeNodeImpl topLeft, topRight, bottomLeft, bottomRight; 
    private int size; 
    
    // default: root
    public QuadTreeNodeImpl(int size) {
        this.color = null; 
        this.size = size; 
    }
    
    // leaf 
    public QuadTreeNodeImpl(int size, int col) {
        this.color = col; 
        this.size = size; 
    }

    /**
     * ! Do not delete this method !
     * Please implement your logic inside this method without modifying the signature
     * of this method, or else your code won't compile.
     * <p/>
     * Be careful that if you were to create another method, make sure it is not public.
     *
     * @param image image to put into the tree
     * @return the newly build QuadTreeNode instance which stores the compressed image
     * @throws IllegalArgumentException if image is null
     * @throws IllegalArgumentException if image is empty
     * @throws IllegalArgumentException if image.length is not a power of 2
     * @throws IllegalArgumentException if image, the 2d-array, is not a perfect square
     */
    public static QuadTreeNode buildFromIntArray(int[][] image) {
        if (image == null) {
            throw new IllegalArgumentException(); 
        }
        if (image.length == 0 || image[0].length == 0) {
            throw new IllegalArgumentException(); 
        }
        if (!checkPowerTwo(image.length)) {
            throw new IllegalArgumentException(); 
        }
        if (image.length != image[0].length) {
            throw new IllegalArgumentException(); 
        }
        if (image.length == 1) {
            QuadTreeNodeImpl node =  new QuadTreeNodeImpl(1); 
            node.color = image[0][0]; 
            return node; 
        }
        
        return buildHelper(image, 0, 0, image.length - 1, image.length - 1); 
        
    }
    
    static QuadTreeNodeImpl buildHelper(int[][] image, int startY, int startX, int endY, int endX) {
        
        QuadTreeNodeImpl root = new QuadTreeNodeImpl(endX - startX + 1);
        
        int mid = (endX - startX) / 2;
     
        // if it's a 2 x 2 (base case) 
        if (mid == 0) {
            root.topLeft = new QuadTreeNodeImpl(1); 
            root.topRight = new QuadTreeNodeImpl(1); 
            root.bottomLeft = new QuadTreeNodeImpl(1); 
            root.bottomRight = new QuadTreeNodeImpl(1); 
            
            root.topLeft.color = image[startY][startX]; 
            root.topRight.color = image[startY][endX]; 
            root.bottomLeft.color = image[endY][startX]; 
            root.bottomRight.color = image[endY][endX]; 
        } else {
            root.topLeft = buildHelper(image, startY, startX, startY + mid, startX + mid); 
            root.topRight = buildHelper(image, startY, startX + mid + 1, startY + mid, endX); 
            root.bottomLeft = buildHelper(image, startY + mid + 1, startX, endY, startX + mid); 
            root.bottomRight = buildHelper(image, startY + mid + 1, startX + mid + 1, endY, endX);
        }
        
        // if all four subnodes are the same then get rid of them, and make their root a leaf
        checkMerge(root); 
        return root; 
    }
    
    static void checkMerge(QuadTreeNodeImpl root) {
        if (root.topLeft.color != null && root.topLeft.color.equals(root.topRight.color) && 
                root.topRight.color.equals(root.bottomLeft.color) &&
                root.bottomLeft.color.equals(root.bottomRight.color)) {
            root.color = root.topLeft.color; 
            root.topLeft = null; 
            root.topRight = null; 
            root.bottomLeft = null;
            root.bottomRight = null;
        }
    }
    
    static boolean checkPowerTwo(double imageLength) {
        if (imageLength < 1) {
            return false; 
        } else if (imageLength == 1) {
            return true; 
        } else {
            return checkPowerTwo(imageLength / 2); 
        }
    }

    @Override
    public int getColor(int x, int y) {
        if (x < 0 || x >= size) {
            throw new IllegalArgumentException(); 
        }
        if (y < 0 || y >= size) {
            throw new IllegalArgumentException(); 
        }
        int mid = size / 2; 
        if (color != null) {
            return color; 
        } else {
            if (x < mid && y < mid) {
                return topLeft.getColor(x, y); 
            } else if (x < mid && y >= mid) {
                return bottomLeft.getColor(x, y - mid);
            } else if (x >= mid && y < mid) {
                return topRight.getColor(x - mid, y); 
            } else {
                return bottomRight.getColor(x - mid, y - mid); 
            }
        }
    }

    @Override
    public void setColor(int x, int y, int c) {
        if (x < 0 || x >= size) {
            throw new IllegalArgumentException(); 
        }
        if (y < 0 || y >= size) {
            throw new IllegalArgumentException(); 
        }
        int mid = size / 2;
        
        // if setColor is not unique - null pointer tho
        if (color != null && color.equals(c)) {
            return; 
        }
        

        // edge case - single length 
        if (size == 1) {
            color = c; 
        // 2 by 2 and already broken up
        } else if (size == 2 && color == null) {
            if (x < mid && y < mid) {
                topLeft.color = c; 
            } else if (x < mid && y >= mid) {
                bottomLeft.color = c;
            } else if (x >= mid && y < mid) {
                topRight.color = c;  
            } else {
                bottomRight.color = c; 
            }
            checkMerge(this); 
        // 2 by 2 and not broken up - no need to check for possible merges
        } else if (size == 2 && color != null) {
            breakUp(this); 
            if (x < mid && y < mid) {
                topLeft.color = c; 
            } else if (x < mid && y >= mid) {
                bottomLeft.color = c;
            } else if (x >= mid && y < mid) {
                topRight.color = c;  
            } else {
                bottomRight.color = c; 
            }
         // already broken into 4 quadnodes
        } else if (color == null) {
            if (x < mid && y < mid) {
                topLeft.setColor(x, y, c); 
            } else if (x < mid && y >= mid) {
                bottomLeft.setColor(x, y - mid, c);
            } else if (x >= mid && y < mid) {
                topRight.setColor(x - mid, y, c); 
            } else {
                bottomRight.setColor(x - mid, y - mid, c); 
            }
            checkMerge(this); 
        // not broken into 4 quadnodes 
        } else { 
            if (x < mid && y < mid) { 
                breakUp(this); 
                topLeft.setColor(x, y, c); 
            } else if (x < mid && y >= mid) {
                breakUp(this); 
                bottomLeft.setColor(x, y - mid, c);
            } else if (x >= mid && y < mid) {
                breakUp(this); 
                topRight.setColor(x - mid, y, c); 
            } else {
                breakUp(this); 
                bottomRight.setColor(x - mid, y - mid, c); 
            }
        }
    }
    
    static void breakUp(QuadTreeNodeImpl root) {
        root.topRight = new QuadTreeNodeImpl(root.size / 2, root.color);
        root.topLeft = new QuadTreeNodeImpl(root.size / 2, root.color);
        root.bottomRight = new QuadTreeNodeImpl(root.size / 2, root.color);
        root.bottomLeft = new QuadTreeNodeImpl(root.size / 2, root.color);
        
        root.color = null; 
    }

    @Override
    public QuadTreeNode getQuadrant(QuadName quadrant) {
        switch (quadrant) {
            case TOP_LEFT: 
                return topLeft; 
            case TOP_RIGHT: 
                return topRight;
            case BOTTOM_LEFT: 
                return bottomLeft;
            case BOTTOM_RIGHT: 
                return bottomRight;
            default: return null; 
        }
    }

    @Override
    public int getDimension() {
        return size; 
    }

    @Override
    public int getSize() {
        if (color != null) {
            return 1; 
        } else {
            return 1 + topLeft.getSize() + topRight.getSize() + 
                    bottomLeft.getSize() + bottomRight.getSize(); 
        }
    }

    @Override
    public boolean isLeaf() {
        return color != null; 
    }

    @Override
    public int[][] decompress() {
        int[][] image = new int[size][size]; 
        for (int i = 0; i < image.length; i++) {
            for (int j = 0; j < image.length; j++) {
                image[i][j] = this.getColor(j, i);
            }
        }
        return image; 
    }

    @Override
    public double getCompressionRatio() {
        double nodes = this.getSize(); 
        double pixels = this.getDimension() * this.getDimension(); 
        return nodes / pixels; 
    }
}
