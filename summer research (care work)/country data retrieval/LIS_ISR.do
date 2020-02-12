global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "il79 il86 il92 il97 il01 il05 il07 il10 il12 il14 il16"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1979 &
       (
         (inlist(ind1_c, 9,10))
       & // and
         (inlist(occ1_c, 6))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1986 &
        (
          (inlist(ind1_c, 8,9))
        & // and
          (inlist(occ1_c, 6))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1992 &
        (
          (inlist(ind1_c, 8,9))
        & // and
          (inlist(occ1_c, 6))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1997 &
        (inlist(ind1_c, 12,13,14))
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2001 &
        (inlist(ind1_c, 12,13,14))
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2005 &
        (inlist(ind1_c, 12,13,14))
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 75,77,78,79,80,85,86,91,92,93,94,95,97))
        & // and
          (inlist(occ1_c, 3,7,8,9,15,19,45,46,91))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 75,77,78,79,80,85,86,91,92,93,94,95,97))
        & // and
          (inlist(occ1_c, 3,7,8,9,15,19,45,46,91))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2012 &
        (
          (inlist(ind1_c, 75,77,78,79,80,85,86,91,92,93,94,95,97))
        & // and
          (inlist(occ1_c, 3,7,8,9,15,19,45,46,91))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2014 &
          (inlist(ind1_c, 16,19))
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2016 &
        (inlist(ind1_c, 16,19))
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
