set param1=%~1
set loc=C:\Users\Olgerd\Documents\_JOB\_Programs\cmder\vendor\git-for-windows\usr\bin
forfiles /S /M *%param1% /C "cmd /C %loc%\dos2unix.exe @path"