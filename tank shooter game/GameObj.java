
import java.awt.Graphics; 

public abstract class GameObj {
	
	private double px; 
	private double py;
	
	private double vx; 
	private double vy; 
	
	private int width;
    private int height;
	
	private int maxX; 
	private int maxY;
	
	// in degrees
	private int rotation; 
	
	// moving object constructor - tanks, bullets
	public GameObj(int vx, int vy, double px, double py, int width, int height, int courtWidth,
	        int courtHeight, int rotation) {
	        this.vx = vx;
	        this.vy = vy;
	        this.px = px;
	        this.py = py;
	        this.width  = width;
	        this.height = height;

	        // take the width and height into account when setting the bounds for the upper left corner
	        // of the object.
	        this.maxX = courtWidth - width / 2;
	        this.maxY = courtHeight - height / 2;
	        
	        this.rotation = rotation; 
	    }
	
	// non-moving object constructor - walls, power-ups
	public GameObj(int px, int py, int width, int height) {
		//this.vx = 0; 
		//this.vy = 0; 
		this.px = px; 
		this.py = py; 
		this.width = width; 
		this.height = height;
		
		// these variables are not used as these objects never move
		this.maxX = 0; 
		this.maxY = 0;
		this.rotation = 0; 
	}

	public double getPx() {
        return this.px;
    }

    public double getPy() {
        return this.py;
    }
    
    public double getVx() {
        return this.vx;
    }
    
    public double getVy() {
        return this.vy;
    }
    
    public int getWidth() {
        return this.width;
    }
    
    public int getHeight() {
        return this.height;
    }
    
    public int getRotation() {
    	return this.rotation; 
    }
   
    public void setPx(int px) {
        this.px = px;
        clip();
    }

    public void setPy(int py) {
        this.py = py;
        clip();
    }

    public void setVx(double vx) {
        this.vx = vx;
    }

    public void setVy(double vy) {
        this.vy = vy;
    }
    
    public void setRotation(int r) {
    	this.rotation = r; 
    }
    
    public void setWidth(int w) {
        this.width = w;
    }
    
    public void setHeight(int h) {
        this.height = h;
    }
    
    /**
     * Prevents the object from going outside of the bounds of the area designated for the object.
     * (i.e. Object cannot go outside of the active area the user defines for it).
     */ 
    private void clip() {
        this.px = Math.min(Math.max(this.px, 0), this.maxX);
        this.py = Math.min(Math.max(this.py, 0), this.maxY);
    }
    
    public void move() {
    	this.px += this.vx; 
    	this.py += this.vy; 
    	
    	clip(); 
    }
    
    /**
     * Determine whether this game object is currently intersecting another object.
     * 
     * Intersection is determined by comparing bounding boxes. If the bounding boxes overlap, then
     * an intersection is considered to occur.
     * 
     * @param that The other object
     * @return Whether this object intersects the other object.
     */
    public boolean intersects(GameObj that) {
        return (this.px + this.width / 2 >= that.px - that.width / 2
            && this.py + this.height / 2 >= that.py - that.height / 2
            && that.px + that.width / 2 >= this.px - this.width / 2
            && that.py + that.height >= this.py - this.height);
    }


    public abstract void draw(Graphics g);
    
    //public abstract void shoot(int bulletV, int courtWeight, int courtHeight);
    
}
