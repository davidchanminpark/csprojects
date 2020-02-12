package edu.upenn.cis350.hw2.ui;

import java.util.List;
import java.util.Scanner;

import edu.upenn.cis350.hw2.logging.Logger;
import edu.upenn.cis350.hw2.processor.Processor;

public class CommandLine {
    
    private Processor processor; 
    private Scanner in; 
    
    public CommandLine(Processor p) {
        this.processor = p; 
        in = new Scanner(System.in); 
    }
    
    public void start() {
        System.out.println("0: total population for zipcode /"
                + " 1: total population for all zipcodes /"
                + " 2: total parking fines per capita for each zipcode/"
                + " 3: average market value for residences per zipcode/"
                + " 4: average total livable area for residences per zipcode/"
                + " 5: total residential market value per capita/"); 
        System.out.println("Enter your selection:"); 
        while (!in.hasNextInt()) {
            System.out.println("Invalid choice"); 
            System.exit(1);
        }
        int choice = in.nextInt(); 
        
        Logger l = Logger.getInstance();
        l.log("selection: " + choice);
        
        switch (choice) {
            case 0 : popForZipCode(); 
            break; 
            case 1 : totalPop(); 
            break; 
            case 2 : totalFinesPerCapita(); 
            break; 
            case 3 : avgResMarketValue(); 
            break; 
            case 4 : avgResTotalLivableArea(); 
            break; 
            case 5 : totalResMarketValue(); 
            break; 
            default : System.out.println("Invalid choice"); 
                System.exit(1);
        } 
        
    }
    
    private void popForZipCode() {
        System.out.println("Enter zipcode: ");
        String zipcode = in.next(); 
        int pop = processor.getPopulation(zipcode); 
        System.out.println(pop); 
    }
    
    private void totalPop() {
        System.out.println(processor.getTotalPopulation()); 
    }
    
    private void totalFinesPerCapita() {
        List<String> list = processor.getTotalFinesPerCapita();
        
        for (String str : list) {
            System.out.println(str); 
        }
    }
    
    private void avgResMarketValue() {
        System.out.println("Enter zipcode:");
        String zipcode = in.next(); 
        
        Logger l = Logger.getInstance();
        l.log("zip: " + zipcode);
        
        int res = processor.getResidentialMarketValue(zipcode);
        System.out.println(res); 
    }
    
    private void avgResTotalLivableArea() {
        System.out.println("Enter zipcode:");
        String zipcode = in.next(); 
        
        Logger l = Logger.getInstance();
        l.log("zip: " + zipcode);
        
        int res = processor.getResidentialLivableArea(zipcode);
        System.out.println(res); 
    }
    
    private void totalResMarketValue() {
        System.out.println("Enter zipcode:");
        String zipcode = in.next();
        
        Logger l = Logger.getInstance();
        l.log("zip: " + zipcode);
        
        int res = processor.getTotalMarketValuePerCapita(zipcode);
        System.out.println(res);
    }
}