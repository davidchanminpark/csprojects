global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "fi87 fi91 fi95 fi00 fi04 fi07 fi10 fi13"

global datasets_concise "fi87 fi91 fi95"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1987 &
       (
         (inlist(ind1_c, 819,821,829,830,850,871,872,873,881,882,883,919,941,942,949,950,980))
       & // and
         (inlist(occ1_c, 3,4,8,10,11,12,13,15,16,17,19,93,95,99))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1991 &
        (
          (inlist(ind1_c, 819,821,829,830,850,871,872,873,881,882,883,919,941,942,949,950,980))
        & // and
          (inlist(occ1_c, 3,4,8,10,11,12,13,15,16,17,19,93,95,99))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1995 &
        (
          (inlist(ind1_c, 746,751,752,753,800,851,853,925,927,930,950))
        & // and
          (inlist(occ1_c, 3,4,8,10,11,12,13,15,16,17,19,93,95,99))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2000 &
        (
          (inlist(ind1_c, 12750,12751,12752,12753,13800,14851,14853,15925,15927,15930,16950))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2004 &
        (
          (inlist(ind1_c, 12750,12751,12752,12753,13800,14851,14853,15925,15927,15930,16950))
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

foreach ccyy in $datasets_concise {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_concise=1 if (year==1987 &
       (inlist(occ1_c, 15,16,95))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1991 &
        (inlist(occ1_c, 15,16,95))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1995 &
        (inlist(occ1_c, 15,16,95))
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
