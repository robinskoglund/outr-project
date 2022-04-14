package OutR.demo;

public class Node {
    private final Double  longitude;
    private final Double latitude;

    public Node(Double longitude, Double latitude){
        this.longitude=longitude;
        this.latitude=latitude;
    }

    public Double getLongitude(){return longitude;}
    public Double getLatitude(){return latitude;}
    public String toString() {
        return "Longitude: " +longitude + " Latitude: " + latitude;
    }
}
