package OutR.demo;

//TODO: Ska vi ta bort den här klassen?
public class Node {
    private final double longitude;
    private final double latitude;

    public Node(double longitude, double latitude) {
        this.longitude = longitude;
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public String toString() {
        return "Longitude: " + longitude + " Latitude: " + latitude;
    }
}
