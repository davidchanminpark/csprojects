global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "ru00 ru04 ru07 ru10 ru11 ru13 ru14 ru15 ru16"

global datasets_concise "ru00 ru04 ru07 ru10"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2000 &
         (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2320,2331,2332,2340,2359,2431,2445,2446,3221,3226,3231,3232,3320,3340,3450,3460,3480,5113,5131,5132,5139,5162,5169,9130))
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2004 &
        (
          (inlist(ind1_c, 9,10,11,12,13,16))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2230,2310,2320,2331,2332,2340,2359,2431,2432,2445,2446,3221,3225,3226,3229,3231,3232,3320,3340,3450,3460,3480,5121,5131,5132,5139,5162,9130))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 9,10,11,12,13,18))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2320,2331,2332,2340,2359,2431,2432,2445,2446,3221,3225,3226,3229,3231,3232,3320,3330,3450,3460,3480,5131,5132,5162,9130))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 9,10,11,12,13,18))
        & // and
          (inlist(occ1_c, 2221,2222,2224,2229,2230,2310,2320,2331,2332,2340,2359,2431,2432,2445,2446,3221,3226,3229,3231,3232,3320,3340,3450,3460,3480,5131,5132,5162,9130))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2011 &
          (inlist(ind1_c, 7,8))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
          (inlist(ind1_c, 7,8))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2014 &
          (inlist(ind1_c, 7,8))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2015 &
          (inlist(ind1_c, 7,8))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2016 &
          (inlist(ind1_c, 7,8))
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
     gen carework_concise=1 if (year==2000 &
       (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5139))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2004 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2007 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132,5139))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2010 &
        (inlist(occ1_c, 2332,2446,3320,3460,5131,5132))
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
