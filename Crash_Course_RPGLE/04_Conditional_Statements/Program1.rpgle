H
D Age             S              2S 0
 /Free
     Dsply 'Enter age:' '' Age;
     Select;
       When (Age < 10);
         Dsply 'Minor';
       When (Age >=10 and Age <= 25);
         Dsply 'Major';
       Other;
         Dsply 'Senior';
     EndSl;
     *inlr = *on;
 /End-Free
