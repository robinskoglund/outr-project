package OutR.demo;

import java.io.*;
import java.util.*;
import org.json.simple.*;
import org.json.simple.parser.*;

public class Sociotop {
    public static Properties properties = null;
    public static JSONObject jsonObject = null;
    static {
        properties = new Properties();
    }

    public static void main(String[] args) {

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

    public static void getData(Object object2) throws ParseException {
        JSONArray jsonArr = (JSONArray) object2;
        for (int k = 0; k < jsonArr.size(); k++) {
            if (jsonArr.get(k) instanceof JSONObject) {
                parser((JSONObject) jsonArr.get(k));
            } else {
                System.out.println(jsonArr.get(k));
            }
        }
    }

    public static void parser(JSONObject jsonObject) throws ParseException {
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
                    System.out.println(obj + "\t"
                            + jsonObject.get(obj));

                } else if ((obj.toString().equals("promenader"))) {
                    System.out.println(obj + "\t"
                            + jsonObject.get(obj));
                } else if ((obj.toString().equals("vattenkont"))) {
                    System.out.println(obj + "\t"
                            + jsonObject.get(obj));
                }
                else if ((obj.toString().equals("löpträning"))) {
                    System.out.println(obj + "\t"
                            + jsonObject.get(obj));
                }
                if(obj.toString().contains("löpträning")){
                    Coordinate Coord = new Coordinate();
                }
            }
        }
    }
    public class Park{
        private int id;
        private boolean walk;
        private boolean waterContact;
        private boolean running;
        private ArrayList<ArrayList<Double>> parkCoordinates;

        public Park(ArrayList<ArrayList<Double>> parkCoordinates) {
            this.parkCoordinates = parkCoordinates;
        }

        public void setId(int id) {
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
    }
}

