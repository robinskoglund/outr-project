package OutR.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * Handles HTTP Requests to the OutR-application
 * See https://www.dropbox.com/s/1lpupa5ss9j68k4/SpringBoot%20Database%20instructions.pdf?dl=0 for guide
 */
@Controller
@RequestMapping(path="/outr")
public class MainController {
    @Autowired
    private OutdoorGymRepository outdoorGymRepository;

    @PostMapping(path = "/add")
    public @ResponseBody String addNewOutdoorGym (@RequestParam String name, @RequestParam double longitude,
                                                  @RequestParam double latitude) {
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
}
