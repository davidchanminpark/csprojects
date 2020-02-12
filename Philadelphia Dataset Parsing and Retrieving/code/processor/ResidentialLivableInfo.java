package edu.upenn.cis350.hw2.processor;

import java.util.Map;

import edu.upenn.cis350.hw2.data.ZipCode;

public class ResidentialLivableInfo implements ResidentialInfo {
    public int getInfo(String zipCode, Map<String, ZipCode> zipcodes) {
        if (zipcodes.containsKey(zipCode)) {
            ZipCode target = zipcodes.get(zipCode);
            int output = (int) Math.round(target.getLivableArea() / target.getNumResidences()); 
            return output; 
        } else {
            return 0; 
        }
    }
}