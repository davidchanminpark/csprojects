package edu.upenn.cis350.hw3.processor;

import java.util.HashMap;
import java.util.Map;

import edu.upenn.cis350.hw3.data.Person;
import edu.upenn.cis350.hw3.datamanagement.DataSource;


public class StatusProcessor {
    // DO NOT CHANGE THE VISIBILITY OF THESE FIELDS!
    protected DataSource dataSource;
    protected Map<String, Person> map = new HashMap<>();
    
    public StatusProcessor(DataSource ds) {
        dataSource = ds;
    }
    
    /* IMPLEMENT THIS METHOD! */
    public Person[] get(String[] ids) {
        
        if (ids == null) {
            throw new IllegalArgumentException(); 
        }
        
        if (dataSource == null) {
            throw new IllegalStateException(); 
        }
        
        if (ids.length == 0) {
            return new Person[0]; 
        }
        
        for (String id : ids) {
            if (id == null || id.equals("")) {
                return new Person[0]; 
            }
        }
        
        
        Person[] people = new Person[ids.length];
        try {
            Person[] returned = dataSource.get(ids);
            
            if (returned.length == 0) {
                errorHelper(people, ids); 
            } else {
                for (int i = 0; i < people.length; i++) {
                    Person p = returned[i]; 
                    String id = p.getId(); 
                    long lastUpdated = p.getLastUpdated(); 
                    
                    if (map.containsKey(id)) {
                        Person personStored = map.get(id); 
                        if (personStored.getLastUpdated() < lastUpdated) {
                            people[i] = personStored; 
                        } else {
                            people[i] = p; 
                        }
                    } else {
                        people[i] = p; 
                    }
                }
            }
            
        } catch (Exception e) {
            errorHelper(people, ids); 
        }
        
        return people; 
    }
    
    void errorHelper(Person[] people, String[] ids) {
        for (int i = 0; i < ids.length; i++) {
            String id = ids[i]; 
            if (map.containsKey(id)) {
                people[i] = map.get(id); 
            } else {
                people[i] = new Person(id, "unknown", System.currentTimeMillis()); 
            }
        }
    }
    
}
