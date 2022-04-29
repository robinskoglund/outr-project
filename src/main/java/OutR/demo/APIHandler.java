package OutR.demo;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

public class APIHandler<T> {

    /**
     * Takes a String URL and returns the connected URL using a GET-request
     * @param inputURL String url
     * @return URL the connected url from @param
     * @author Johan
     */
    public URL getFromURL(String inputURL) {
        try {
            URL url = new URL(inputURL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.connect();
            int response = connection.getResponseCode();
            if (response != 200) {
                throw new RuntimeException("HttpResponseCode " + response);
            } else {
                return url;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("URL " + inputURL + " not working.");
        }
        return null; //TODO: Fixa detta
    }

    /**
     * This is built to work with Utegym only for now
     * TODO: Fix unchecked casts
     * TODO: Generify so it's usable for more types of data?
     * @param inputURL String URL for the outDoorGym-data
     * @return ArrayList of all OutdoorGyms in URL
     * @author Johan
     */
    public ArrayList<OutdoorGym> unpackOutdoorGym(String inputURL) throws IOException {
        URL url = getFromURL(inputURL);

        //TODO: Kanske går det att använda något i still med detta? Istället för att type-casta?
        // String loudScreaming = json.getJSONObject("LabelData").getString("slogan");

        HashMap<T, T> result = new ObjectMapper().readValue(url.openStream(), HashMap.class);

        ArrayList<OutdoorGym> outdoorGyms = new ArrayList<>();

        // Goes through the ArraLists data and unpacks the locations
        for (T t : (ArrayList<T>) result.get("data")) {
            //Each t is a LinkedHashMap where relevant node-data is stored in attributes
            LinkedHashMap<T,T> map = (LinkedHashMap<T, T>) ((LinkedHashMap<T, T>) t).get("attributes");

            //Inside the coords LinkedHashMap they're stored as ints
            LinkedHashMap<T, T> coords = (LinkedHashMap<T, T>) map.get("location");
            int north = Integer.parseInt(coords.get("north").toString());
            int east = Integer.parseInt(coords.get("east").toString());

            StockholmData stockholmData = new StockholmData();
            double[] coordinates = stockholmData.convertCoordinates(north, east);

            // Adds to collection
            OutdoorGym outdoorGym = new OutdoorGym((String) map.get("name"), coordinates[0], coordinates[1]);
            outdoorGyms.add(outdoorGym);
        }

        return outdoorGyms;
    }
}
