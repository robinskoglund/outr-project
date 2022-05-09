package OutR.demo;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
public class User{

    private String name;
    @Id
    private String email;
    private int noOfCompletedRoutes;
    private int dailyStreak;
    private Date createdAt;
    private Date lastLogin;

    @OneToMany(mappedBy = "route")
    private Set<Route> routes;

    //TODO: create a route class to store the routes (User and String as attribute)
    //TODO should any of the below attributes be included?
    //private Picture picture;
    //private int level;
    //private int highestStreak;
    //private Provider loginProvider;

    public User() {

    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getNoOfCompletedRoutes() {
        return noOfCompletedRoutes;
    }

    public void setNoOfCompletedRoutes(int noOfCompletedRoutes) {
        this.noOfCompletedRoutes = noOfCompletedRoutes;
    }

    public void increaseNoOfCompletedRoutes(){
        noOfCompletedRoutes++;
    }

    public int getDailyStreak() {
        return dailyStreak;
    }

    public void setDailyStreak(int dailyStreak) {
        this.dailyStreak = dailyStreak;
    }

    public void increaseDailyStreak(){
        dailyStreak++;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }

    public Set<Route> getRoutes() {
        return routes;
    }

    public void setRoutes(Set<Route> routes) {
        this.routes = routes;
    }

    public void addRoute(Route r){
        routes.add(r);
    }

    @Override
    public String toString() {
        return "User{" +
                "name='" + name + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
