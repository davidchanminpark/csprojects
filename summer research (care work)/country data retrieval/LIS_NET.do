global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "nl90 nl93 nl99 nl04 nl07 nl10 nl13"

global datasets_concise "nl90 nl93 nl99"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1990 &
       (
         (inlist(ind1_c, 90,91,92,93,94,96,97,98,99))
       & // and
         (inlist(occ1_c, 61,63,67,68,69,71,72,73,74,75,76,131,132,133,134,135,141,149,191,193,541,542,551,552,593,599))
       )
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1993 &
          (inlist(occ1_c, 61,63,67,68,69,71,72,73,74,75,76,131,132,133,134,135,141,149,191,193,541,542,551,552,593,599))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1999 &
        (
          (inlist(ind1_c, 75,80,85,751,752,753,801,802,803,804,851,853))
        & // and
          (inlist(occ1_c, 292,342,372,434,485,492,495,563,572,621,622,623,625,626,631,633,634,692,693,762,763,772,825,831,833,834))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2004 &
        (
          (inlist(ind1_c, 12000,13000,14000,21567))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 9,10,11,12))
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
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 10,11,12,13))
        & // and
          (inlist(occ1_c, 2200,2300,3200,5100,5300))
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
     gen carework_concise=1 if (year==1990 &
       (inlist(occ1_c, 135,193,551))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1993 &
        (inlist(occ1_c, 135,193,551))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1999 &
        (inlist(occ1_c, 372,563,572,763,772))
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
