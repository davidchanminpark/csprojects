
import java.awt.*;

import java.awt.event.*; 
import javax.swing.*; 
/**
 * Game class that specifies the frame and widgets of the GUI
 */
public class Game implements Runnable {
		public void run() {
			
			// Top-level frame 
			final JFrame frame = new JFrame("Tank Trouble");
			frame.setLocation(500, 500);
			
			// Instructions pop-up
			final String INSTRUCTIONS = ("Player 1 uses UP, DOWN, RIGHT, LEFT to control its "
					+ "tank's movement. Player 2 uses W, S, A, D to control its tank. The first "
					+ "player to eat 25 of the red squares wins the game.");
			JOptionPane.showMessageDialog(frame, INSTRUCTIONS, "Instructions:", 
					JOptionPane.PLAIN_MESSAGE);
			
			// Score panel
			final JPanel scorePanel = new JPanel(); 
			frame.add(scorePanel, BorderLayout.NORTH);

			final JLabel status = new JLabel("");
			final JLabel pointsOne = new JLabel("Player 1: 0");
			final JLabel pointsTwo = new JLabel("Player 2: 0");

			scorePanel.add(pointsOne);
			scorePanel.add(pointsTwo);
			scorePanel.add(status);
			
			// Main game area
			final GameCourt grid = new GameCourt(pointsOne, pointsTwo, status);
			frame.add(grid, BorderLayout.CENTER);
			
			// Play again button
			final JPanel playAgainPanel = new JPanel();
			frame.add(playAgainPanel, BorderLayout.SOUTH);
			
			final JButton playAgain = new JButton("Play Again?"); 
			playAgain.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					grid.reset();
				}
			});
			playAgainPanel.add(playAgain);
			
			frame.pack();
	        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	        frame.setVisible(true);
	        
	        grid.reset();

	}

	public static void main(String[] args) {
		SwingUtilities.invokeLater(new Game());
	}

}
