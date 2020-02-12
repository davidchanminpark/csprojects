global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "in04 in11"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2004 &
       (
         (inlist(ind1_c, 90,92,93,94,95,96,99))
       & // and
         (inlist(occ1_c, 7,8,15,51))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2011 &
        (
          (inlist(ind1_c, 90,92,93,94,95,96,99))
        & // and
          (inlist(occ1_c, 7,8,15,51))
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
