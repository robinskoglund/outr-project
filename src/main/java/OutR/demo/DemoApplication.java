package OutR.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@SpringBootApplication
@RestController
public class DemoApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	@GetMapping("/hello")
	public String hello(@RequestParam(value = "name", defaultValue = "World Hehe") String name) {
		return String.format("Hello %s!", name + " varför jobbar du inte?"+ "hej");
	}
	@GetMapping("/map")
	public String map(@RequestParam(value = "names", defaultValue = "World ") String name) {
		return String.format("Hello %s!", name + " varför jobbar du inte?"+ "hej");

	}


}