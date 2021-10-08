     H
     FSTMG001D  CF   E             WORKSTN SFILE(SDATA:RRN#)
     FUSERS     UF A E           K DISK
     FSTUDENTS  UF A E           K DISK
      *
     D RRN#            S              4S 0
      *--------------------------------------------
      * Main routine
      *--------------------------------------------
      /Free
       //-----------------------------------------
       // Display first screen until F3 is pressed
       //-----------------------------------------

       DOW *In03 = *Off;
         Exfmt S01FMT;
         Exsr $LoginSr;
       EndDo;

       *Inlr = *On;
      /End-Free
      *--------------------------------------------
      * Login Sub Routine
      *--------------------------------------------
      /Free
       BegSr $LoginSR;

         //---------------------------------------
         // Checks for validation on first screen login options
         //---------------------------------------
         If *In05 = *On;
           Clear EMSG01;
           Clear InpOpt;
         Else;

           Select;
           When InpOpt = 0;                    // If input option is blank
             EMSG01 = 'Input cannot be blank';
           When InpOpt = 1;
             DoW (*In03 = *Off);
               Exfmt S02FMT;
               Clear EMSG02;
               If (*In12 = *On);
                 Leave;
               Else;
                 Exsr $AdminSR;
               EndIf;
             EndDo;

           When InpOpt = 2;
             DoW (*In03 = *Off);
               Exfmt S03FMT;
               Clear EMSG03;
               If (*In12 = *On);
                 Leave;
               Else;
                 Exsr $StudentSR;
               EndIf;
             EndDo;

           Other;
             EMSG01 = 'Invalid input';

           EndSl;
         EndIf;
       EndSr;
      /End-Free

      *--------------------------------------
      * Admin Login Sub Routine
      *--------------------------------------
      /Free
       BegSr $AdminSr;

         //---------------------------------------
         // Password Validation on Admin login screen
         //---------------------------------------

         If *In05 = *On;
           Clear EMSG02;

         Else;
           If (USRID = 0 or PWD = ' ');
             EMSG02 = 'User ID or Password cannot be blank';
           Else;
             Chain USRID Users;
             If %Found(Users);
               If URole = 'ADMIN';
                 If UPWD = PWD;
                   Exsr $AdminOption;
                 Else;
                   EMSG02 = 'Wrong Password';
                 EndIf;
               Else;
                 EMSG02 = 'You are not an Admin';
               EndIf;
             Else;
               EMSG02 = 'User ID not valid';
             EndIf;
           EndIf;
         EndIf;
       EndSr;
      /End-Free

      *--------------------------------------
      * Student Login Sub Routine
      *--------------------------------------
      /Free
       BegSr $StudentSr;

         //---------------------------------------
         // Password Validation on Admin login screen
         //---------------------------------------

         If *In05 = *On;
           Clear EMSG03;

         Else;
           If (USRID = 0 or PWD = ' ');
             EMSG03 = 'User ID or Password cannot be blank';
           Else;
             Chain USRID Users;
             If %Found(Users);
               If URole = 'STUDENT';
                 If UPWD = PWD;
                   Exsr $StudOption;
                 Else;
                   EMSG03 = 'Wrong Password';
                 EndIf;
               Else;
                 EMSG03 = 'You are not a Student';
               EndIf;
             Else;
               EMSG03 = 'User ID not valid';
             EndIf;
           EndIf;
         EndIf;
       EndSr;
      /End-Free

      *--------------------------------------
      * Admin Option Sub Routine
      *--------------------------------------
      /Free
       BegSr $AdminOption;
         DoW (*In03 = *Off);
           AdmName = UName;
           Exfmt S04FMT;
           If (*In12 = *On);
             Leave;
           Else;
             // validate options
             Select;
             When AdmOpt = 1;
               // Display all Student
               Exsr $DspAllStud;
             When AdmOpt = 2;
               // View and Edit Student
               Exsr $ViewEditStud;
             When AdmOpt = 3;
               Exsr $AddNewStud;
             Other;
               EMSG04 = 'Invalid Option';
             EndSl;
           EndIf;
         EndDo;
       EndSr;
      /End-Free

      *--------------------------------------
      * Student Option Sub Routine
      *--------------------------------------
      /Free
       BegSr $StudOption;
         DoW (*In03 = *Off);
           StudName = UName;
           Exfmt S05FMT;
           Clear EMSG05;
           If (*In12 = *On);
             Leave;
           ElseIf *In05 = *On;
             Clear EMSG05;
             Clear StuOpt;
           Else;
             // validate options
             Select;
             When StuOpt = 1;
               // Display one student
               Exsr $DspOneStud;

             When StuOpt = 2;
               Exsr $EditStud;
             Other;
               EMSG05 = 'Invalid Option';
             EndSl;
           EndIf;
         EndDo;
       EndSr;
      /End-Free

      *--------------------------------------
      * Display all students
      *--------------------------------------
      /Free
       BegSr $DspAllStud;
         // Clear sub file
         *In50 = *Off;
         Write SCTL;
         RRN# = 0;
         *In50 = *On;

         // Load SFL
         Setll *loval Students;
         Read Students;
         DoW Not %EOF(Students);
           RRN# = RRN# + 1;
           Write SDATA;
           Read Students;
         EndDo;

         // Display SFL
         DoW *In03 = *Off;
           Exfmt SCTL;
           If *In12 = *On;
             Leave;
           EndIf;
         EndDo;
       EndSr;
      /End-Free

      *--------------------------------------
      * Display one student
      *--------------------------------------
      /Free
       BegSr $DspOneStud;
         DoW *In03 = *Off;
           Chain UsrID Students;
           Exfmt S07Fmt;
           If *In12 = *On;
             Leave;
           EndIf;
         EndDo;
       EndSr;
      /End-Free

      *--------------------------------------
      * View and Edit Student
      *--------------------------------------
      /Free
       BegSr $ViewEditStud;
         DoW *In03 = *Off;
           Exfmt S06FMT;
           If (*In12 = *On);
             Leave;
           ElseIf (*In04 = *On and SID1 <> 0);
            Chain InpStudNo Students;
            If %Found(Students);
             SID1 = SID1;
             SName = SName1;
             SDept = SDpt1;
             SAddr = SAddr1;
             SEmail = SEmail1;
             SPhone = SPhone1;
             Update StudFmt;
            EndIf;
             EMSG06 = 'Student Updated..!!!';
           Else;
             Chain InpStudNo Students;
             If %Found(Students);
               SID1 = SID;
               SName1 = SName;
               SDpt1 = SDept;
               SAddr1 = SAddr;
               SEmail1 = SEmail;
               SPhone1 = SPhone;
             Else;
               Clear SID1;
               Clear SName1;
               Clear SDpt1;
               Clear SAddr1;
               Clear SEmail1;
               Clear SPhone1;
               EMSG06 = 'Student Not Found';
             EndIf;
           EndIf;
         EndDo;
       EndSr;
      /End-Free

      *--------------------------------------
      * Add new student
      *--------------------------------------
      /Free
       BegSr $AddNewStud;
         DoW (*In03 = *Off);
           Exfmt SAddFmt;
           Clear EMsgAdd;
           If (*In12 = *On);
             Leave;
           ElseIf (*In05 = *On);
             // Clear all fields
             Clear NSName;
             Clear NSDpt;
             Clear NSAddr;
             Clear NSEmail;
             Clear NSPhone;
           Else;
             If (NSName = ' ' or NSDpt = ' ');
               EMsgAdd = 'Mandatory fields missing';
             Else;
               If (*In06 = *On);
                 // Create student
                 SetGT *hival Students;
                 ReadP(E) Students;
                 SID = SID + 1;
                 SName = NSName;
                 SDept = NSDpt;
                 SAddr = NSAddr;
                 SEmail = NSEmail;
                 SPhone = NSPhone;
                 SCrtTS = %Timestamp();
                 SUdpTS = %Timestamp();
                 Write StudFmt;
                 // Update user table, given default password
                 UID = SID;
                 UName = NSName;
                 UPwd = 'password';
                 URole = 'STUDENT';
                 UCRTTS = %Timestamp();
                 UUPDTS = %Timestamp();
                 Write UsrFmt;
                 // Clear input fields
                 Clear NSName;
                 Clear NSDpt;
                 Clear NSAddr;
                 Clear NSEmail;
                 Clear NSPhone;
                 EMsgAdd = 'Student ' + %Char(SID) + ' created..!';
               Else;
                 EMsgAdd = 'Mandatory fields okay, F6 to Add';
               EndIf;
             EndIf;
           EndIf;
         EndDo;
       EndSr;
      /End-Free

      *--------------------------------------
      * Edit Student as Student
      *--------------------------------------
      /Free
       BegSr $EditStud;
         DoW *In03 = *Off;
           Exsr $LoadStudentInfo;
           Exfmt SEDITFMT;
           If (*In12 = *On);
             Exsr $ClearEditScreen;
             Leave;
           ElseIf (*In06 = *On);
             SID = USRID;
             SName = UpSName;
             SDept = UpDept;
             SAddr = UpAddr;
             SEmail = UpEmail;
             SPhone = UpPhone;
             Update StudFmt;
             // Update User file
             Chain USRID Users;
             If %Found(Users);
               UName = UpSName;
               UUPDTS = %Timestamp();
               Update USRFMT;
             EndIf;
             EMSGEDIT = 'Student information Updated...!';
           ElseIf (*In05 = *On);
             EMSGEDIT = 'Page refreshed';
             Exsr $ClearEditScreen;
q            Exsr $LoadStudentInfo;
           EndIf;
         EndDo;

       EndSr;
      /End-Free

      *--------------------------------------
      * Load Student Info on Edit page
      *--------------------------------------
      /Free
       BegSr $LoadStudentInfo;
         Chain USRID Students;
         If %Found(Students);
           SIDEDIT = SID;
           UpSName = SName;
           UpDept = SDept;
           UpAddr = SAddr;
           UpEmail = SEmail;
           UpPhone = SPhone;
         Else;
           EMSGEDIT = 'Student Not Found';
         EndIf;
       ENDSR;
      /End-Free

      *--------------------------------------
      * Clear Edit Screen for Students
      *--------------------------------------
      /Free
       BegSr $ClearEditScreen;
         Clear SIDEDIT;
         Clear UpSName;
         Clear UpDept;
         Clear UpAddr;
         Clear UpEmail;
         Clear UpPhone;
         Clear EMSGEDIT;
       ENDSR;
      /End-Free
