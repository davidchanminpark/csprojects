package edu.upenn.cis350.hw2.processor;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import edu.upenn.cis350.hw2.data.ZipCode;
import edu.upenn.cis350.hw2.datamanagement.Reader;

public class Processor {
    
    Map<String, ZipCode> zipcodes; 
    
    public Processor(Reader parkVioReader, Reader popReader, Reader propValReader) {
        Map<String, ZipCode> parseColl = new HashMap<String, ZipCode>();
         
        popReader.updateZipCodes(parseColl); 
        parkVioReader.updateZipCodes(parseColl); 
        propValReader.updateZipCodes(parseColl); 
        
        zipcodes = parseColl; 
    }
    
    public int getPopulation(String zipCode) {
        if (zipcodes.containsKey(zipCode)) {
            ZipCode target = zipcodes.get(zipCode); 
            return target.getPopulation(); 
        } else {
            return 0; 
        }
    }
    
    public int getTotalPopulation() {
        int pop = 0; 
        for (ZipCode curr : zipcodes.values()) {
            pop += curr.getPopulation(); 
        }
        return pop; 
    }
    
    public List<String> getTotalFinesPerCapita() {
        List<String> list = new ArrayList<String>(); 
        for (ZipCode curr : zipcodes.values()) {
            int pop = curr.getPopulation(); 
            double totalFines = curr.getTotalFines(); 
            
            
            if (pop != 0 && totalFines != 0.0) {
                double finesPerCapitaNumber = totalFines / pop; 
                String finesPerCapitaStr = String.format("%.4f", finesPerCapitaNumber);
                String zipcode = curr.getZipCode(); 
                list.add(zipcode + " " + finesPerCapitaStr); 
            }
        }
        Collections.sort(list);
        return list; 
    }
    
    private int getResidential(String zipCode, Map<String, ZipCode> zipcodes, ResidentialInfo res) {
        return res.getInfo(zipCode, zipcodes); 
    }
    
    
    public int getResidentialMarketValue(String zipCode) {
        return getResidential(zipCode, zipcodes, new ResidentialValueInfo()); 
    }
    
    public int getResidentialLivableArea(String zipCode) {
        return getResidential(zipCode, zipcodes, new ResidentialLivableInfo()); 
    }
    
    public int getTotalMarketValuePerCapita(String zipCode) {
        if (zipcodes.containsKey(zipCode)) {
            ZipCode target = zipcodes.get(zipCode); 
            if (target.getPopulation() == 0) {
                return 0; 
            }
            int output = (int) Math.round(target.getMarketValue() / target.getPopulation()); 
            return output; 
        } else {
            return 0; 
        }
    }
    
    
}