global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "fr84 fr89 fr94 fr00 fr05 fr10"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1984 &
       (
         (inlist(ind1_c, 82,84,85,86,87,92,93,94,95,96,97,98))
       & // and
         (inlist(occ1_c, 34,42,43,44,53,56))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1989 &
        (
          (inlist(ind1_c, 82,84,85,86,87,92,93,94,95,96,97,98))
        & // and
          (inlist(occ1_c, 34,42,43,44,53,56))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1994 &
          (inlist(occ1_c, 34,42,43,44,53,56))
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2000 &
          (inlist(occ1_c, 34,42,43,44,53,56))
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2005 &
        (
          (inlist(ind1_c, 810,820,1000,1020,1030,1040,1110,1120))
        & // and
          (inlist(occ1_c, 34,42,43,44,53,56))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 11100,11200,11210,11220,11230,12100,13400,14000,15200,15400,16000,16100,16130))
        & // and
          (inlist(occ1_c, 34,42,43,44,53,56))
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
