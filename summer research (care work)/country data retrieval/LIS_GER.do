global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "de84 de87 de89 de91 de94 de95 de98 de00 de01 de02 de03 de04 de05 de06 de07 de08 de09 de10 de11 de12 de13 de14 de15"

global datasets_concise "de84 de87 de89 de91 de94 de95 de98 de00 de01 de02 de03 de04 de05 de06 de07 de08 de09 de10 de11 de12 de13 de14 de15"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1984 &
       (
         (inlist(ind1_c, 75,80,85,92,93,95))
       & // and
         (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3224,3226,3228,3229,3231,3320,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
       )
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1987 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3224,3226,3228,3229,3231,3320,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1989 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3223,3224,3226,3228,3229,3231,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1991 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3224,3226,3228,3229,3231,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1994 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1995 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3224,3226,3228,3229,3231,3232,3320,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1998 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2000 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2001 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2002 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2003 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2004 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2005 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2006 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2008 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2009 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2011 &
        (
          (inlist(ind1_c, 75,80,85,92,93,95))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2310,2320,2331,2340,2359,2432,2445,2446,2460,3222,3223,3224,3226,3228,3229,3231,3232,3320,3330,3340,3450,3460,3480,5131,5132,5133,5139,5149,5162,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2012 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,93,96,97))
        & // and
          (inlist(occ1_c, 2211,2212,2221,2222,2261,2262,2264,2265,2266,2267,2269,2310,2320,2330,2341,2342,2351,2352,2353,2354,2355,2356,2359,2622,2634,2635,2636,3221,3222,3230,3251,3255,3256,3259,3355,3412,3413,5152,5311,5312,5321,5322,5329,5412))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,93,96,97))
        & // and
          (inlist(occ1_c, 2211,2212,2221,2222,2261,2262,2264,2265,2266,2267,2269,2310,2320,2330,2341,2342,2351,2352,2353,2354,2355,2356,2359,2622,2634,2635,2636,3221,3222,3230,3251,3255,3256,3259,3355,3412,3413,5152,5311,5312,5321,5322,5329,5412))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2014 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,93,96,97))
        & // and
          (inlist(occ1_c, 2211,2212,2222,2261,2262,2264,2265,2266,2267,2269,2310,2320,2330,2341,2342,2351,2352,2353,2354,2355,2356,2359,2622,2634,2635,2636,3221,3222,3251,3255,3256,3259,3355,3412,3413,5152,5311,5312,5321,5322,5329,5412))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2015 &
        (
          (inlist(ind1_c, 80,84,85,86,87,88,91,93,96,97))
        & // and
          (inlist(occ1_c, 2211,2212,2221,2222,2261,2262,2264,2265,2266,2267,2269,2310,2320,2330,2341,2351,2352,2353,2354,2355,2356,2359,2622,2634,2635,2636,3221,3222,3251,3255,3256,3259,3355,3412,3413,5152,5311,5312,5321,5322,5329,5412))
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
     gen carework_concise=1 if (year==1984 &
       (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1987 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1989 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1991 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1994 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1995 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1998 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2000 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2001 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2002 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2003 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2004 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2005 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2006 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2007 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2008 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2009 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2010 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2011 &
        (inlist(occ1_c, 2446,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2012 &
        (inlist(occ1_c, 2342,2635,3412,5311,5322,5329))
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
      replace carework_concise=1 if (year==2014 &
        (inlist(occ1_c, 2342,2635,3412,5311,5322,5329))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2015 &
        (inlist(occ1_c, 2635,3412,5311,5322,5329))
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
