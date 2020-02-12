global varspp "pid did dname cname year ppopwgt currency sex emp inda1 indb1 indc1 indd1 ind1_c occa1 occb1 occ1_c pilabour hours1 gross1 weeks"

global datasets_broad "mx84 mx89 mx92 mx94 mx96 mx98 mx00 mx02 mx04 mx08 mx10 mx12"

global datasets_concise "mx04 mx08 mx10 mx12"

foreach ccyy in $datasets_broad {
   use $varspp using $`ccyy'p, clear
   keep if emp == 1

   #delimit ;
     gen carework_broad=1 if (year==1984 &
         (inlist(ind1_c, 11))
     )
       ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==1989 &
          (inlist(ind1_c, 11))
      )
        ;
     #delimit cr

     #delimit ;
       replace carework_broad=1 if (year==1992 &
           (inlist(ind1_c, 11))
       )
         ;
      #delimit cr

      #delimit ;
        replace carework_broad=1 if (year==1994 &
            (inlist(ind1_c, 11))
        )
          ;
       #delimit cr

       #delimit ;
         replace carework_broad=1 if (year==1996 &
             (inlist(ind1_c, 11))
         )
           ;
        #delimit cr

        #delimit ;
          replace carework_broad=1 if (year==1998 &
              (inlist(ind1_c, 11))
          )
            ;
         #delimit cr

         #delimit ;
           replace carework_broad=1 if (year==2000 &
               (inlist(ind1_c, 611,621,622,623,624,812))
           )
             ;
          #delimit cr

          #delimit ;
            replace carework_broad=1 if (year==2002 &
                (inlist(ind1_c, 611,621,622,623,624,812))
            )
              ;
           #delimit cr

           #delimit ;
             replace carework_broad=1 if (year==2004 &
                 (inlist(ind1_c, 5614,6111,6112,6119,6121,6122,6129,6131,6132,6139,6141,6142,6149,6150,6211,6212,6219,6221,6222,6229,6231,6232,6239,6241,6242,6249,6251,6252,8121))
             )
               ;
            #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2008 &
        (
          (inlist(ind1_c, 5614,6111,6112,6119,6121,6122,6129,6131,6132,6139,6141,6142,6149,6150,6211,6212,6219,6221,6222,6229,6231,6232,6239,6241,6242,6249,6251,6252,8121))
        & // and
          (inlist(occ1_c, 1121,1130,1131,1132,1133,1134,1164,1174,1180,1223,1300,1310,1320,1330,1331,1332,1340,1350,1352,1354,1359,1360,1361,1362,1363,1364,1390,8151,8160,8200,8201,8301,8302))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2010 &
        (
          (inlist(ind1_c, 5614,6111,6112,6119,6121,6122,6129,6131,6132,6139,6141,6142,6149,6150,6211,6212,6219,6221,6222,6229,6231,6232,6239,6241,6242,6249,6251,6252,8121))
        & // and
          (inlist(occ1_c, 2142,2143,2145,2312,2321,2322,2331,2332,2333,2335,2339,2341,2342,2343,2411,2412,2413,2422,2423,2426,2427,2428,2533,2712,2713,2714,2715,2716,2811,5221,5222,5253,5312,9611,9622))
        )
      )
        ;
    #delimit cr

    #delimit ;
      replace carework_broad=1 if (year==2012 &
        (
          (inlist(ind1_c, 5614,6111,6112,6119,6121,6122,6129,6131,6132,6139,6141,6142,6149,6150,6211,6212,6219,6221,6222,6229,6231,6232,6239,6241,6242,6249,6251,6252,8121))
        & // and
          (inlist(occ1_c, 2142,2143,2145,2312,2321,2322,2331,2332,2333,2335,2339,2341,2342,2343,2411,2412,2413,2422,2423,2426,2427,2428,2533,2712,2713,2714,2715,2716,2811,5221,5222,5253,5312,9611,9622))
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
     gen carework_concise=1 if (year==2004 &
       (inlist(ind1_c, 6231,6232,6239,6241,6242,6249,6251,6252))
     )
     ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2008 &
        (inlist(occ1_c, 1340,8151,8201))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2010 &
        (inlist(occ1_c, 2143,2335,5221,5222))
      )
      ;
   #delimit cr

   #delimit ;
      replace carework_concise=1 if (year==2012 &
        (inlist(occ1_c, 2143,2335,5221,5222))
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
