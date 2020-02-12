global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "au81 au85 au89 au95 au01 au03 au04 au08 au10 au14"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1981 &
       ((ind1_c == 24 |
         ind1_c == 25 |
         ind1_c == 25 |
         ind1_c == 26 |
         ind1_c == 27)
         |
         (occ1_c == 3 |
         occ1_c == 4 |
         occ1_c == 5 |
         occ1_c == 6)
       ))
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1985 &
        ((ind1_c == 11 |
          ind1_c == 12)
        ))
        ;
     #delimit cr

     #delimit ;
       replace carework_broad=1 if (year==1989 &
         ((ind1_c == 11 |
           ind1_c == 12)
         ))
         ;
      #delimit cr

     #delimit ;
       replace carework_broad=1 if (year==1995 &
         ((indc1 == 13 |
           indc1 == 14)
           |
           (ind1_c == 16 |
            ind1_c == 17)
         ))
         ;
      #delimit cr

      #delimit ;
        replace carework_broad=1 if (year==2001 &
          ((indc1 == 13 |
            indc1 == 14)
            |
            (ind1_c == 16 |
             ind1_c == 17)
          ))
          ;
       #delimit cr

       #delimit ;
         replace carework_broad=1 if (year==2003 &
           ((indc1 == 13 |
             indc1 == 14)
             |
             (ind1_c == 16 |
              ind1_c == 17)
           ))
           ;
        #delimit cr

        #delimit ;
          replace carework_broad=1 if (year==2004 &
            ((indc1 == 13 |
              indc1 == 14)
              |
              (ind1_c == 16 |
               ind1_c == 17)
            ))
            ;
         #delimit cr

         #delimit ;
           replace carework_broad=1 if (year==2008 &
             ((indc1 == 13 |
               indc1 == 14 |
               indc1 == 15 )
               |
               (ind1_c == 19)
             ))
             ;
          #delimit cr

          #delimit ;
            replace carework_broad=1 if (year==2010 &
              ((indc1 == 13 |
                indc1 == 14 |
                indc1 == 15 )
                |
                (ind1_c == 19)
              ))
              ;
           #delimit cr

           #delimit ;
             replace carework_broad=1 if (year==2014 &
               ((indc1 == 13 |
                 indc1 == 14 |
                 indc1 == 15 )
                 |
                 (ind1_c == 19)
               ))
               ;
            #delimit cr
    replace carework_broad=0 if carework_broad==.

    //gen pilabour_hrs = gross1 * hours1 * weeks

    gen wage = pilabour / (weeks * hours1)

    tabulate carework_broad, summarize(wage)

    //tabulate carework_broad sex [aw=ppopwgt]
    //tabulate carework_broad [aw=ppopwgt], summarize(pilabour)
  //  tabulate carework_broad, summarize(pilabour_hrs)
  //  tabulate carework_broad [aw=ppopwgt], summarize(pilabour_hrs)


    //tabulate carework_broad, summarize(pilabour) [aw=ppopwgt]
}
