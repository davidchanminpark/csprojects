global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "uy04 uy07 uy10 uy13 uy16"

global datasets_concise "uy04 uy07 uy10 uy13 uy16"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2004 &
       (
         (inlist(ind1_c, 12750,13800,14850,15910,15920,15930,16950))
       & // and
         (inlist(occ1_c, 2220,2230,2310,2320,2330,2340,2350,2430,2460,3220,3230,3310,3320,3330,3450,3460,3480,5130,5140))
       )
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 7492,7500,7510,7520,7530,8010,8020,8030,8090,8500,8510,8511,8512,8513,8519,8530,9191,9230,9303,9309,9500))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2311,2312,2321,2322,2331,2332,2340,2351,2352,2359,2431,2432,2445,2446,3222,3229,3231,3232,3310,3320,3330,3340,3450,3460,5131,5132,5133,5139,5162,9130,9131))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 7492,7510,7520,7530,8010,8020,8030,8090,8511,8512,8513,8519,8530,9191,9230,9303,9309,9500))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2311,2312,2321,2322,2331,2332,2340,2351,2352,2359,2431,2432,2445,2446,3221,3222,3226,3229,3231,3232,3310,3320,3330,3340,3450,3460,5131,5132,5133,5139,5162,9131))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 8010,8411,8422,8423,8430,8510,8521,8522,8530,8541,8542,8549,8550,8610,8620,8690,8710,8720,8730,8790,8810,8890,9000,9101,9102,9491,9603,9609,9700))
        & // and
          (inlist(occ1_c, 2211,2212,2221,2222,2261,2262,2264,2265,2266,2269,2310,2320,2330,2341,2342,2351,2352,2353,2354,2355,2356,2359,2621,2622,2634,2635,2636,3221,3251,3253,3254,3255,3256,3412,3413,5152,5169,5311,5312,5321,5322,5329,5412,9111))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2016 &
        (
          (inlist(ind1_c, 8010,8411,8422,8423,8430,8510,8521,8522,8530,8541,8542,8549,8550,8610,8620,8690,8710,8720,8730,8790,8810,8890,9000,9101,9102,9491,9603,9609,9700))
        & // and
          (inlist(occ1_c, 2211,2212,2221,2222,2261,2262,2264,2265,2266,2269,2310,2320,2330,2341,2342,2351,2352,2353,2354,2355,2356,2359,2621,2622,2634,2635,2636,3221,3251,3253,3254,3255,3256,3412,3413,5152,5169,5311,5312,5321,5322,5329,5412,9111))
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
       (inlist(occ1_c, 3320,3460,5130))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2007 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2010 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(occ1_c, 2342,2635,3412,5311,5322,5329))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2016 &
        (inlist(occ1_c, 2342,2635,3412,5311,5322,5329))
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
