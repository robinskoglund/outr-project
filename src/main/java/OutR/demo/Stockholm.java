package OutR.demo;

import com.github.goober.coordinatetransformation.positions.SWEREF99Position;
import com.github.goober.coordinatetransformation.positions.WGS84Position;


public class Stockholm {

    /**
     * Takes coordinates as written in Stockholms stads API (utegym at least) and returns a String that is searchable
     * in google maps API where Lat and Long is separated by a comma.
     * @author Johan
     * @param north N coordinate in SWEREF99 18 00
     * @param east N coordinate in SWEREF99 18 00
     * @return latitude, longitude in decimal coordinates
     */
    public String convertCoordinates(int north, int east) {
        SWEREF99Position sweref99Position = new SWEREF99Position(north, east,
                SWEREF99Position.SWEREFProjection.sweref_99_18_00);
        sweref99Position.toWGS84();

        WGS84Position wgs84 = sweref99Position.toWGS84();
        double latitude = wgs84.getLatitude();
        double longitude = wgs84.getLongitude();

        return latitude + ", " + longitude;
    }
}
