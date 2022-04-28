package OutR.demo;

import org.hamcrest.CoreMatchers;
import org.hamcrest.MatcherAssert;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.util.Arrays;

@SpringBootTest
class DemoApplicationTests {

    @Test
    void contextLoads() {
    }

    @Test
    void coordinates() {
        //TODO: Automatisera de här testerna. Just nu har jag skrivit in resultatmatchningen manuellt

        // Two pairs of outdoor gym coordinates from Stockholms Utegym-API
        final int testValueN = 6576875;
        final int testValueE = 151468;
        final int vasaParkenN = 6580442;
        final int vasaParkenE = 152307;

        StockholmData stockholmData = new StockholmData();

        // Since google maps coordinates are rounded, comparison is made with one less decimal.
        // The actual difference is minimal on the map
        MatcherAssert.assertThat(Arrays.toString(stockholmData.convertCoordinates(vasaParkenN, vasaParkenE)), CoreMatchers.allOf(
                CoreMatchers.containsString("59.33907"),
                CoreMatchers.containsString("18.04053")
        ));
        MatcherAssert.assertThat(Arrays.toString(stockholmData.convertCoordinates(testValueN, testValueE)), CoreMatchers.allOf(
                CoreMatchers.containsString("59.30705"),
                CoreMatchers.containsString("18.02577")
        ));

    }

    @Test
    void readJson() throws IOException {
        StockholmData stockholmData = new StockholmData();
        stockholmData.populateOutdoorGyms();
    }

}
