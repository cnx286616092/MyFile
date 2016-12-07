:: notepad++参数说明
:: %1. FULL_CURRENT_PATH : 表示当前文件的完整路径     即：E:\java\HelloNpp.java
:: %2. CURRENT_DIRECTORY:  表示当前文件所在目录，此时不包括文件名字  即：E:\java
:: %3. FILE_NAME:          表示当前文件的文件全名，不包括目录  即：HelloNpp.java
:: %4. NAME_PART:          表示当前文件的文件名称，不包括后缀或者扩展名字 ,即：HelloNpp
:: %5. EXT_PART:           表示当前文件的后缀名或扩展名,即： .java
::
::
::后面这串是命令    autorun.bat $(FULL_CURRENT_PATH) $(CURRENT_DIRECTORY) $(FILE_NAME) $(NAME_PART) $(EXT_PART)

:: 2、关于空格，目录名有空格的情况，所以需要加双引号“”，
::否则向批处理文件传输参数时参数就有问题，再用%~1格式去掉引号
:: %1就是表示批处理的第一个参数，
:: %~1表示删除参数外面的引号
:: 比如有个批处理文件 test.bat
:: 在cmd中输入命令： test.bat  "test"
:: %1表示的是“test“。 
:: %~1表示的是test，没有了双引号
::  
:: 将该文件命名为“TEST.BAT”放在notepad++的安装路径内
:: 编译："TEST.BAT" "$(FULL_CURRENT_PATH)" "$(CURRENT_DIRECTORY)" "$(FILE_NAME)" "$(NAME_PART)" "$(EXT_PART)" compile
:: 运行："TEST.BAT" "$(FULL_CURRENT_PATH)" "$(CURRENT_DIRECTORY)" "$(FILE_NAME)" "$(NAME_PART)" "$(EXT_PART)" run
:: 

@echo off
if {%~5}=={.c} 		goto c
if {%~5}=={.cpp} 	goto cpp
if {%~5}=={.C} 		goto c
if {%~5}=={.CPP}	goto cpp
if {%~5}=={.java} 	goto java
if {%~5}=={.py} 	goto python
if {%~5}=={.PY} 	goto python

::*************编译*****************

::-------------------------------C语言------------------
:c
if exist "%~2\%~4.exe" del "%~2\%~4.exe"
gcc -std=c99 -Wall "%~1" -o  "%~2\%~4"
echo ########编译结束，开始执行##########
if errorlevel 1 goto warn
goto exe  

::-------------------------------C++ ------------------
:cpp
if exist "%~2\%~4.exe" del "%~2\%~4.exe"
g++ -Wall "%~1" -o  "%~2\%~4"
echo ########编译结束，开始执行##########
if errorlevel 1 goto warn
goto exe  

::-------------------------------Java-------------------
:java

if exist "%~2\%~4.class" del "%~2\%~4.class"
javac "%~1"
if errorlevel 1 goto warn
echo ########编译结束，开始执行##########
goto class

::------------------------------python------------------
:python
echo ########python开始执行##########
chdir /d "%~2"
python %3
goto end

::*************运行*****************

::-------------------------------EXE----------------------
:exe
"%~2\%~4.exe"
echo.   
echo delete %~2\%~4.exe
del "%~2\%~4.exe"
goto end

::-------------------------------CLASS----------------------
:class
java -cp "%~2" "%~4"
echo.   

echo delete %~2\%~4.class
del "%~2\%~4.class"
goto end

::-------------------------------PYC-----------------------
:pyc
echo delete %~2\%~4.pyc
del "%~2\%~4.pyc"
goto end
::---------------------------------------------------------
:warn
echo 编译错误
goto end
:end
pause
