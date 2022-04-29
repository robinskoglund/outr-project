package OutR.demo;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;


@SpringBootApplication
@RestController
public class DemoApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	/**
	 * Fetches the outdoor gyms from Dataportalen API and adds them to the database.
	 * If database is already populated and the size of the API call isn't the same as
	 * the size of the database, all entries are in the database is first deleted
	 * @param repository the outdoor_gym table in the database
	 * @author Johan & Erik
	 */
	@Bean
	public CommandLineRunner outdoorGymsToDatabase(OutdoorGymRepository repository) {
		return args -> {
			StockholmData stockholmData = new StockholmData();
			stockholmData.populateOutdoorGyms();
			ArrayList<OutdoorGym> outdoorGyms = stockholmData.getOutdoorGyms();

			if (stockholmData.getOutdoorGyms().size() != repository.count()) {
				repository.deleteAll();
			}
			repository.saveAll(outdoorGyms);
		};
	}

	//TODO: Vi kan väl ta bort de här sidorna?
	@GetMapping("/hello")
	public String hello(@RequestParam(value = "name", defaultValue = "World Hehe") String name) {
		return String.format("Hello %s!", name + " varför jobbar du inte?"+ "hej");
	}
	@GetMapping("/map")
	public String map(@RequestParam(value = "names", defaultValue = "World ") String name) {
		return String.format("Hello %s!", name + " varför jobbar du inte?"+ "hej");
	}

	@GetMapping("/routes")
	@ResponseBody
	public String routes(@RequestParam String location1, String location2) {
		Node node1 = new Node(59.107059, 18.125771);
		Node node2 = new Node(59.307059, 18.025771);
		return "https://maps.googleapis.com/maps/api/directions/json?origin=" + node1.getLongitude() + "," + node1.getLatitude() +"&destination=" + node2.getLongitude() + "," + node2.getLatitude() + "&key=AIzaSyAof5d9wSMDRtbrMAn64WD2swKSJ8JEDNY";
	}
}