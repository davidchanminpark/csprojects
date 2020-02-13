import java.awt.*; 

public class Bullet extends GameObj {
	public static final int SIZE = 10; 
	public static final double VEL = 0.1; 
 
	
	private Color color; 
	
	public Bullet(int courtWidth, int courtHeight, double initPosX, double initPosY, Color color, 
			int rotation) {
		super(0, 0, initPosX, initPosY, SIZE, SIZE, courtWidth, courtHeight, 
				rotation);
		this.setVx(VEL * Math.cos(Math.toRadians(rotation)));
		System.out.println(VEL * Math.cos(Math.toRadians(rotation)));
		this.setVy(VEL * Math.sin(Math.toRadians(rotation)));
		this.color = color;
	}
	
	@Override
	public void draw(Graphics g) {
		g.setColor(this.color);
		g.fillOval((int) this.getPx(), (int) this.getPy(), this.getWidth(), this.getHeight());
	}

	//public void shoot(int x, int y, int z) {
	//}
}
