H
D A               S              5S 0
D B               S              5S 0
 * Get number A and B and compute all arithmetic operations
 /Free
   Dsply 'Enter Number 1: ' '' A;
   Dsply 'Enter Number 2: ' '' B;
   Dsply  ('Add :' + %Char(A+B));
   Dsply  ('Sub :' + %Char(A-B));
   Dsply  ('Mul :' + %Char(A*B));
   Dsply  ('Div :' + %Char(A/B));
   Dsply  ('Rem :' + %Char(%Rem(A:B)));

   *Inlr = *On;
 /End-Free
