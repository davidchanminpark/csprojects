package edu.upenn.cis350.hw2.datamanagement;

import java.util.Map;

import edu.upenn.cis350.hw2.data.ZipCode;

public interface Reader {
    public void updateZipCodes(Map<String, ZipCode> collection); 
}