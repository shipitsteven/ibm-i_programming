H
D Arr             S              3P 0 Dim(10)
D i               S              2P 0
D idx             S              2P 0
 *
 /Free
    // Store first 10 numbers in array and display it
    For i=1 to 10;
      Arr(i) = i;
    EndFor;

    Idx = %Lookup(8:Arr);     // Search 8 in whole array
    Dsply  Idx;
    Idx = %Lookup(5:Arr:6);   // Search 5 in array from index 6
    Dsply  Idx;
    Idx = %Lookup(4:Arr:1:3); // Search 4 in array between index 1 & 3
    Dsply  Idx;
    *Inlr = *On;
 /End-Free
