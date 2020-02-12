package edu.upenn.cis350.hw2.datamanagement;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Map;
import java.util.Scanner;

import edu.upenn.cis350.hw2.data.ZipCode;
import edu.upenn.cis350.hw2.logging.Logger;

public class PopReader implements Reader {

    private String filename; 
    
    public PopReader(String filename) {
        this.filename = filename; 
    }
    
    @Override
    public void updateZipCodes(Map<String, ZipCode> collection) {
        Logger l = Logger.getInstance();
        l.log("processing: " + filename);
        Scanner in = null; 
        
        try {
            in = new Scanner(new File(filename)); 
        } catch (FileNotFoundException e) {
            
        } 
        
        while (in.hasNext()) {
            String zipcode = in.next(); 
            String popStr = in.next(); 
            int pop = Integer.parseInt(popStr); 
            
            ZipCode newZip = new ZipCode(zipcode); 
            collection.put(zipcode, newZip);
            newZip.addPopulation(pop);
            in.nextLine(); 
        }
        in.close(); 
    }

    
}