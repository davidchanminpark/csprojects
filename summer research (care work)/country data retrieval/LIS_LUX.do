global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "lu97 lu00 lu04 lu07 lu10 lu13"

global datasets_concise "lu04 lu13"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1997 &
       (
         (inlist(ind1_c, 12,13,14,15,16))
       & // and
         (inlist(occ1_c, 2200,2300,3200,3300,5100))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2000 &
        (
          (inlist(ind1_c, 12000,13000,14000,15000,16000))
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
          (inlist(occ1_c, 2220,2230,2310,2320,2330,2350,2430,2460,3220,3230,3310,3320,3330,3340,3450,3460,3480,5130,5140,9130))
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
          (inlist(ind1_c, 80,84,85,86,87,88,91,93,96,97))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,93,96,97))
        & // and
          (inlist(occ1_c, 2210,2220,2240,2260,2310,2320,2330,2340,2350,2620,2630,3220,3250,5160,5310,5320))
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
     gen carework_concise=1 if (year==2004 &
       (inlist(occ1_c, 3320,3460,5130))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(occ1_c, 5310,5320))
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
