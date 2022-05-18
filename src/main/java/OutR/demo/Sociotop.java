package OutR.demo;

import java.io.*;
import java.util.*;

import org.json.simple.*;
import org.json.simple.parser.*;

public class Sociotop {
    public Park park = new Park();
    public HashMap<Long, Park> parkmap = new HashMap<Long, Park>();
    public static Properties properties = null;
    public static JSONObject jsonObject = null;

    static {
        properties = new Properties();
    }

    public void run() {
        try {
            JSONParser jparser = new JSONParser();
            File file = new File("C:\\Users\\arman\\IdeaProjects\\pvt4\\src\\main\\java\\OutR\\demo\\SociotopKarta.geojson");
            Object resoursefile = jparser.parse(new FileReader(file));
            jsonObject = (JSONObject) resoursefile;
            parser(jsonObject);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void getData(Object object2) throws ParseException {
        JSONArray jsonArr = (JSONArray) object2;
        for (int k = 0; k < jsonArr.size(); k++) {
            if (jsonArr.get(k) instanceof JSONObject) {
                parser((JSONObject) jsonArr.get(k));
            } else {
                park = new Park();
                park.setParkCoordinates((ArrayList<ArrayList<Double>>) jsonArr.get(k));
            }
        }
    }

    public void parser(JSONObject jsonObject) throws ParseException {
        Set<Object> set = jsonObject.keySet();
        Iterator<Object> iterator = set.iterator();
        while (iterator.hasNext()) {
            Object obj = iterator.next();
            if (jsonObject.get(obj) instanceof JSONArray) {
                getData(jsonObject.get(obj));
            } else {
                if (jsonObject.get(obj) instanceof JSONObject) {
                    parser((JSONObject) jsonObject.get(obj));
                } else if ((obj.toString().equals("id"))) {
                    park.setId((Long) jsonObject.get(obj));
                } else if ((obj.toString().equals("promenader"))) {
                    if ((Long) jsonObject.get(obj) == 1) {
                        park.setWalk(true);
                    } else {
                        park.setWalk(false);
                    }
                } else if ((obj.toString().equals("vattenkont"))) {
                    if ((Long) jsonObject.get(obj) == 1) {
                        park.setWaterContact(true);
                    } else {
                        park.setWaterContact(false);
                    }
                } else if ((obj.toString().equals("löpträning"))) {
                    park.setRunning(true);
                } else {
                    park.setRunning(false);
                }
            }
            parkmap.put(park.getId(), park);
        }
    }

    public class Park {
        private long id;
        private boolean walk;
        private boolean waterContact;
        private boolean running;
        private ArrayList<ArrayList<Double>> parkCoordinates;

        public Park() {

        }

        public void setParkCoordinates(ArrayList<ArrayList<Double>> parkCoordinates) {
            this.parkCoordinates = parkCoordinates;
        }

        public void setId(long id) {
            this.id = id;
        }

        public void setWalk(boolean walk) {
            this.walk = walk;
        }

        public void setWaterContact(boolean waterContact) {
            this.waterContact = waterContact;
        }

        public void setRunning(boolean running) {
            this.running = running;
        }

        public long getId() {
            return id;
        }

        @Override
        public String toString() {
            return "Park{" +
                    "id=" + id +
                    ", walk=" + walk +
                    ", waterContact=" + waterContact +
                    ", running=" + running +
                    ", parkCoordinates=" + parkCoordinates +
                    '}';
        }
    }
}

