package edu.upenn.cis350.hw2.datamanagement;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Scanner;

import edu.upenn.cis350.hw2.data.ZipCode;
import edu.upenn.cis350.hw2.logging.Logger;

public class ParkVioCSVReader implements Reader {
    
    private String filename; 
    
    public ParkVioCSVReader(String filename) {
        this.filename = filename; 
    }

    public void updateZipCodes(Map<String, ZipCode> collection) 
            throws NoSuchElementException, NumberFormatException {
        Logger l = Logger.getInstance();
        l.log("processing: " + filename);
        
        Scanner in = null;
        boolean noMore = false; 
       
        try {
            in = new Scanner(new File(filename));
        } catch (FileNotFoundException e) {

        } 
       
        in.useDelimiter(",");
       
        while (!noMore) { 
            try {
                while (in.hasNext()) {
                    in.next(); 
                    int fine = Integer.parseInt(in.next()); 
                    in.next(); 
                    in.next(); 
                    String state = in.next(); 
                    in.next(); 
                    String zipcode = in.nextLine(); 
                    if (zipcode.equals(",")) {
                        if (in.hasNextLine()) {
                            in.nextLine(); 
                        } else {
                            noMore = true; 
                        }
                    } else {
                        zipcode = zipcode.substring(1); 
                    }
                    if (state.equals("PA")) {
                        ZipCode curr; 
                        if (collection.containsKey(zipcode)) {
                            curr = collection.get(zipcode); 
                        } else {
                            curr = new ZipCode(zipcode);
                            collection.put(zipcode, curr);
                        }
                        curr.addFine(fine);                   
                    }
                    in.nextLine(); 
                }
                noMore = true; 
            } catch (NumberFormatException e) {
                if (in.hasNextLine()) {
                    in.nextLine(); 
                } else {
                    noMore = true; 
                }
            
            } catch (NoSuchElementException e) {
                if (in.hasNextLine()) {
                    in.nextLine(); 
                } else {
                    noMore = true; 
                }
            }
            
        }
       
        in.close();  
    }
    
    
    
}