package OutR.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;

/**
 * Handles HTTP Requests to the OutR-database
 * See https://www.dropbox.com/s/1lpupa5ss9j68k4/SpringBoot%20Database%20instructions.pdf?dl=0 for guide
 */
@RestController
@RequestMapping(path="/")
public class MainController {
    @Autowired
    private OutdoorGymRepository outdoorGymRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RouteRepository routeRepository;

    @GetMapping("/")
    public String index() {
        return "OutR gym handler API. Try /all, /add or /coordinates";
    }

    /**
     * POST method for adding OutdoorGyms to the database
     * @param name name of the OutdoorGym
     * @param longitude longitude coordinate of the OutdoorGym
     * @param latitude latitude coordinate of the OutdoorGym
     * @return A response if it was successfully added
     */
    @PostMapping(path = "/add")
    public String addNewOutdoorGym (@RequestParam String name, @RequestParam double latitude,
                                                  @RequestParam double longitude) {
        OutdoorGym outdoorGym = new OutdoorGym();
        outdoorGym.setName(name);
        outdoorGym.setLongitude(longitude);
        outdoorGym.setLatitude(latitude);
        outdoorGymRepository.save(outdoorGym);
        return "Saved";
    }

    /**
     * @return JSON or XML with all OutdoorGyms
     */
    @GetMapping(path = "/all")
    public Iterable<OutdoorGym> getAllOutdoorGyms() {
        return outdoorGymRepository.findAll();
    }

    //TODO: Behöver vi denna fortfarande?
    @GetMapping(path = "/coordinates")
    public String getCoordinatesFromClient(@RequestParam String latitude, @RequestParam String longitude) {
        return "lat: " + latitude + " - long: " + longitude;
    }

    @PostMapping(path = "/user/add")
    public String addNewUser (@RequestParam String name, @RequestParam String email){
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setNoOfCompletedRoutes(0);
        user.setDailyStreak(0);
        user.setCreatedAt(new Date());
        user.setLastLogin(user.getCreatedAt());
        user.setRoutes(new HashSet<>());
        userRepository.save(user);
        return "Saved";
    }

    //TODO: Ska vi ha detta API-call? Inte så säkert att kunna plocka ut alla användare
    @GetMapping(path = "/user/all")
    public Iterable<User> getAllUsers(){
        return userRepository.findAll();
    }

    @GetMapping(path = "/user/get")
    public User getUser(@RequestParam String email){
        for (User u : userRepository.findAll()) {
            if(u.getEmail().equals(email)){
                return u;
            }
        }return null;
    }

    @PutMapping(path = "/user/update/lastLogin")
    public String updateLastLogin(@RequestParam String email){
        for (User u : userRepository.findAll()) {
            if(u.getEmail().equals(email)){
                Date newDate = new Date();
                if(newDate.getDay() - u.getLastLogin().getDay() > 1){
                    u.setDailyStreak(0);
                }
                u.setLastLogin(newDate);
                userRepository.save(u);
            }
        }
        return "Updated";
    }

    @PutMapping(path = "/user/update/increaseCompletedRoutes")
    public String increaseCompletedRoutes(@RequestParam String email){
        for (User u : userRepository.findAll()) {
            if(u.getEmail().equals(email)){
                u.increaseNoOfCompletedRoutes();
                userRepository.save(u);
            }
        }
        return "Updated";
    }

    @PutMapping(path = "/user/update/dailyStreak")
    public String increaseDailyStreak(@RequestParam String email){
        for (User u : userRepository.findAll()) {
            if(u.getEmail().equals(email)){
                u.increaseDailyStreak();
                userRepository.save(u);
            }
        }
        return "Updated";
    }

    @PostMapping(path = "/route/add")
    public String addRoute(@RequestParam String email, @RequestParam String route){

        for(User u : userRepository.findAll()){
            if(u.getEmail().equals(email)){
                User user = u;
                Route r = new Route();
                r.setUser(user);
                r.setRoute(route);
                user.addRoute(r);
                routeRepository.save(r);
                userRepository.save(user);
                return "Saved";
            }
        }

        return "User not found";
    }

    @GetMapping(path = "/route/getAllUserRoutes")
    public Iterable<Route> getRoutesForUser(@RequestParam String email){
        ArrayList<Route> routeArrayList = new ArrayList<>();
        for(Route r : routeRepository.findAll()){
            if(r.getUser().getEmail().equals(email)){
                routeArrayList.add(r);
            }
        }
        return routeArrayList;
    }

    @GetMapping(path = "route/getAll")
    public Iterable<Route> getAllRoutes(){
        return routeRepository.findAll();
    }
}
