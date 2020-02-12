package edu.upenn.cis350.hw3.datamanagement;

import edu.upenn.cis350.hw3.data.Person;

public interface DataSource {
    
    public Person[] get(String[] ids);

}
