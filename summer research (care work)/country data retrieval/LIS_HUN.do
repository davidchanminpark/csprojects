global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "hu91 hu99 hu05 hu07 hu09 hu12 hu15"

global datasets_concise "hu99 hu05 hu07 hu09 hu12 hu15"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1991 &
       (
         (inlist(ind1_c, 6,9,11,12,14))
       & // and
         (inlist(occ1_c, 610,611,620,630,640,710,711,1310,1320,1321,1330,1340,1390,1393,1410,5820,5821))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1999 &
        (
          (inlist(ind1_c, 1,12,14,17,19,20))
        & // and
          (inlist(occ1_c, 2211,2212,2215,2223,2229,2230,2321,2322,2410,2421,2422,2431,2432,2441,2443,2449,2499,2611,3211,3212,3221,3222,3231,3232,3233,3234,3242,3313,3315,3319,3320,3412,3415,3419,3525,5320,5354,5361,7446))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2005 &
        (
          (inlist(ind1_c, 1,12,14,17,19,20))
        & // and
          (inlist(occ1_c, 2211,2212,2223,2224,2225,2230,2322,2410,2421,2422,2431,2432,2441,2499,2611,3211,3212,3221,3222,3231,3232,3233,3234,3312,3313,3314,3315,3412,3419,3525,5320,5354,5361,7446))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 1,12,14,17,19,20))
        & // and
          (inlist(occ1_c, 2211,2212,2213,2214,2215,2223,2225,2321,2410,2421,2431,2432,2441,2499,2611,3211,3212,3221,3222,3231,3232,3233,3234,3239,3242,3244,3313,3314,3315,3412,3419,5320,5354,5361,7446))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2009 &
        (
          (inlist(ind1_c, 1,12,14,17,19,20))
        & // and
          (inlist(occ1_c, 2211,2212,2213,2215,2224,2229,2321,2410,2421,2431,2432,2441,2499,2611,3211,3212,3221,3222,3231,3232,3233,3234,3239,3242,3244,3311,3312,3313,3315,3412,3419,5320,5354,5361,7446))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2012 &
        (
          (inlist(ind1_c, 1,12,14,17,19,20))
        & // and
          (inlist(occ1_c, 2211,2212,2213,2214,2223,2224,2225,2227,2229,2232,2312,2410,2421,2422,2431,2432,2499,2628,2711,3311,3321,3325,3333,5221,5222,5251))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2015 &
        (
          (inlist(ind1_c, 1,12,14,17,19,20))
        & // and
          (inlist(occ1_c, 2211,2212,2213,2215,2223,2224,2225,2229,2230,2312,2321,2410,2421,2422,2431,2432,2499,3211,3212,3221,3222,3231,3232,3233,3234,3239,3242,3248,3313,3314,3730,5319,5320,5330,5361))
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
     gen carework_concise=1 if (year==1999 &
       (inlist(occ1_c, 2432,3221,3313,3412))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2005 &
        (inlist(occ1_c, 2432,3221,3313,3314,3412))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2007 &
        (inlist(occ1_c, 2432,3221,3313,3412))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2009 &
        (inlist(occ1_c, 2432,3221,3313,3412))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2012 &
        (inlist(occ1_c, 2432,5221))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2015 &
        (inlist(occ1_c, 2432,3221,3313,3314))
      )
      ;
   #delimit cr

  replace carework_concise=0 if carework_concise==.

  gen pilabour_hrs = gross1 * hours1 * weeks

  tabulate carework_concise sex [aw=ppopwgt]
  tabulate carework_concise [aw=ppopwgt], summarize(pilabour)
  tabulate carework_concise, summarize(pilabour_hrs)
  tabulate carework_concise [aw=ppopwgt], summarize(pilabour_hrs)
}
