package OutR.demo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class OutdoorGym {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String name;
    private double longitude;
    private double latitude;

    public OutdoorGym(String name, double longitude, double latitude) {
        this.longitude = longitude;
        this.latitude = latitude;
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
