package OutR.demo;

import java.io.*;
import java.util.*;

import org.json.simple.*;
import org.json.simple.parser.*;
import org.springframework.beans.factory.annotation.Autowired;

public class Sociotop {
    public Park park = new Park();
    @Autowired
    public CoordinateRepository coordinateRepository;
    public HashMap<Long, Park> parkmap = new HashMap<Long, Park>();
    public HashMap<Object, Park2> coordinateMap = new HashMap<Object, Park2>();
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
                        park.setcord(park.getCord());
                    } else {
                        park.setWaterContact(false);
                    }
                } else if ((obj.toString().equals("löpträning"))) {
                    park.setRunning(true);
                } else {
                    park.setRunning(false);
                }
                break;
            }
            park.setcord(park.getCord());
            System.out.println(park.returnCord());
            parkmap.put(park.getId(), park);
            break;
        }

        /*for(Park p : parkmap.values()){
            for (List l : p.parkCoordinates){
                for (Object o : l){
                    if(o.toString().startsWith(String.valueOf(17)) || o.toString().startsWith(String.valueOf(18))){
                    }
                    Park2 park2 = new Park2();
                    park2.setId(p.id);
                    park2.setRunning(p.running);
                    park2.setWalk(p.walk);
                    park2.setWaterContact(p.waterContact);
                    coordinateMap.put(o,park2);
                }
            }*/
        for (long p : parkmap.keySet()) {
            for (List l : park.parkCoordinates) {
                Park2 park2 = new Park2();
                park2.setId(park.id);
                park2.setRunning(park.running);
                park2.setWalk(park.walk);
                park2.setWaterContact(park.waterContact);
                for (Object o : l) {
                    //      coordinateMap.put(parkmap.get().,park2);
                }
            }
        }
    }

    public class Park {
        private long id;
        private boolean walk;
        private boolean waterContact;
        private boolean running;
        private String cord;

        public void setcord(String c) {
            this.cord = c;
        }

        public String getCord() {
            return parkCoordinates.get(0).toString();
        }

        public String returnCord() {
            return cord;
        }

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

    public class Park2 {
        private long id;
        private boolean walk;
        private boolean waterContact;
        private boolean running;

        public Park2() {
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
                    '}';
        }
    }
}

