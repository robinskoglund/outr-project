package OutR.demo;

import com.github.goober.coordinatetransformation.positions.SWEREF99Position;
import com.github.goober.coordinatetransformation.positions.WGS84Position;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Class for handling Stockholms stads' data.
 * @author johan
 */
public class StockholmData {

    private static final String OUTDOOR_GYM_URL = "https://apigw.stockholm.se/NoAuth/VirtualhittaserviceDMZ/Rest/" +
            "serviceunits?&filter[servicetype.id]=122&page[limit]=1500&page[offset]=0&sort=name";
    private ArrayList<OutdoorGym> outdoorGyms = new ArrayList<>();

    public void populateOutdoorGyms() throws IOException {
        APIHandler apiHandler = new APIHandler();
        outdoorGyms = apiHandler.unpackOutdoorGym(OUTDOOR_GYM_URL);
    }

    public ArrayList<OutdoorGym> getOutdoorGyms() {
        return outdoorGyms;
    }

    /**
     * Takes coordinates as written in Stockholms stads API (utegym at least) and returns a String that is searchable
     * in google maps API where Lat and Long is separated by a comma.
     *
     * @param north N coordinate in SWEREF99 18 00
     * @param east  N coordinate in SWEREF99 18 00
     * @return double[] where [0] = latitude and [1] = longitude in decimal coordinates
     * @author Johan
     */
    public double[] convertCoordinatesSWEREFtoWGS84(int north, int east) {
        SWEREF99Position sweref99Position = new SWEREF99Position(north, east,
                SWEREF99Position.SWEREFProjection.sweref_99_18_00);
        sweref99Position.toWGS84();

        WGS84Position wgs84 = sweref99Position.toWGS84();
        double latitude = wgs84.getLatitude();
        double longitude = wgs84.getLongitude();

        double[] coordinates = new double[2];
        coordinates[0] = latitude;
        coordinates[1] = longitude;

        return coordinates;
    }
    public class RdJSONFile{
        private StringBuffer stringBuffer = new StringBuffer();
        public void jsontojava() throws Exception{
            String data = "parker.geojson";

        }

    }

}
