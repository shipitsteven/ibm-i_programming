H
D Arr             S              3P 0 Dim(10)
D i               S              2P 0
 *
 /Free
    // Store first 10 numbers in array and display it
    For i=1 to 10;
      Arr(i) = i;
    EndFor;
    For i=1 to %Elem(Arr);
      Dsply  Arr(i);
    EndFor;
    *Inlr = *On;
 /End-Free
