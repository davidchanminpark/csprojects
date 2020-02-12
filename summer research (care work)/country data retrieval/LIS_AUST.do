global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 hours1 gross1 weeks"

global datasets_broad "at87 at95 at04 at07 at10 at13"

global datasets_concise "at87 at95 at10 at13"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1987 &
       ((inlist(ind1_c, 94,96,97,98,99)) &
         (inlist(occ1_c, 530,535,800,804,805,806,807,808,810,820,830,831,832,834,835,836,837)
       ))
     )
    ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1995 &
        ((inlist(ind1_c, 746,752,753,801,802,803,804,851,853,930,950)) &
          (inlist(occ1_c, 2221,2222,2224,2230,2310,2320,2322,2330,2450,2446,2460,3226,3229,3400,3480,5100,5121,5149,5162,5169)
        ))
      )
      ;
     #delimit cr

      #delimit ;
        replace carework_broad=1 if (year==2004 &
          ((inlist(ind1_c, 12750,13800,14850,15920,15930,15950))
          & // and
          (inlist(occ1_c, 2200,2300,3100,3200,3300,5100,5121,5149,5162,5169))
          )
        )
          ;
       #delimit cr

       #delimit ;
         replace carework_broad=1 if (year==2007 &
           ((inlist(ind1_c, 75,80,85,92,93,95))
           & // and
           (inlist(occ1_c, 2200,2300,3100,3200,3300,5100))
           )
         )
           ;
        #delimit cr

        #delimit ;
          replace carework_broad=1 if (year==2010 &
            ((inlist(ind1_c, 84,85,86,87,88,96,97))
            & // and
            (inlist(occ1_c, 2200,2300,3200,5100,5300,5400))
            )
          )
            ;
         #delimit cr

        #delimit ;
          replace carework_broad=1 if (year==2013 &
            ((inlist(ind1_c, 84,85,86,87,88,96,97))
            & // and
            (inlist(occ1_c, 2200,2300,3200,5100,5300,5400))
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
        gen carework_concise=1 if (year==1987 &
           (inlist(occ1_c, 535,810,832))
        )
        ;
       #delimit cr

       #delimit ;
         replace carework_concise=1 if (year==1995 &
           (inlist(occ1_c, 2330,2446,5149))
         )
         ;
        #delimit cr

        #delimit ;
          replace carework_concise=1 if (year==2010 &
            (inlist(occ1_c, 5300))
          )
          ;
         #delimit cr

         #delimit ;
           replace carework_concise=1 if (year==2013 &
             (inlist(occ1_c, 5300))
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
