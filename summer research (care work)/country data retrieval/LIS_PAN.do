global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "pa07 pa10 pa13"

global datasets_concise "pa07 pa10 pa13"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==2007 &
       (
         (inlist(ind1_c, 7511,7522,7523,8010,8021,8022,8030,8090,8511,8512,8519,8531,8532,9191,9231,9303,9309,9500))
       & // and
         (inlist(occ1_c, 241,243,244,247,248,249,250,251,252,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,279,280,282,283,284,286,287,288,289,290,291,292,293,294,295,296,297,298,299,301,302,304,305,306,307,308,309,310,311,312,313,342,344,345,364,365,366,368,409,410,411,519,520,522,524,525,527,528,534,536,534,536,608,610,654,826,839,840,844,845,857,862,874,1569))
       )
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 7511,7522,7523,8010,8021,8022,8030,8090,8511,8512,8519,8531,8532,9191,9231,9303,9309,9500))
        & // and
          (inlist(occ1_c, 241,246,247,248,251,252,256,257,258,259,260,261,262,263,264,265,266,267,268,270,271,272,273,274,275,276,278,279,280,281,282,283,284,287,288,289,290,291,292,293,294,295,296,297,298,302,304,305,306,307,308,309,310,311,312,313,342,344,345,364,365,366,368,409,410,411,519,520,521,522,523,524,525,527,534,536,534,536,608,651,653,826,839,840,843,844,857,874,1569))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2013 &
        (
          (inlist(ind1_c, 8411,8422,8423,8430,8510,8521,8522,8530,8541,8542,8549,8550,8610,8620,8690,8710,8730,8790,8890,9491,9603,9609,9700))
        & // and
          (inlist(occ1_c, 2211001,2212001,2212002,2212003,2212007,2212014,2212016,2212026,2212029,2212030,2212031,2221001,2221004,2221005,2261002,2261003,2262001,2264001,2265002,2267001,2311009,2311019,2311021,2311023,2311024,2311031,2311034,2311039,2311041,2311042,2311044,2311048,2311049,2311055,2311059,2311060,2311071,2311073,2321002,2321005,2321007,2321008,2321011,2331001,2331002,2331004,2331006,2331009,2331011,2331013,2331015,2331016,2331017,2331018,2331019,2331020,2331021,2331022,2331023,2331024,2331025,231026,2331027,2331028,2331029,2331031,2331032,2331033,2331034,2331035,2341000,2341002,2342000,2342001,2342002,2351004,2352007,2352008,2353001,2354002,2355001,2359000,2359004,2359007,2359008,2634001,2634002,2634003,2635005,2636003,2636008,3213001,3221002,3251001,3255002,3256001,3355003,3412000,3413003,4411002,5113002,5152001,5153004,5211001,5211002,5211005,5211006,5221004,5222002,5222003,5222004,5229002,5312001,5312002,9111001))
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
     gen carework_concise=1 if (year==2007 &
       (inlist(occ1_c, 294,295,296,297,366,368,839,840,844))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2010 &
        (inlist(occ1_c, 294,295,296,297,366,368,839,840,843,844))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2013 &
        (inlist(occ1_c, 2635005,3412000,5153004,5211001,5211002,5211005,5211006,5221004,5222002,5222003))
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
