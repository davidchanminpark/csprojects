global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "co04 co07 co10 co13"

global datasets_concise "co07 co10 co13"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2004 &
       (
         (inlist(ind1_c, 12750,13800,14850,15920,15930,16950))
       & // and
         (inlist(occ1_c, 6,13,14,52,54,58,59))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 7522,7524,7530,8011,8012,8021,8022,8030,8041,8042,8043,8044,8045,8046,8050,8060,8511,8512,8513,8514,8515,8519,8531,8532,9000,9191,9231,9232,9241,9249,9309,9500))
        & // and
          (inlist(occ1_c, 6,13,14,52,54,58,59))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 7522,7524,7530,8011,8012,8021,8022,8030,8041,8042,8043,8044,8045,8046,8050,8060,8511,8512,8513,8514,8515,8519,8531,8532,9000,9191,9231,9232,9241,9249,9309,9500))
        & // and
          (inlist(occ1_c, 6,13,14,52,54,58,59))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 7522,7524,7530,8011,8012,8021,8022,8030,8041,8042,8043,8044,8045,8046,8050,8060,8511,8512,8513,8514,8515,8519,8531,8532,9000,9191,9231,9232,9241,9249,9309,9500))
        & // and
          (inlist(occ1_c, 6,13,14,52,54,58,59))
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
     gen carework_concise=1 if (year==2007 &
       (inlist(ind1_c, 8011,8041,8042,8043,8531,8532))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2010 &
        (inlist(ind1_c, 8011,8041,8042,8043,8531,8532))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(ind1_c, 8011,8041,8042,8043,8531,8532))
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
