import java.awt.*;


import javax.swing.*;
import java.awt.event.*;


public class BulletTank extends GameObj {
	public static final int WIDTH = 30; 
	public static final int HEIGHT = 15;
	public static final int INIT_VEL_X = 0;
	public static final int INIT_VEL_Y = 0;
	public static final int INIT_POS_X = 0;
	public static final int INIT_POS_Y = 0;
	public static final int INIT_ROT = 0; 
	
	private Color color; 
	
	public BulletTank(int courtWidth, int courtHeight, int rowIndex, int colIndex, 
			Color color) {
		
		super(INIT_VEL_X, INIT_VEL_Y, INIT_POS_X, INIT_POS_Y, WIDTH, HEIGHT, courtWidth, 
				courtHeight, INIT_ROT);
		
		setPx((int) (courtWidth / 8) * rowIndex + 20);
		setPy((int) (courtHeight / 8) * colIndex + 20);
		
		// set position in the center of the tank 
		setPx((int) getPx() + WIDTH / 2);
		setPy((int) getPy() + HEIGHT / 2);
		this.color = color;
		

	}
	
	@Override
	public void draw(Graphics g) {

		g.setColor(this.color);
		double rotRad = Math.toRadians(this.getRotation());

		double x1 = this.getPx() - WIDTH / 2;
		double x2 = x1 + WIDTH - 4; 
		double x3 = x1 + WIDTH; 
		double[] xCoords = {x1, x2, x2, x3, x3, x2, x2, x1};
		
		double y1 = (int) this.getPy() - HEIGHT / 2; 
		double y2 = y1 + 6; 
		double y3 = y1 + HEIGHT - 6;
		double y4 = y1 + HEIGHT;
		double [] yCoords = {y1, y1, y2, y2, y3, y3, y4, y4};
		
		int[] newXCoords = new int[8];
		int[] newYCoords = new int[8];
		
		double xMin = Math.min(x1, x2);
		xMin = Math.min(xMin, x3);
		double xMax = Math.max(x1, x2);
		xMax = Math.max(xMax, x3);
		setWidth((int) (xMax - xMin));
		
		double yMin = Math.min(y1, y2);
		double yMin2 = Math.min(y3, y4);
		yMin = Math.min(yMin, yMin2);
		double yMax = Math.max(y1, y2);
		double yMax2 = Math.max(y3, y4);
		yMax = Math.max(yMax, yMax2);
		setHeight((int) (yMax - yMin));

		
		for (int i = 0; i < 8; i++) {
			double newX = Math.cos(rotRad) * (xCoords[i] - getPx()) 
					- Math.sin(rotRad) * (yCoords[i] - getPy()) + getPx();
			double newY = Math.sin(rotRad) * (xCoords[i] - getPx()) 
					+ Math.cos(rotRad) * (yCoords[i] - getPy()) + getPy();
			newXCoords[i] = (int) newX; 
			newYCoords[i] = (int) newY;
		}
		
		g.fillPolygon(newXCoords, newYCoords, 8);
	}
	
	/*@Override
	public void shoot(int bulletV, int courtWidth, int courtHeight) {
		Bullet newBullet = new Bullet(courtWidth, courtHeight, 
				5 + this.getPx() + Math.cos(getRotation()) * this.getWidth() / 2 , 
				5 + this.getPy() + Math.sin(getRotation()) * this.getWidth() / 2, Color.BLACK, 
				this.getRotation());
		GameCourt.bulletsCollection.add(newBullet);
		
		int wait = 5000; 
		
		Timer delete = new Timer(wait, new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				GameCourt.bulletsCollection.remove();
			}
		});
		delete.setRepeats(false);
		delete.start();
	}*/
}
