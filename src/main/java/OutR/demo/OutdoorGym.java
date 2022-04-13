package OutR.demo;

public class OutdoorGym extends Node {
    public OutdoorGym(Double longitude, Double latitude, Integer id) {
        super(longitude, latitude, id);
    }
    public String toString() {
        return "Longitude: " +getLongitude() + " Latitude: " + getLatitude();
    }
}
