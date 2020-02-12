global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "dk87 dk92 dk95 dk00 dk04 dk07 dk10 dk13"

global datasets_concise "dk92 dk04 dk07 dk10 dk13"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1987 &
       (
         (inlist(ind1_c, 9101,9104,9310,9331,9340,9391,9399,9420,9490,9520,9599))
       & // and
         (inlist(occ1_c, 206,207,213,214,215,253,259))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1992 &
        (
          (inlist(ind1_c, 9101,9104,9310,9331,9340,9391,9399,9420,9490,9520,9599))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2230,2300,2310,2320,2331,2340,2359,2431,2432,2445,2446,2460,3220,3223,3224,3225,3226,3228,3229,3231,3300,3310,3320,3330,3340,3450,3460,5131,5132,5133,5139,5162))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1995 &
          (inlist(ind1_c, 12752,12753,13801,13802,13803,13804,14851,14853,15925,15930,16950))
        )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2000 &
        (inlist(ind1_c, 12752,12753,13801,13802,13803,13804,14851,14853,15925,15930,16950))
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2004 &
        (
          (inlist(ind1_c, 12751,12752,12753,13801,13802,13803,13804,14851,14853,15925,15927,15930,16950))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2300,2310,2320,2330,2331,2340,2359,2431,2432,2445,2446,2460,3220,3223,3224,3225,3226,3228,3229,3231,3300,3310,3320,3330,3340,3450,3460,5121,5131,5132,5133,5139,5140,5149,5162))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 7460,7511,7522,7524,7530,8010,8021,8022,8030,8041,8042,8511,8512,8513,8514,8531,8532,9251,9252,9262,9272,9303,9305,9500))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2300,2310,2320,2330,2331,2340,2359,2431,2432,2445,2446,2460,3220,3223,3224,3225,3226,3228,3229,3231,3300,3310,3320,3330,3340,3450,3460,5121,5130,5131,5132,5133,5139,5140,5149,5162))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 8010,8030,8422,8424,8430,8520,8531,8532,8541,8542,8551,8552,8553,8559,8560,8610,8621,8622,8623,8690,8710,8720,8730,8790,8810,8891,8899,9101,9102,9319,9491,9603,9609,9700))
        & // and
          (inlist(occ1_c, 2200,2211,2212,2220,2221,2222,2230,2260,2261,2262,2263,2264,2265,2266,2267,2269,2300,2310,2320,2330,2340,2341,2342,2350,2351,2352,2353,2354,2355,2356,2359,2621,2622,2634,2635,2636,3213,3214,3221,3222,3240,3251,3252,3254,3255,3256,3259,3355,3412,3413,5152,5160,5169,5311,5312,5320,5321,5322,5329,5412))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 8010,8030,8422,8424,8430,8520,8531,8532,8541,8542,8551,8552,8553,8559,8560,8610,8621,8622,8623,8690,8710,8720,8730,8790,8810,8891,8899,9101,9102,9319,9491,9603,9609,9700))
        & // and
          (inlist(occ1_c, 2200,2211,2212,2220,2221,2222,2240,2260,2261,2262,2263,2264,2265,2266,2267,2269,2300,2310,2320,2330,2340,2341,2350,2351,2352,2353,2354,2355,2356,2359,2621,2622,2634,2635,2636,3213,3214,3221,3222,3240,3251,3252,3253,3254,3255,3256,3259,3355,3412,3413,5152,5160,5169,5311,5312,5320,5321,5322,5329,5412))
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
     gen carework_concise=1 if (year==1992 &
       (inlist(occ1_c, 2446,3320,3460,5131,5132,5133,5139))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2004 &
        (inlist(occ1_c, 2446,3320,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2007 &
        (inlist(occ1_c, 2446,3320,3460,5130,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2010 &
        (inlist(occ1_c, 2340,2342,2635,3412,5311,5320,5322,5329))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(occ1_c, 2340,2635,3412,5311,5320,5322,5329))
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
