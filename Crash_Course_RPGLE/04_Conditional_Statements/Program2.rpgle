H
D Age             S              2S 0
 /Free
     Dsply 'Enter age:' '' Age;
     If (Age < 10);
       Dsply 'Minor';
     ElseIf (Age >=10 and Age <= 25);
       Dsply 'Major';
     Else;
       Dsply 'Senior';
     EndIf;
     *inlr = *on;
 /End-Free
