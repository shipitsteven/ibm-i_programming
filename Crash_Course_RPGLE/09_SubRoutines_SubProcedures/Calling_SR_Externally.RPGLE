     H DftActGrp(*no)
      * ExtPgm uses the exact filename of where SubProcedure was written
      * SUBPR is what I named mine on PUB400
     D AddNum          PR                  ExtPgm('SUBPR')
      *
      /Free
        AddNum();
        *inlr = *on;
      /End-Free
