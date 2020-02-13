import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;

import javax.swing.*;

/** 
 * 
 * @author davidpark
 *
 */
@SuppressWarnings("serial")
public class GameCourt extends JPanel {
	
	private BulletTank playerOne; 
	private BulletTank playerTwo;
	
	public boolean playing = false;
	private JLabel status;
	private JLabel showPointsOne; 
	private JLabel showPointsTwo;
	
	private int oneCounter = 0;
	private int twoCounter = 0; 
	
	//public static LinkedList<Bullet> bulletsCollection;
	//private Collection<Wall> wallsCollection;
	private Collection<Points> pointsCollection;
	
	public static final int COURT_WIDTH = 500; 
	public static final int COURT_HEIGHT = 500;
	public static final int BULLET_VELOCITY = 4;
	public static final int TANK_ROTATION_VELOCITY = 10;
	public static final int TANK_VELOCITY = 4; 
	
	public static final int INTERVAL = 50;
	
	public static final int POWERUP_INTERVAL = 50000; 
	
	public GameCourt(JLabel pointsOne, JLabel pointsTwo, JLabel status) {
        setBorder(BorderFactory.createLineBorder(Color.BLACK));
        
        Timer timer = new Timer(INTERVAL, new ActionListener() {
        	public void actionPerformed(ActionEvent e) {
        		tick();
        	}
        });
        timer.start(); 
	
        setFocusable(true);
	
        addKeyListener(new KeyAdapter() {
        	public void keyPressed(KeyEvent e) {
        		if (e.getKeyCode() == KeyEvent.VK_LEFT) {
        			playerOne.setRotation(playerOne.getRotation() - TANK_ROTATION_VELOCITY);
        		} else if (e.getKeyCode() == KeyEvent.VK_RIGHT) {
        			playerOne.setRotation(playerOne.getRotation() + TANK_ROTATION_VELOCITY);
        		} else if (e.getKeyCode() == KeyEvent.VK_DOWN) {
        			moveDown(playerOne);
        		} else if (e.getKeyCode() == KeyEvent.VK_UP) {
        			moveUp(playerOne);
        		/*} else if (e.getKeyCode() == KeyEvent.VK_ENTER) {
        			playerOne.shoot(BULLET_VELOCITY, COURT_WIDTH, COURT_HEIGHT); */
        		}
            
        		else if (e.getKeyCode() == KeyEvent.VK_A) {
        			playerTwo.setRotation(playerTwo.getRotation() - TANK_ROTATION_VELOCITY);
        			System.out.println("david");
        		} else if (e.getKeyCode() == KeyEvent.VK_D) {
        			playerTwo.setRotation(playerTwo.getRotation() + TANK_ROTATION_VELOCITY);
        		} else if (e.getKeyCode() == KeyEvent.VK_S) {
        			moveDown(playerTwo);
        		} else if (e.getKeyCode() == KeyEvent.VK_W) {
        			moveUp(playerTwo);
        		/*} else if (e.getKeyCode() == KeyEvent.VK_SPACE) {
        			playerTwo.shoot(BULLET_VELOCITY, COURT_WIDTH, COURT_HEIGHT); */
        		}
        	}

        	public void keyReleased(KeyEvent e) {
        		playerOne.setVx(0);
        		playerOne.setVy(0);
        		playerTwo.setVx(0);
        		playerTwo.setVy(0);
        	}
        });
        this.status = status;
        this.showPointsOne = pointsOne; 
        this.showPointsTwo = pointsTwo;
        //bulletsCollection = new LinkedList<Bullet>();
        //wallsCollection = new ArrayList<Wall>();
        pointsCollection = new ArrayList<Points>();
	}
	
	public void moveUp(GameObj p) {
		double vx = TANK_VELOCITY * Math.cos(Math.toRadians(p.getRotation()));
		double vy = TANK_VELOCITY * Math.sin(Math.toRadians(p.getRotation()));
			p.setVx(vx);
			p.setVy(vy);
		
	}
	
	public void moveDown(GameObj p) {
		double vx = -TANK_VELOCITY * Math.cos(Math.toRadians(p.getRotation()));
		double vy = -TANK_VELOCITY * Math.sin(Math.toRadians(p.getRotation()));

			p.setVx(vx);
			p.setVy(vy);
		
	}
		
	/*private boolean willIntersectWall (double vx, double vy, GameObj p) {
		for (Wall wall : wallsCollection) {
			if (p.willIntersectW(vx, vy, wall)) {
				return true;
			} 
		}
		return false; 
	}*/

	
	
	public void beginPositions() {
		
		GameObj[][] gridPieces = new GameObj[8][8];
		
		int rowOne = (int) (Math.random() * 8);
		int colOne = (int) (Math.random() * 8); 
		
		int rowTwo = (int) (Math.random() * 8);
		int colTwo = (int) (Math.random() * 8);
		
		if (rowTwo == rowOne) {
			while (Math.abs(colTwo - colOne) == 1 || colTwo == colOne) {
				colTwo = (int) (Math.random() * 8); 
			}
		} else if (colTwo == colOne) {
			while (Math.abs(rowTwo - rowOne) == 1 && rowTwo == rowOne) {
				rowTwo = (int) (Math.random() * 8);
			}
		}
		playerOne = new BulletTank(COURT_WIDTH, COURT_HEIGHT, rowOne, colOne, Color.GREEN);
		playerTwo = new BulletTank(COURT_WIDTH, COURT_HEIGHT, rowTwo, colTwo, Color.ORANGE);
		
		gridPieces[rowOne][colOne] = playerOne;
		gridPieces[rowTwo][colTwo] = playerTwo;
		
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j < 8; j++) {
				if (gridPieces[i][j] == null) {
						Points newPt = new Points(COURT_WIDTH, COURT_HEIGHT, i, j, Color.RED);
						gridPieces[i][j] = newPt;
						pointsCollection.add(newPt);
				}
			}
		}
	}

		/*int vertWidth = 3; 
		int vertHeight = COURT_HEIGHT / 8;
		int horWidth = COURT_WIDTH / 8 ; 
		int horHeight = 3;
		
		int[] vertXCoords = {1, 4, 5, 1, 4, 7, 2, 5, 3, 6, 2, 3, 5, 7, 3, 4, 6, 7, 1, 5};
		int[] vertYCoords = {0, 0, 0, 1, 1, 1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 7};
		
		int[] horXCoords = {2, 6, 2, 4, 0, 4, 6, 1, 4, 0, 4, 6, 2, 5, 1, 2, 4, 6};
		int[] horYCoords = {1, 1, 2, 2, 3, 3, 3, 4, 4, 5, 5, 5, 6, 6, 7, 7, 7, 7};
		
		for (int i = 0; i < 20; i++) {
			wallsCollection.add(new Wall(vertXCoords[i] * (COURT_WIDTH / 8), vertYCoords[i] * (COURT_HEIGHT / 8), vertWidth, vertHeight, 
					COURT_WIDTH, COURT_HEIGHT)); 
		}
		
		for (int i = 0; i < 18; i++) {
			wallsCollection.add(new Wall(horXCoords[i] * (COURT_WIDTH / 8), horYCoords[i] * (COURT_HEIGHT / 8), horWidth, horHeight, 
					COURT_WIDTH, COURT_HEIGHT));
		}
	}*/
	
	public void reset() {
		
		oneCounter = 0; 
		twoCounter = 0;
		showPointsOne.setText("Player 1: ");
		showPointsTwo.setText("Player 2: ");
		status.setText("");
		
		beginPositions(); 
		
		playing = true; 
		
		requestFocusInWindow(); 
	}
	
	void tick() {
		if (playing) { 
			playerOne.move(); 
			playerTwo.move(); 
			
			Iterator<Points> iter = pointsCollection.iterator(); 
			
			while (iter.hasNext()) {
				Points curr = iter.next(); 
				if (curr.intersects(playerOne)) {
					iter.remove();
					oneCounter++;
					showPointsOne.setText("Player 1: " + oneCounter);
				} else if (curr.intersects(playerTwo)) {
					iter.remove();
					twoCounter++; 
					showPointsTwo.setText("Player 2: " + twoCounter);
				}
			}
			
			
				if (oneCounter == 25) {
					playing = false; 
					status.setText("Player 1 is the winner");
				}
				
				if (twoCounter == 25) {
					playing = false; 
					status.setText("Player 2 is the winner");
				}
			}
			
			//for (Bullet bullet : bulletsCollection) {
				//for (Wall wall : wallsCollection) {
					//bullet.move(); 
					//bullet.bounce(bullet.hitObj(wall));
					//bullet.bounce(bullet.hitWall());
					
				//}
				
				
				/*if (bullet.intersects(playerOne)) {
					bulletsCollection.clear(); 
					playing = false; 
					status.setText("Player 2 is the winner!");
					}
					
				if (bullet.intersects(playerTwo)) {
					bulletsCollection.clear(); 
					playing = false; 
					status.setText("Player 1 is the winner!");
					} */
			
			repaint(); 
	
		
	}
		
	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		
		/*for (Wall wall : wallsCollection) {
			wall.draw(g); 
		}*/
		
		for (Points point : pointsCollection) {
			point.draw(g);
		}
		
		playerOne.draw(g);
		playerTwo.draw(g);
		
		/*for (Bullet bullet : bulletsCollection) {
			bullet.draw(g);	
		}*/
	}
	
	@Override
	public Dimension getPreferredSize() {
		return new Dimension(COURT_WIDTH, COURT_HEIGHT);
	}
}

