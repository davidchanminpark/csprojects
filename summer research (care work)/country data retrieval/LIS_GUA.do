global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "gt06 gt11 gt14"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2006 &
       (
         (inlist(ind1_c, 12750,13800,14850,15920,15930,16950))
       & // and
         (inlist(occ1_c, 2200,2300,3200,3300,5100))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2011 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,93,96,97))
        & // and
          (inlist(occ1_c, 22,23,32,33))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2014 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,93,96,97))
        & // and
          (inlist(occ1_c, 22,23,32,51,53))
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
