package edu.upenn.cis350.hw2.datamanagement;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import edu.upenn.cis350.hw2.data.ZipCode;
import edu.upenn.cis350.hw2.logging.Logger;

public class ParkVioJSONReader implements Reader {
    
    private String filename; 
    
    public ParkVioJSONReader(String filename) {
        this.filename = filename; 
    }

    public void updateZipCodes(Map<String, ZipCode> collection) {
        Logger l = Logger.getInstance();
        l.log("processing: " + filename);
        
        JSONParser parser = new JSONParser(); 

        JSONArray parkVios = null; 
        
        File file = new File(filename); 
        
        try {
            parkVios = (JSONArray) parser.parse(new FileReader(file));
        } catch (ParseException e) {
            System.out.println("Invalid JSON format"); 
            System.exit(1);
        } catch (FileNotFoundException e) {
            System.out.println("Unreadable file"); 
            System.exit(1); 
        } catch (IOException e) {
            System.out.println("Unreadable file"); 
            System.exit(1); 
        }
        
        @SuppressWarnings("rawtypes")
        Iterator iter = parkVios.iterator();
        
        while (iter.hasNext()) {
            JSONObject curr = (JSONObject) iter.next(); 

            long fineLong = (long) curr.get("fine"); 
            String fine = "" + fineLong; 
            String zipcode = (String) curr.get("zip_code"); 
            String state = (String) curr.get("state"); 
            
            if (!zipcode.equals("") && state.equals("PA")) {
                
                ZipCode currZip; 
                if (collection.containsKey(zipcode)) {
                    currZip = collection.get(zipcode); 
                } else {
                    currZip = new ZipCode(zipcode);
                    collection.put(zipcode, currZip);
                }
                currZip.addFine(Integer.parseInt(fine));
            }
        }
        
        
    }
}
