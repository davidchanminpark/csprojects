global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "br06 br09 br11 br13"

global datasets_concise "br06 br09 br11 br13"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2006 &
       (
         (inlist(ind1_c, 75015,75016,75017,75020,80011,80012,80090,85011,85012,85013,85030,91091,90192,92030,92040,93030,93092,95000))
       & // and
         (inlist(occ1_c, 2231,2232,2234,2235,2236,2237,2311,2312,2313,2321,2330,2340,2391,2392,2394,2423,2516,2631,3221,3223,3224,3251,3311,3312,3313,3321,3322,3331,5121,5151,5152,5162,5172,5173,5174,5199))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2009 &
        (
          (inlist(ind1_c, 75015,75016,75017,75020,80011,80012,80090,85011,85012,85013,85030,91091,90192,92030,92040,93030,93092,95000))
        & // and
          (inlist(occ1_c, 2231,2232,2234,2235,2236,2237,2311,2312,2313,2321,2330,2340,2391,2392,2394,2423,2516,2631,3221,3223,3224,3251,3311,3312,3313,3321,3322,3331,5121,5151,5152,5162,5172,5173,5174,5199))
        )
      )
        ;
     #delimit cr

     #delimit ;
       replace carework_broad=1 if (year==2011 &
         (
           (inlist(ind1_c, 75015,75016,75017,75020,80011,80012,80090,85011,85012,85013,85030,91091,90192,92030,92040,93030,93092,95000))
         & // and
           (inlist(occ1_c, 2231,2232,2234,2235,2236,2237,2311,2312,2313,2321,2330,2340,2391,2392,2394,2423,2516,2631,3221,3223,3224,3251,3311,3312,3313,3321,3322,3331,5121,5151,5152,5162,5172,5173,5174,5199))
         )
       )
         ;
      #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 75015,75016,75017,75020,80011,80012,80090,85011,85012,85013,85030,91091,90192,92030,92040,93030,93092,95000))
        & // and
          (inlist(occ1_c, 2231,2232,2234,2235,2236,2237,2311,2312,2313,2321,2330,2340,2391,2392,2394,2423,2516,2631,3221,3223,3224,3251,3311,3312,3313,3321,3322,3331,5121,5151,5152,5162,5172,5173,5174,5199))
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
     gen carework_concise=1 if (year==2006 &
       (inlist(occ1_c, 2311,2516,3311,5162))
     )
     ;
    #delimit cr

    #delimit ;
      replace carework_concise=1 if (year==2009 &
        (inlist(occ1_c, 2311,2516,3311,5162))
      )
      ;
     #delimit cr

     #delimit ;
       replace carework_concise=1 if (year==2011 &
         (inlist(occ1_c, 2311,2516,3311,5162))
       )
       ;
      #delimit cr

      #delimit ;
        replace carework_concise=1 if (year==2013 &
          (inlist(occ1_c, 2311,2516,3311,5162))
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
