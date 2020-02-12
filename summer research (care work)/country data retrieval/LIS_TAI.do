global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "tw05 tw07 tw10 tw13 tw16"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2005 &
         (inlist(ind1_c, 13000,14000,15000))
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2007 &
          (inlist(ind1_c, 18,19,21))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2010 &
          (inlist(ind1_c, 18,19,21))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
          (inlist(ind1_c, 18,19,21))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2016 &
          (inlist(ind1_c, 18,19,21))
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
