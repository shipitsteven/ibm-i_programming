H
D i               S              3P 0
 *
 /Free
    // Display last number divisible by 6 between 1 to 100
    For i=100 downto 1;
      If (%Rem(i:6)=0);
        Dsply  I;
        Leave;
      EndIf;
    EndFor;
    *Inlr = *On;
 /End-Free
