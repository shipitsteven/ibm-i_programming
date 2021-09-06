     H DftActGrp(*no)
     D A               S              3S 0
     D B               S              3S 0
     D C               S              3S 0
      /Free
        Dsply 'Enter number 1: ' '' A;
        Dsply 'Enter number 2: ' '' B;
        Exsr Addsr;
        Dsply C;
        *Inlr = *on;

        BegSr Addsr;
          Dsply 'Inside Addsr';
          C = A + B;
          LeaveSr;
          Dsply 'Inside Addsr';
        EndSr;
      /End-Free
