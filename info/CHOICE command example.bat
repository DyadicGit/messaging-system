@ECHO OFF
CHOICE /C YN /m "choose [Y]yes or [N]No"
   goto sub_%ERRORLEVEL% 
   

:sub_1 
   ECHO You typed Y for yes
GOTO continue 

:sub_2
   ECHO You typed N for no
GOTO continue

:continue
@ECHO ON
ECHO "end of file"
