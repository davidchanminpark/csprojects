
import static org.junit.Assert.*;

import org.junit.Test;


public class JUnitTesting {
	
	// object at position (10, 10) with width of 10 and height of 10
	GameObj intersectingObject1 = new TestObj(100, 100, 10, 10);
			
	// object at position (12, 12) with width of 10 and height of 10
	GameObj intersectingObject2 = new TestObj(100, 100, 12, 12);
	
	// object at position (50, 50) with width of 10 and height of 10
	GameObj nonintersectingObject = new TestObj(100, 100, 50, 50);
	
	@Test
	public void testIntersectingObjects() {
		assertTrue(intersectingObject1.intersects(intersectingObject2));
	}
	
	@Test
	public void testIntersectingObjectsTransitive() {
		assertTrue(intersectingObject2.intersects(intersectingObject1));
	}
	
	@Test
	public void testNonIntersectingObjects() {
		assertFalse(intersectingObject1.intersects(nonintersectingObject));
	}
	
	@Test
	public void testNonIntersectingObjectsTransitive() {
		assertFalse(nonintersectingObject.intersects(intersectingObject2));
	}
	
	
}
	
	
