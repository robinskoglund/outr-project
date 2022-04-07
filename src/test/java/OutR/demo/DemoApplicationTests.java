package OutR.demo;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DemoApplicationTests {

	@Test
	void contextLoads() {
	}

	/**
	 * Added just to maintain the proper import for asserttions, "import static org.junit.jupiter.api.Assertions.*;"
	 */
	@Test
	void test() {
		assertTrue(true);
	}

}
