package OutR.demo;

public class OutdoorGym extends Node {
    private final String name;

    public OutdoorGym(String name, Double longitude, Double latitude) {
        super(longitude, latitude);
        this.name = name;
    }
    public String toString() {
        return "Name: " + name + " Longitude: " + getLongitude() + " Latitude: " + getLatitude();
    }
}
