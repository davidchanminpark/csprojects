package edu.upenn.cis350.hw2.processor;

import java.util.Map;

import edu.upenn.cis350.hw2.data.ZipCode;

public interface ResidentialInfo {
    public int getInfo(String zipCode, Map<String, ZipCode> zipcodes); 
}