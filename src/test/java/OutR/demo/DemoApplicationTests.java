package OutR.demo;

import org.hamcrest.CoreMatchers;
import org.hamcrest.MatcherAssert;
import org.junit.jupiter.api.Assertions;
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
    void coordinates() throws IOException {
        // Two pairs of outdoor gym coordinates from Stockholms Utegym-API
        final int testValueN = 6576875;
        final int testValueE = 151468;
        final int vasaParkenN = 6580442;
        final int vasaParkenE = 152307;

        StockholmData stockholmData = new StockholmData();
        stockholmData.populateOutdoorGyms();

        // Since google maps coordinates are rounded, comparison is made with one less decimal.
        // The actual difference is minimal on the map
        MatcherAssert.assertThat(Arrays.toString(stockholmData.convertCoordinatesSWEREFtoWGS84(vasaParkenN, vasaParkenE)),
                CoreMatchers.allOf(
                        CoreMatchers.containsString("59.33907"),
                        CoreMatchers.containsString("18.04053")
                ));
        MatcherAssert.assertThat(Arrays.toString(stockholmData.convertCoordinatesSWEREFtoWGS84(testValueN, testValueE)),
                CoreMatchers.allOf(
                        CoreMatchers.containsString("59.30705"),
                        CoreMatchers.containsString("18.02577")
                ));

        // Makes sure all the outdoorgyms are within Stockholm
        for (OutdoorGym outdoorGym : stockholmData.getOutdoorGyms()) {
            Assertions.assertTrue(outdoorGym.getLatitude() < 59.5  && outdoorGym.getLatitude() > 59.0);
            Assertions.assertTrue(outdoorGym.getLongitude() < 19.0 && outdoorGym.getLongitude() > 17.7);
        }
    }

    @Test
    void readJson() throws IOException {
        StockholmData stockholmData = new StockholmData();
        stockholmData.populateOutdoorGyms();
    }
    @Test
    void testSociotop() throws IOException{
        Sociotop s = new Sociotop();
        s.run();
        for (Object o : s.coordinateMap.keySet()){
          // System.out.println(o);
        }
    }
}
