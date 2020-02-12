global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "cl90 cl92 cl94 cl96 cl98 cl00 cl03 cl06 cl09 cl11 cl13 cl15"

global datasets_concise "cl92 cl94 cl96 cl98 cl00 cl03 cl06 cl09 cl11 cl13 cl15"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1990 &
        (inlist(ind1_c, 62,63,71,72,73))
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1992 &
        (
          (inlist(ind1_c, 910,931,933,934,939,940,942,950,953,959))
        & // and
          (inlist(occ1_c, 222,223,230,231,232,233,234,235,243,246,322,323,331,332,333,334,345,346,348,513,514,516,913))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1994 &
        (
          (inlist(ind1_c, 910,931,933,934,939,940,942,950,953,959))
        & // and
          (inlist(occ1_c, 222,223,230,231,232,233,234,235,243,246,322,323,331,332,333,334,345,346,348,513,514,516,913))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1996 &
        (
          (inlist(ind1_c, 910,931,933,934,939,940,942,950,953,959))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2331,2332,2340,2359,2432,2445,2446,2460,3220,3221,3223,3224,3225,3226,3228,3229,3231,3232,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5139,5162,5169,9130,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1998 &
        (
          (inlist(ind1_c, 9100,9310,9331,9340,9391,9399,9420,9530,9599))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2331,2332,2340,2359,2432,2445,2446,2460,3220,3221,3223,3224,3225,3226,3228,3229,3231,3232,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5139,5162,5169,9130,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2000 &
        (
          (inlist(ind1_c, 9100,9310,9331,9340,9391,9399,9420,9530,9599))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2331,2332,2340,2359,2432,2445,2446,2460,3220,3221,3223,3224,3225,3226,3228,3229,3231,3232,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5139,5162,5169,9130,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2003 &
        (
          (inlist(ind1_c, 9100,9310,9331,9340,9391,9399,9420,9530,9599))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2331,2332,2340,2359,2432,2445,2446,2460,3220,3221,3223,3224,3225,3226,3228,3229,3231,3232,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5139,5162,5169,9130,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2006 &
        (
          (inlist(ind1_c, 9100,9310,9331,9340,9391,9399,9420,9530,9599))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2331,2332,2340,2359,2432,2445,2446,2460,3220,3221,3223,3224,3225,3226,3228,3229,3231,3232,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5139,5162,5169,9130,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2009 &
        (
          (inlist(ind1_c, 9100,9310,9331,9340,9391,9399,9420,9530,9599))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2331,2332,2340,2359,2432,2445,2446,2460,3220,3221,3223,3224,3225,3226,3228,3229,3231,3232,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5139,5162,5169,9130,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2011 &
        (
          (inlist(ind1_c, 7522,7523,7530,8010,8021,8022,8030,8090,8511,8512,8519,8531,8532,9191,9231,9232,9241,9249,9303,9500))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2331,2332,2340,2359,2432,2445,2446,2460,3220,3221,3223,3224,3225,3226,3228,3229,3231,3232,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5139,5149,5162,5169,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 7522,7523,7530,8010,8021,8022,8030,8090,8511,8512,8519,8531,8532,9191,9231,9232,9241,9249,9303,9500))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2331,2332,2340,2359,2432,2445,2446,2460,3220,3221,3223,3224,3225,3226,3228,3229,3231,3232,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5139,5149,5162,5169,9131))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2015 &
        (
          (inlist(ind1_c, 7522,7523,7530,8010,8021,8022,8030,8090,8511,8512,8519,8531,8532,9191,9231,9232,9241,9249,9303,9500))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2331,2332,2340,2359,2432,2445,2446,2460,3220,3221,3223,3224,3225,3226,3228,3229,3231,3232,3310,3320,3330,3340,3450,3460,3480,5121,5131,5132,5133,5139,5149,5162,5169,9131))
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
       (inlist(occ1_c, 332,346))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1994 &
        (inlist(occ1_c, 332,346))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1996 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1998 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2000 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2003 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2006 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2009 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2011 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139,5149))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139,5149))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2015 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5133,5139,5149))
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
