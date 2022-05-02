package OutR.demo;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class OutdoorGym {

    @Id
    private String name;
    private double latitude;
    private double longitude;

    public OutdoorGym(String name, double latitude, double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.name = name;
    }

    /**
     * Needed an arg-free constructor for the Database's sake
     */
    public OutdoorGym() {
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public String toString() {
        return "Name: " + name + " Longitude: " + getLongitude() + " Latitude: " + getLatitude();
    }
}
