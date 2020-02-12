package edu.upenn.cis350.hw2.data; 

public class ZipCode {
    private final String zipCode; 
    private int population; 
    
    private int totalFines; 
    private double totalLivableArea; 
    private double totalMarketValue; 
    
    private int numResidences; 
    
    public ZipCode(String zipcode) {
        this.zipCode = zipcode; 
    }
    
    public int getPopulation() {
        return population; 
    }
    
    public void addPopulation(int pop) {
        this.population += pop; 
    }
    
    public double getTotalFines() {
        return totalFines; 
    }
    
    public void addFine(int fine) {
        this.totalFines += fine; 
    }
    
    public double getMarketValue() {
        return totalMarketValue; 
    }
    
    public void addMarketValue(double marketValue) {
        this.totalMarketValue += marketValue; 
    }
    
    public double getLivableArea() {
        return totalLivableArea; 
    }
    
    public void addLivableArea(double area) {
        this.totalLivableArea += area; 
    }
    
    public int getNumResidences() {
        return numResidences; 
    }
    
    public void addResidence() {
        this.numResidences++; 
    }
    
    public String getZipCode() {
        return zipCode; 
    }
}