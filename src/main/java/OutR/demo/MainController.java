package OutR.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * Handles HTTP Requests to the OutR-database
 * See https://www.dropbox.com/s/1lpupa5ss9j68k4/SpringBoot%20Database%20instructions.pdf?dl=0 for guide
 */
@Controller
@RequestMapping(path="/")
public class MainController {
    @Autowired
    private OutdoorGymRepository outdoorGymRepository;

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
    public @ResponseBody String addNewOutdoorGym (@RequestParam String name, @RequestParam double latitude,
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
    public @ResponseBody Iterable<OutdoorGym> getAllOutdoorGyms() {
        return outdoorGymRepository.findAll();
    }

    //TODO: Behöver vi denna fortfarande?
    @GetMapping(path = "/coordinates")
    public @ResponseBody String getCoordinatesFromClient(@RequestParam String latitude, @RequestParam String longitude) {
        return "lat: " + latitude + " - long: " + longitude;
    }
}
