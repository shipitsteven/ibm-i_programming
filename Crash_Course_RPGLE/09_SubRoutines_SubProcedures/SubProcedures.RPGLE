     H DftActGrp(*no)
     D A               S              3S 0
     D B               S              3S 0
     D C               S              4S 0
      *
     D Add             PR             4S 0
      * Const Prevents fields from being modified
     D                                3S 0 Const
     D                                3S 0 Const
      *
      /Free
        Dsply 'Enter number 1: ' '' A;
        Dsply 'Enter number 2: ' '' B;
        C = Add(A:B);
        Dsply C;
        // Or you can pass values directly into sub procedure
        C = Add(20:10);
        Dsply C;
        *Inlr = *on;
      /End-Free

     P Add             B
     D                 PI             4S 0
     D Num1                           3S 0 Const
     D Num2                           3S 0 Const
     D Sum             S              4S 0
      /Free
        Dsply 'Inside sub procedure';
        Sum = Num1 + Num2;
        Return Sum;
      /End-Free
     P Add             E
