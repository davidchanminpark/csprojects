global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "pl86 pl92 pl95 pl99 pl04 pl07 pl10 pl13 pl16"

global datasets_concise ""

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1986 &
       (inlist(ind1_c, 74,79,85))
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1992 &
        (
          (inlist(ind1_c, 70,74,79,85))
        & // and
          (inlist(occ1_c, 10,14,16,17))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1995 &
          (inlist(ind1_c, 40,80,85,95))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1999 &
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
          (inlist(ind1_c, 80,84,85,86,87,88,91,96,97))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,96,97))
        & // and
          (inlist(occ1_c, 22,23,32,51,53,54))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2016 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,96,97))
        & // and
          (inlist(occ1_c, 22,23,32,51,53,54))
        )
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
