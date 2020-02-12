global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "se81 se87 se92 se95 se00 se05"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1981 &
       (
         (inlist(ind1_c, 91,92,93,94,95))
       & // and
         (inlist(occ1_c, 300,310,330,400,410,430,510,530,610,620,630,9300,9310,9320,9340))
       )
     )
       ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1987 &
        (
          (inlist(ind1_c, 91,92,93,94,95,96))
        & // and
          (inlist(occ1_c, 330,340,400,410,430,510,530,610,620,630,9300,9310,9320,9340))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1992 &
        (
          (inlist(ind1_c, 91,92,93,94,95,96))
        & // and
          (inlist(occ1_c, 330,340,400,410,430,510,530,610,620,630,9300,9310,9320,9340))
        )
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==1995 &
          (inlist(occ1_c, 310,330,340,400,410,430,510,530,600,620,630,9300,9310,9320,9340))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2000 &
          (inlist(ind1_c, 11746,12752,13801,13802,13803,13804,14851))
      )
        ;
   #delimit cr

   #delimit ;
      replace carework_broad=1 if (year==2005 &
          (inlist(ind1_c, 11746,12752,13801,13802,13803,13804,14851))
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
