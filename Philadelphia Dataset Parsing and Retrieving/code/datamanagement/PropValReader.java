package edu.upenn.cis350.hw2.datamanagement;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Scanner;

import edu.upenn.cis350.hw2.data.ZipCode;
import edu.upenn.cis350.hw2.logging.Logger;

public class PropValReader implements Reader {
    
    private String filename; 
    
    public PropValReader(String filename) {
        this.filename = filename; 
    }

    public void updateZipCodes(Map<String, ZipCode> collection)
            throws NoSuchElementException, NumberFormatException {
        Logger l = Logger.getInstance();
        l.log("processing: " + filename);
        
        Scanner in = null; 
       
        try {
            in = new Scanner(new File(filename));
        } catch (FileNotFoundException e) {
        }
       
        in.useDelimiter(","); 
       
        int order = 0; 
        int time = 0; 
       
        int[] waitTime = new int[3]; 
       
        int zipCodeInd = 0;
        int livableAreaInd = 0;
        int marketValueInd = 0; 
       
        while (order < 3) {
            String curr = in.next(); 
            switch (curr) {
                case "zip_code" : zipCodeInd = order; 
                waitTime[order++] = time; 
                time = 0; 
                break; 
                case "total_livable_area" : livableAreaInd = order; 
                waitTime[order++] = time; 
                time = 0; 
                break; 
                case "market_value" : marketValueInd = order; 
                waitTime[order++] = time; 
                time = 0; 
                break; 
                default : time++; 
            }
            
        }
        in.nextLine(); 
       
        String[] results = new String[3]; 
       
        try {
            while (in.hasNext()) {
                for (int i = 0; i < waitTime[0]; i++) {
                    in.next(); 
                }
                results[0] = in.next(); 
               
                for (int i = 0; i < waitTime[1]; i++) {
                    in.next(); 
                }
                results[1] = in.next(); 
               
                for (int i = 0; i < waitTime[2]; i++) {
                    in.next(); 
                }
                results[2] = in.next(); 
               
               
               
                String zipCodeStr = results[zipCodeInd]; 
                String livableAreaStr = results[livableAreaInd]; 
                String marketValueStr = results[marketValueInd]; 
               
                if (zipCodeStr.length() >= 5 && isNumeric(livableAreaStr) 
                       && isNumeric(marketValueStr) && isNumeric(zipCodeStr)) {
                    String zipCode = zipCodeStr.substring(0, 5); 
                    double livableArea = Double.parseDouble(results[livableAreaInd]); 
                    double marketValue = Double.parseDouble(results[marketValueInd]);
                   
                    if (livableArea >= 0 && marketValue >= 0) {
                        ZipCode curr; 
                        if (collection.containsKey(zipCode)) {
                            curr = collection.get(zipCode); 
                        } else {
                            curr = new ZipCode(zipCode);
                            collection.put(zipCode, curr);
                        }
                        curr.addLivableArea(livableArea);
                        curr.addMarketValue(marketValue);
                        curr.addResidence(); 
                    }
                }
                in.nextLine(); 
            }
        } finally {
            in.close(); 
        }
        
    }
    
    public static boolean isNumeric(String strNum) {
        if (strNum == null) {
            return false;
        }
        try {
            Double.parseDouble(strNum);
        } catch (NumberFormatException nfe) {
            return false;
        }
        return true;
    }
    
}