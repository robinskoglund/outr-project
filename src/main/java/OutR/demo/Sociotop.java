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

            JSONParser jsonParser = new JSONParser();

            File file = new File("C:\\Users\\arman\\IdeaProjects\\pvt4\\src\\main\\java\\OutR\\demo\\SociotopKarta.geojson");

            Object object = jsonParser.parse(new FileReader(file));

            jsonObject = (JSONObject) object;

            parseJson(jsonObject);

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void getArray(Object object2) throws ParseException {

        JSONArray jsonArr = (JSONArray) object2;

        for (int k = 0; k < jsonArr.size(); k++) {

            if (jsonArr.get(k) instanceof JSONObject) {
                parseJson((JSONObject) jsonArr.get(k));
            } else {
                System.out.println(jsonArr.get(k));
            }

        }
    }

    public static void parseJson(JSONObject jsonObject) throws ParseException {

        Set<Object> set = jsonObject.keySet();
        Iterator<Object> iterator = set.iterator();
        while (iterator.hasNext()) {
            Object obj = iterator.next();
            if (jsonObject.get(obj) instanceof JSONArray) {
                System.out.println(obj.toString());
                getArray(jsonObject.get(obj));
            } else {
                if (jsonObject.get(obj) instanceof JSONObject) {
                    parseJson((JSONObject) jsonObject.get(obj));
                } else {
                    System.out.println(obj.toString() + "\t"
                            + jsonObject.get(obj));
                }
            }
        }
    }}
