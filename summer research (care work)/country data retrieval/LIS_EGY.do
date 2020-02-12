global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "eg12"

global datasets_concise "eg12"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2012 &
       (
         (inlist(ind1_c, 8411,8422,8423,8510,8521,8522,8530,8549,8610,8620,8690,8720,8730,8790,8810,8890,9101,9102,9491,9603,9609,9700))
       & // and
         (inlist(occ1_c, 2221,2222,2224,2230,2310,2320,2331,2332,2340,2351,2359,2432,2446,2460,3221,3222,3223,3224,3225,3226,3228,3231,3310,3330,3450,3480,5131,5132,5139,5149,5162,9131))
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
     gen carework_concise=1 if (year==2012 &
       (inlist(occ1_c, 2332,2446,5131,5132,5139))
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
