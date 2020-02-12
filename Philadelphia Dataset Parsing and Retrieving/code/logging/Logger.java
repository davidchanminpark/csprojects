package edu.upenn.cis350.hw2.logging; 

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class Logger {
    private FileWriter out; 
    
    private Logger(String filename) {
        try {
            File file = new File("log.txt"); 
            if (!file.exists()) {
                file.createNewFile(); 
            }
            out = new FileWriter(file, true); 
        } catch (Exception e) {
            
        }
    }
    
    private static Logger instance = new Logger("log.txt"); 
    
    public static Logger getInstance() {
        return instance; 
    }
    
    public void log(String str) {
        try {
            out.write(str + "\n");
            out.flush();
        } catch (IOException e) {
            
        }
         
    }
}