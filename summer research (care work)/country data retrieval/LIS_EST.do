global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "ee00 ee07 ee10 ee13"

global datasets_concise "ee00 ee07 ee13"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2000 &
       (
         (inlist(ind1_c, 12750,13800,14850,15920,15930,16950))
       & // and
         (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2320,2331,2332,2340,2351,2359,2431,2432,2446,2460,3221,3222,3225,3226,3228,3229,3231,3232,3241,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5149,5162))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 75,80,85,92,93))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2320,2331,2332,2340,2351,2359,2431,2432,2445,2446,2460,3221,3222,3225,3226,3228,3229,3231,3232,3241,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5149,5162))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 80,80,84,85,86,87,88,91,96))
        & // and
          (inlist(occ1_c, 2200,2300,3200,3300,5100))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,96))
        & // and
          (inlist(occ1_c, 2211,2212,2221,2261,2262,2264,2266,2300,2310,2320,2330,2341,2342,2351,2352,2353,2354,2355,2356,2359,2621,2622,2634,2635,2636,3221,3222,3251,3355,3412,5100,5311,5321,5322,5329,5412))
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
     gen carework_concise=1 if (year==2000 &
       (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2007 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(occ1_c, 2342,2635,3412,5311,5322,5329))
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
