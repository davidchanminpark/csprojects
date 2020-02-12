package edu.upenn.cis350.hw3.datamanagement;

import java.net.*;
import java.util.Iterator;
import java.util.Scanner;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import edu.upenn.cis350.hw3.data.Person;

public class RemoteDataSource implements DataSource {
    private String host;
    private int port;
    
    public RemoteDataSource() {
        // use Node Express defaults
        host = "localhost";
        port = 3000;
    }
    
    public RemoteDataSource(String host, int port) {
        this.host = host;
        this.port = port;
    }

    /* IMPLEMENT THIS METHOD! */
    public Person[] get(String[] ids) {
        
        if (ids == null) {
            throw new IllegalArgumentException(); 
        }
        
        if (ids.length == 0) {
            return new Person[0]; 
        }
        
        StringBuilder requests = new StringBuilder(); 
        
        for (int i = 0; i < ids.length; i++) {
            
            if (ids[i] == null || ids[i].equals("")) {
                throw new IllegalArgumentException(); 
            }
            
            if (i == 0) {
                requests.append("id=" + ids[i]); 
            } else {
                requests.append("&id=" + ids[i]); 
            }
        }
        
        String requestsHtml = requests.toString(); 
        
        Person[] returnArr = null; 
        
        try {
            URL url = new URL("http://" + host + ":" + port + "/get?" + requestsHtml);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection(); 
            conn.setRequestMethod("GET");
            
         // open connection and send HTTP request
            conn.connect();
            
            
            int responsecode = conn.getResponseCode();
            // make sure the response has "200 OK" as the status
            if (responsecode != 200) {
                System.out.println("Unexpected status code: " + responsecode); 
            } else {
                Scanner in = new Scanner(url.openStream());
                while (in.hasNext()) {
                    // read the next line of the body of the response
                    String line = in.nextLine();
                    // the rest of this code assumes that the body contains JSON
                    JSONParser parser = new JSONParser();
                    JSONArray people; 
                    
                    try {
                        people = (JSONArray) parser.parse(line);
                        
                        if (people.size() == 0) {
                            return new Person[0]; 
                        }
                        
                        returnArr = new Person[people.size()]; 
                        
                        @SuppressWarnings("rawtypes")
                        Iterator iter = people.iterator();
                        
                        int i = 0; 
                        
                        while (iter.hasNext()) {
                            JSONObject person = (JSONObject) iter.next(); 
                            String id = (String) person.get("id"); 
                            String status = (String) person.get("status"); 
                            long date = (long) person.get("date"); 
                            
                            returnArr[i++] = new Person(id, status, date);
                        }
                        
                    } catch (Exception e) {
                        return new Person[0]; 
                    }
                }
                in.close();
                 
            }
        } catch (Exception e) {
            throw new IllegalStateException(); 
        } 
        
        return returnArr;
    }

}
