 H
 FWndSfl01D CF   E             Workstn
 F                                     SFILE(WRCD1:RRN1)
 F                                     SFILE(WRCD2:RRN2)
  *
 D RRN1            S              4S 0
 D RRN2            S              4S 0
 D i               S              2S 0
 D idx             S                   Like(RRN1)
  *
  /Free
       // Clearing first subfile----------------
       *In50 = *Off;
         Clear WRCD1;
         Write WCTL1;
       *In50 = *On;
       // Loading first subfile------------------
       For i = 1 to 7;
         RRN1 += 1;
         Country = 'Country ' + %Char(i);
         Write WRCD1;
       Endfor;
       NBRRECA = RRN1;
       //
       // Clearing second subfile---------------
       *In60 = *Off;
         Clear WRCD2;
         Write WCTL2;
       *In60 = *On;
       //
       // Loading second subfile---------------
       For i = 1 to 7;
         RRN2 += 1;
         City = 'City ' + %Char(i);
         Write WRCD2;
       EndFor;
       NBRRECB = RRN2;
       //
       // Write Header, Footer & 2nd subfile-------
       Write  Header;
       Write  Footer;
       Write  WCTL2;
       //
       // Disply 1st subfile-----------------------
       Exfmt  WCTL1;
       //
       // Disply 2nd subfile-----------------------
       Exfmt  WCTL2;
       //
       // Check for selection from 2nd subfile-----
       for idx = 1 to NBRRECB;
         chain idx WRCD2;
         If CTLFLD = 1;
            Dsply  City;
         EndIf;
       endfor;
       *Inlr = *On;
  /End-Free
  *
