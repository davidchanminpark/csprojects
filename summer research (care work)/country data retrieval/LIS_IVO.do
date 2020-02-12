global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "ci02 ci08 ci15"

global datasets_concise "ci02 ci08 ci15"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2002 &
       (
         (inlist(ind1_c, 39000,39001,39002,40000,41000,41001,41003,42000,42002,42003,42004,42005))
       & // and
         (inlist(occ1_c, 103,104,105,107,108,109,110,111,113,116,117,137,139,150,152,154,157,181,182,199,200,203,204,283,284,285,286,287,292,293,295,298,299,300,337,417,385,421,525,526))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2008 &
        (
          (inlist(ind1_c, 391,392,400,411,413,422,423,424,425))
        & // and
          (inlist(occ1_c, 103,104,107,108,109,110,111,112,113,116,117,118,135,137,138,139,154,156,157,182,183,197,198,199,201,204,205,284,285,286,287,293,294,299,301,339,387,388,426))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2015 &
        (
          (inlist(ind1_c, 74320,74330,75101,75102,75202,75204,75300,80101,80102,80210,80300,80400,85110,85121,85122,85142,85300,91310,93030,93040,95000))
        & // and
          (inlist(occ1_c, 103,104,105,107,108,109,110,111,113,116,117,135,154,155,156,157,182,183,198,201,205,284,285,288,293,294,299,301,387,388,422,426,533))
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
     gen carework_concise=1 if (year==2002 &
       (inlist(occ1_c, 150,152,154,157,284,285,286))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2008 &
        (inlist(occ1_c, 154,156,157,285,286,287))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2015 &
        (inlist(occ1_c, 154,155,156,157,285))
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
