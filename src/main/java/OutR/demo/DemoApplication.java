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
	 * @param repository the outdoor_gym table in the databasez
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
}