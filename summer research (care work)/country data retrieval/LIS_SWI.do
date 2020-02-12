global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "ch92 ch00 ch02 ch07 ch10 ch13"

global datasets_concise "ch92 ch00 ch02"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1992 &
         (inlist(occ1_c, 361,372,411,421,422,423,425,431,432,441,442,443,444,445,446,447))
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2000 &
          (inlist(occ1_c, 2220,2310,2320,2340,2350,2430,2460,3220,3230,3310,3320,3340,3480,5130,5140,5160))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2002 &
          (inlist(occ1_c, 2220,2310,2320,2340,2350,2430,2460,3220,3230,3310,3320,3340,3480,5130,5140,5160))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 10,11,12,13))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 10,11,12,13))
        & // and
          (inlist(occ1_c, 2200,2300,3200,5100,5300,5400))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 10,11,12,13))
        & // and
          (inlist(occ1_c, 2200,2300,3200,5100,5300,5400))
        )
      )
        ;
   #delimit cr

  replace carework_broad=0 if carework_broad==.

  gen pilabour_hrs = gross1 * hours1 * weeks

  gen wage = pilabour / (weeks * hours1)

  tabulate carework_broad [aw=ppopwgt], summarize(wage)

  // tabulate carework_broad sex [aw=ppopwgt]
  // tabulate carework_broad [aw=ppopwgt], summarize(pilabour)
  // tabulate carework_broad, summarize(pilabour_hrs)
  // tabulate carework_broad [aw=ppopwgt], summarize(pilabour_hrs)
}

foreach ccyy in $datasets_concise {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_concise=1 if (year==1992 &
       (inlist(occ1_c, 431,445))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2000 &
        (inlist(occ1_c, 3320,5130))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2002 &
        (inlist(occ1_c, 3320,5130))
      )
      ;
   #delimit cr

  replace carework_concise=0 if carework_concise==.

  gen pilabour_hrs = gross1 * hours1 * weeks

  gen wage = pilabour / (weeks * hours1)

  tabulate carework_concise [aw=ppopwgt], summarize(wage)

  // tabulate carework_concise sex [aw=ppopwgt]
  // tabulate carework_concise [aw=ppopwgt], summarize(pilabour)
  // tabulate carework_concise, summarize(pilabour_hrs)
  // tabulate carework_concise [aw=ppopwgt], summarize(pilabour_hrs)
}
