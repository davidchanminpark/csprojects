global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "uk91 uk99 uk04 uk07 uk10 uk13 uk16"

global datasets_concise "uk91"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1991 &
         (inlist(occ1_c, 220,221,222,223,230,231,232,233,234,235,239,270,271,290,292,293,340,341,343,344,345,347,348,349,371,421,610,640,641,642,643,644,650,651,652,659,670,672,958))
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1999 &
          (inlist(ind1_c, 13800,14850))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2004 &
          (inlist(ind1_c, 13800,14850))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2007 &
          (inlist(ind1_c, 80,85))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2010 &
          (inlist(ind1_c, 85,86,87,88))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
          (inlist(ind1_c, 85,86,87,88))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2016 &
          (inlist(ind1_c, 85,86,87,88))
      )
        ;
   #delimit cr


  replace carework_broad=0 if carework_broad==.

  gen pilabour_hrs = gross1 * hours1 * weeks

  tabulate carework_broad sex [aw=ppopwgt]
  tabulate carework_broad [aw=ppopwgt], summarize(pilabour)
  tabulate carework_broad, summarize(pilabour_hrs)
  tabulate carework_broad [aw=ppopwgt], summarize(pilabour_hrs)
}

foreach ccyy in $datasets_concise {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_concise=1 if (year==1991 &
       (inlist(occ1_c, 293,371,644,650,651,652,659,672))
     )
     ;
   #delimit cr

  replace carework_concise=0 if carework_concise==.

  gen pilabour_hrs = gross1 * hours1 * weeks

  tabulate carework_concise sex [aw=ppopwgt]
  tabulate carework_concise [aw=ppopwgt], summarize(pilabour)
  tabulate carework_concise, summarize(pilabour_hrs)
  tabulate carework_concise [aw=ppopwgt], summarize(pilabour_hrs)
}
