H
D i               S              2P 0
 *
 /Free
    // Display number 1 to 10 except 3 multiple
    i = 0;
    DoW (i<10);
      i += 1;
      If (%Rem(i:3)=0);
        Iter;
      EndIf;
      Dsply  i;
    EndDo;
    *Inlr = *On;
 /End-Free
