package OutR.demo;

import javax.persistence.*;

@Entity
public class Route {

    @ManyToOne
    @JoinColumn(name="email", nullable = false)
    private User user;

    private String route;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    public Route(){}

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }
}
