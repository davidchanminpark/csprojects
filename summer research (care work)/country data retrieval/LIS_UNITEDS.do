global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "us74 us79 us86 us91 us94 us97 us00 us04 us07 us10 us13"

global datasets_concise "us74 us79 us86 us91 us94 us97 us00 us04 us07 us10 us13"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1974 &
       (
         (inlist(ind1_c, 747,769,809,828,829,837,838,839,847,848,857,858,859,867,869,877,878,879,887,917,927,937))
       & // and
         (inlist(occ1_c, 32,61,62,63,64,65,75,76,81,84,86,90,93,100,101,102,103,104,105,110,111,112,113,114,115,116,120,121,122,123,124,125,126,130,132,133,134,135,140,141,142,143,144,145,902,921,922,925,926,942,954,964,980,984))
       )
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1979 &
        (
          (inlist(ind1_c, 747,769,809,828,829,837,838,839,847,848,857,858,859,867,869,877,878,879,887,917,927,937))
        & // and
          (inlist(occ1_c, 32,61,62,63,64,65,75,76,81,84,86,90,93,100,101,102,103,104,105,110,111,112,113,114,115,116,120,121,122,123,124,125,126,130,132,133,134,135,140,141,142,143,144,145,902,921,922,925,926,942,954,964,980,984))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1986 &
        (
          (inlist(ind1_c, 741,761,771,781,791,802,812,820,821,822,830,831,832,840,842,850,851,852,860,861,862,870,871,872,880,881))
        & // and
          (inlist(occ1_c, 84,85,87,88,89,95,96,97,98,99,103,104,105,106,113,114,115,116,117,118,119,123,124,125,126,127,128,129,133,134,135,136,137,138,139,143,144,145,146,147,148,149,153,154,155,156,157,158,159,163,164,165,167,174,175,176,177,204,207,387,405,406,407,418,445,446,447,449,465,466,467,468,469,484))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1991 &
        (
          (inlist(ind1_c, 740,761,771,781,791,810,812,820,821,822,830,831,832,840,842,850,851,852,860,861,862,863,870,871,872,880,881))
        & // and
          (inlist(occ1_c, 84,85,87,88,89,95,96,97,98,99,103,104,105,106,113,114,115,116,117,118,119,123,124,125,126,127,128,129,133,134,135,136,137,138,139,143,144,145,146,147,148,149,153,154,155,156,157,158,159,163,164,165,167,174,175,176,177,204,207,387,405,406,407,418,445,446,447,449,465,466,467,468,469,484))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1994 &
        (
          (inlist(ind1_c, 740,761,771,781,791,810,812,820,821,822,830,831,832,840,842,850,851,852,860,861,862,863,870,871,872,880,881))
        & // and
          (inlist(occ1_c, 84,85,87,88,89,95,96,97,98,99,103,104,105,106,113,114,115,116,117,118,119,123,124,125,126,127,128,129,133,134,135,136,137,138,139,143,144,145,146,147,148,149,153,154,155,156,157,158,159,163,164,165,167,174,175,176,177,204,207,387,405,406,407,418,445,446,447,449,465,466,467,468,469,484))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1997 &
        (
          (inlist(ind1_c, 740,761,771,781,791,810,812,820,821,822,830,831,832,840,842,850,851,852,860,861,862,863,870,871,872,880,881))
        & // and
          (inlist(occ1_c, 84,85,87,88,89,95,96,97,98,99,103,104,105,106,113,114,115,116,117,118,119,123,124,125,126,127,128,129,133,134,135,136,137,138,139,143,144,145,146,147,148,149,153,154,155,156,157,158,159,163,164,165,167,174,175,176,177,204,207,387,405,406,407,418,445,446,447,449,465,466,467,468,469,484))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2000 &
        (
          (inlist(ind1_c, 740,761,771,781,791,810,812,820,821,822,830,831,832,840,842,850,851,852,860,861,862,863,870,871,872,880,881))
        & // and
          (inlist(occ1_c, 84,85,87,88,89,95,96,97,98,99,103,104,105,106,113,114,115,116,117,118,119,123,124,125,126,127,128,129,133,134,135,136,137,138,139,143,144,145,146,147,148,149,153,154,155,156,157,158,159,163,164,165,167,174,175,176,177,204,207,387,405,406,407,418,445,446,447,449,465,466,467,468,469,484))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2004 &
        (
          (inlist(ind1_c, 7680,7780,7860,7870,7880,7890,7970,7980,7990,8070,8080,8090,8170,8180,8190,8270,8290,8370,8380,8390,8470,8570,9080,9090,9160,9290,9470))
        & // and
          (inlist(occ1_c, 1820,2000,2010,2020,2040,2050,2060,2200,2300,2310,2320,2330,2340,2400,2430,2540,2550,3000,3010,3030,3040,3050,3060,3110,3120,3130,3140,3150,3160,3200,3210,3220,3230,3240,3310,3500,3520,3540,3600,3610,3620,3630,3640,3650,3820,3850,3910,4230,4460,4600,4610,4650))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 7680,7780,7860,7870,7880,7890,7970,7980,7990,8070,8080,8090,8170,8180,8190,8270,8290,8370,8380,8390,8470,8570,9080,9090,9160,9290,9470))
        & // and
          (inlist(occ1_c, 1820,2000,2010,2020,2040,2050,2060,2200,2300,2310,2320,2330,2340,2400,2430,2540,2550,3000,3010,3030,3040,3050,3060,3110,3120,3130,3140,3150,3160,3200,3210,3220,3230,3240,3310,3500,3520,3540,3600,3610,3620,3630,3640,3650,3820,3850,3910,4230,4460,4600,4610,4650))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 7680,7780,7860,7870,7880,7890,7970,7980,7990,8070,8080,8090,8170,8180,8190,8270,8290,8370,8380,8390,8470,8570,9080,9090,9160,9290,9470))
        & // and
          (inlist(occ1_c, 1820,2000,2010,2040,2050,2060,2200,2300,2310,2320,2330,2340,2400,2430,2540,2550,3000,3010,3030,3040,3050,3060,3110,3120,3130,3140,3150,3160,3200,3210,3220,3230,3245,3310,3500,3520,3540,3600,3610,3620,3630,3640,3645,3820,3850,3910,4230,4460,4600,4610,4650))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 7680,7780,7860,7870,7880,7890,7970,7980,7990,8070,8080,8090,8170,8180,8190,8270,8290,8370,8380,8390,8470,8570,9080,9090,9160,9290,9470))
        & // and
          (inlist(occ1_c, 1820,2000,2010,2040,2050,2060,2200,2300,2310,2320,2330,2340,2400,2430,2540,2550,3000,3010,3030,3040,3050,3060,3110,3120,3130,3140,3150,3160,3200,3210,3220,3230,3245,3310,3500,3520,3540,3600,3610,3620,3630,3640,3645,3820,3850,3910,4230,4460,4600,4610,4650))
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
     gen carework_concise=1 if (year==1974 &
       (inlist(occ1_c, 100,143,942,954,980))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1979 &
        (inlist(occ1_c, 100,143,942,954,980))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1986 &
        (inlist(occ1_c, 155,174,406,465,466,467,468,484))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1991 &
        (inlist(occ1_c, 155,174,406,465,466,467,468,484))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1994 &
        (inlist(occ1_c, 155,174,406,465,466,467,468,484))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==1997 &
        (inlist(occ1_c, 155,174,406,465,466,467,468,484))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2000 &
        (inlist(occ1_c, 155,174,406,465,466,467,468,484))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2004 &
        (inlist(occ1_c, 2010,2300,4600,4610))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2007 &
        (inlist(occ1_c, 2010,2300,4600,4610))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2010 &
        (inlist(occ1_c, 2010,2300,4600,4610))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(occ1_c, 2010,2300,4600,4610))
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
