global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "ca81 ca87 ca91 ca94 ca97 ca98 ca00 ca04 ca07 ca10"

global datasets_concise "ca98 ca00 ca04 ca07 ca10"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1981 &
        (inlist(occ1_c, 3,6))
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1987 &
        (
          (inlist(ind1_c, 10,11))
        & // and
          (inlist(occ1_c, 3,6))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1991 &
        (
          (inlist(ind1_c, 10,11))
        & // and
          (inlist(occ1_c, 3,6))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1994 &
        (
          (inlist(ind1_c, 10,11,13))
        & // and
          (inlist(occ1_c, 208,209,210,312,313,314,399,623,626))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1997 &
        (
          (inlist(ind1_c, 10,11,13))
        & // and
          (inlist(occ1_c, 208,209,210,312,313,314,399,623,626))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1998 &
        (
          (inlist(ind1_c, 11,12,13,14,15,16))
        & // and
          (inlist(occ1_c, 7,8,10,15,16))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2000 &
        (
          (inlist(ind1_c, 11,12,13,14,15,16))
        & // and
          (inlist(occ1_c, 7,8,10,15,16))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2004 &
        (
          (inlist(ind1_c, 11,12,13,14,15,16))
        & // and
          (inlist(occ1_c, 7,8,10,15,16))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2007 &
        (
          (inlist(ind1_c, 11,12,13,14,15,16))
        & // and
          (inlist(occ1_c, 7,8,10,15,16))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 11,12,13,14,15,16))
        & // and
          (inlist(occ1_c, 7,8,10,15,16))
        )
      )
        ;
    #delimit cr

  replace carework_broad=0 if carework_broad==.

  gen pilabour_hrs = gross1 * hours1 * weeks

  gen wage = pilabour / (weeks * hours1)

  //tabulate carework_broad [aw=ppopwgt], summarize(wage)

  tabulate carework_broad sex [aw=ppopwgt]
  tabulate carework_broad [aw=ppopwgt], summarize(pilabour)
  tabulate carework_broad, summarize(pilabour_hrs)
  tabulate carework_broad [aw=ppopwgt], summarize(pilabour_hrs)
}

foreach ccyy in $datasets_concise {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_concise=1 if (year==1998 &
       (inlist(occ1_c, 16))
     )
     ;
    #delimit cr

    #delimit ;
      replace carework_concise=1 if (year==2000 &
        (inlist(occ1_c, 16))
      )
      ;
     #delimit cr

     #delimit ;
       replace carework_concise=1 if (year==2004 &
         (inlist(occ1_c, 16))
       )
       ;
      #delimit cr

      #delimit ;
        replace carework_concise=1 if (year==2007 &
          (inlist(occ1_c, 16))
        )
        ;
       #delimit cr

       #delimit ;
         replace carework_concise=1 if (year==2010 &
           (inlist(occ1_c, 16))
         )
         ;
        #delimit cr

  replace carework_concise=0 if carework_concise==.

  gen pilabour_hrs = gross1 * hours1 * weeks

  gen wage = pilabour / (weeks * hours1)

  //tabulate carework_concise [aw=ppopwgt], summarize(wage)

  tabulate carework_concise sex [aw=ppopwgt]
  tabulate carework_concise [aw=ppopwgt], summarize(pilabour)
  tabulate carework_concise, summarize(pilabour_hrs)
  tabulate carework_concise [aw=ppopwgt], summarize(pilabour_hrs)
}
