global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "pe04 pe07 pe10 pe13"

global datasets_concise "pe04 pe07 pe10 pe13"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2004 &
       (
         (inlist(ind1_c, 7522,7523,8010,8021,8022,8030,8090,8511,8512,8519,8520,8531,8532,9191,9249,9303,9309,9500))
       & // and
         (inlist(occ1_c, 233,235,236,238,239,241,242,243,244,245,246,247,268,269,284,343,345,346,347,348,352,353,442,531,941))
       )
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 7522,7523,8010,8021,8022,8030,8090,8511,8512,8519,8520,8531,8532,9191,9249,9303,9309,9500))
        & // and
          (inlist(occ1_c, 233,235,236,238,239,241,242,243,244,245,246,247,268,269,284,343,345,346,347,348,352,353,442,531,941))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 7522,7523,8010,8021,8022,8030,8090,8511,8512,8519,8520,8531,8532,9191,9249,9303,9309,9500))
        & // and
          (inlist(occ1_c, 233,235,236,238,239,241,242,243,244,245,246,247,268,269,284,343,345,346,347,348,352,353,442,531,941))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 7522,7523,8010,8021,8022,8030,8090,8511,8512,8519,8520,8531,8532,9191,9249,9303,9309,9500))
        & // and
          (inlist(occ1_c, 233,235,236,238,239,241,242,243,244,245,246,247,268,269,284,343,345,346,347,348,352,353,442,531,941))
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

foreach ccyy in $datasets_concise {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_concise=1 if (year==2004 &
       (inlist(occ1_c, 244,269))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2007 &
        (inlist(occ1_c, 244,269))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2010 &
        (inlist(occ1_c, 244,269))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(occ1_c, 244,269))
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
