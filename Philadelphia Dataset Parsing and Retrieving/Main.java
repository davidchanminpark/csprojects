package edu.upenn.cis350.hw2;

import java.io.File;
import edu.upenn.cis350.hw2.datamanagement.*;
import edu.upenn.cis350.hw2.processor.Processor;
import edu.upenn.cis350.hw2.ui.CommandLine;

public class Main {
    public static void main(String[] args) {
        
        if (args.length != 4) {
            System.out.println("Incorrect number of arguments"); 
            System.exit(1);
        }
        
        String typeParkVio = args[0];
        String parkVioName = args[1]; 
        String propValName = args[2]; 
        String popName = args[3]; 
        
        if (!typeParkVio.equals("csv") && !typeParkVio.equals("json")) {
            System.out.println("First argument must be csv or json"); 
            System.exit(2);
        }
        
        File parkVio = new File(parkVioName); 
        File propVal = new File(propValName); 
        File pop = new File(popName); 
        
        if (!parkVio.exists() || !propVal.exists() || !pop.exists()) {
            System.out.println("Unreadable file"); 
            System.exit(3);
        }

        if (!parkVio.canRead() || !propVal.canRead() || !pop.canRead()) {
            System.out.println("Unreadable file"); 
            System.exit(3);
        }
        
        Reader popReader = new PopReader(popName); 
        Reader parkVioReader = (typeParkVio.equals("csv")) ? new ParkVioCSVReader(parkVioName) : 
            new ParkVioJSONReader(parkVioName);
        Reader propValReader = new PropValReader(propValName); 
        
        Processor processor = new Processor(parkVioReader, popReader, propValReader); 
        
        CommandLine ui = new CommandLine(processor); 
        
        ui.start(); 
        
    }
}
