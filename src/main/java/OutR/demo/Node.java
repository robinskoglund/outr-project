package OutR.demo;

import java.util.ArrayList;

public class Node {
    private final Double  longitude;
    private final Double latitude;
    private final Integer id;

    public Node(Double longitude, Double latitude){
        this.longitude=longitude;
        this.latitude=latitude;
        id = 1; //TODO: Fix
    }
    public Double getLongitude(){return longitude;}
    public Double getLatitude(){return latitude;}
    public Integer getId() {return id;}
    public String toString() {
        return "Longitude: " +longitude + " Latitude: " + latitude;
    }
}
