
import java.awt.Graphics;

public class TestObj extends GameObj{
	public static final int WIDTH = 10; 
	public static final int HEIGHT = 10;
	public static final int INIT_VEL_X = 0;
	public static final int INIT_VEL_Y = 0;
	public static final int INIT_ROT = 0; 
	
	
	public TestObj(int courtWidth, int courtHeight, int px, int py) {
		
		super(INIT_VEL_X, INIT_VEL_Y, px, py, WIDTH, HEIGHT, courtWidth, 
				courtHeight, INIT_ROT);
	}
	
	public void draw(Graphics g) {
		
	}
	
	public void shoot(int x, int y, int z) {
	}
}
