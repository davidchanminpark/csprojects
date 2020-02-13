import java.awt.*;

public class Points extends GameObj{
	
	public static final int SIZE = 10; 
	public static final int INIT_VEL_X = 0;
	public static final int INIT_VEL_Y = 0;
	public static final int INIT_ROT = 0;
	public static final int INIT_POS_X = 0;
	public static final int INIT_POS_Y = 0;

	
	private Color color; 
	
	public Points(int courtWidth, int courtHeight, int rowIndex, int colIndex, Color color) {
		super(INIT_VEL_X, INIT_VEL_Y, INIT_POS_X, INIT_POS_Y, SIZE, SIZE, courtWidth, 
				courtHeight, INIT_ROT);
		
		setPx((int) (courtWidth / 8) * rowIndex + 20);
		setPy((int) (courtHeight / 8) * colIndex + 20);
		
		// set position in the center of the tank 
		setPx((int) getPx() + SIZE / 2);
		setPy((int) getPy() + SIZE / 2);
		this.color = color; 
	}
	
	@Override
	public void draw(Graphics g) {
		g.setColor(this.color);
		g.fillRect((int) this.getPx() - SIZE / 2, (int) this.getPy() - SIZE / 2, 
				this.getWidth(), this.getHeight());
	}
	
	//@Override
	//public void shoot(int x, int y, int z) {
		// will not call this method
	}
	


