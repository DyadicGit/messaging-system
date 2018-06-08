@ECHO OFF
CHOICE /C YN /m "Run dos2unix on Dockerfile, .sh scripts & .propeties files "
   goto sub_%ERRORLEVEL%

:sub_1
	call dos2unixScript.bat Dockerfile
	call dos2unixScript.bat .sh
	call dos2unixScript.bat .properties
	
:sub_2
docker-machine rm messaging-system -f
docker-machine create -d virtualbox --virtualbox-memory "4096" --virtualbox-cpu-count "2"  --virtualbox-disk-size "80000"  messaging-system
docker-machine ip messaging-system > IP
SET /p MESSAGING_SYSTEM= < IP
DEL IP

rem "Setting ashared folder as [app]"
::"vboxmanage sharedfolder add messaging-system --name app --hostpath C:\TEST_playground\messaging-system --automount"
set VM_NAME="messaging-system"
set NAME=app
set HOSTPATH=C:\TEST_playground\messaging-system
vboxmanage startvm messaging-system --type emergencystop
vboxmanage sharedfolder add %VM_NAME% --name %NAME% --hostpath %HOSTPATH% --automount
vboxmanage sharedfolder remove %VM_NAME% --name c/Users
vboxmanage startvm messaging-system
TIMEOUT /T 50

@ECHO ON
docker-machine ssh messaging-system sudo curl -L "https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
docker-machine ssh messaging-system sudo chmod +x /usr/local/bin/docker-compose
docker-machine ssh messaging-system sudo mkdir /mnt/app

rem "Mounting application point as [app]"
TIMEOUT /T 20
docker-machine ssh messaging-system sudo mount -t vboxsf app /mnt/app

rem "cleaning packages"
TIMEOUT /T 15
call "%M2_HOME%\bin\mvn" clean package -q -f discovery\pom.xml
call "%M2_HOME%\bin\mvn" clean package -q -f configuration\pom.xml
call "%M2_HOME%\bin\mvn" clean package -q -f http-request-consumer\pom.xml
call "%M2_HOME%\bin\mvn" clean package -q -f event-processor\pom.xml
call "%M2_HOME%\bin\mvn" clean package -q -f gateway\pom.xml

rem "building & uping containers"
docker-machine ssh messaging-system docker-compose -f /mnt/app/messaging-system.yml build
docker-machine ssh messaging-system docker-compose -f /mnt/app/messaging-system.yml up -d

echo *******************************************************
echo http://%MESSAGING_SYSTEM% - Application
echo *******************************************************
pause

