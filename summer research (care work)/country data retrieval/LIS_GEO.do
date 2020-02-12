global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "ge10 ge13 ge16"

global datasets_concise "ge10 ge13 ge16"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2010 &
       (
         (inlist(ind1_c, 7460,7511,7522,7524,7530,8010,8021,8022,8030,8042,8511,8512,8513,8514,8531,8532,9131,9251,9252,9272,9303,9305,9500))
       & // and
         (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2320,2340,2351,2359,2432,2445,2446,2460,3222,3228,3229,3231,3320,3310,3330,3340,3450,3480,5131,5132,5133,5139,5140,5149,5162))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 7460,7511,7522,7524,7530,8010,8021,8022,8030,8042,8511,8512,8513,8514,8531,8532,9131,9251,9252,9272,9303,9305,9500))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2320,2340,2432,2460,3225,3226,3228,3229,3231,3310,3320,3330,3450,3480,5131,5132,5133,5139,5140,5149,5162))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2016 &
        (
          (inlist(ind1_c, 7460,7511,7522,7524,8010,8021,8022,8030,8042,8511,8512,8513,8514,8531,8532,9131,9251,9252,9272,9303,9500))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2310,2320,2432,2445,2460,3224,3225,3228,3229,3231,3232,3310,3320,3450,3460,3480,5131,5132,5133,5140,5162))
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
     gen carework_concise=1 if (year==2010 &
       (inlist(occ1_c, 2446,3320,5131,5132,5133,5139))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(occ1_c, 2446,3320,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2016 &
        (inlist(occ1_c, 2446,3320,3460,5131,5132,5133,5139))
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
