global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "ie87 ie94 ie95 ie96 ie00 ie04 ie07 ie10"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1987 &
       (
         (inlist(ind1_c, 16,17,18,19,20))
       & // and
         (inlist(occ1_c, 20))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1994 &
        (
          (inlist(ind1_c, 750,800,850,920,930,950))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1995 &
        (
          (inlist(ind1_c, 750,800,850,920,930,950))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1996 &
        (
          (inlist(ind1_c, 750,800,850,920,930,950))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2000 &
        (
          (inlist(ind1_c, 12750,13800,14850,15920,15930,16950))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2004 &
        (
          (inlist(ind1_c, 12750,13800,14850,15920,15930,16950))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100,5300))
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
