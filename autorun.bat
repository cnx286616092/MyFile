:: notepad++����˵��
:: %1. FULL_CURRENT_PATH : ��ʾ��ǰ�ļ�������·��     ����E:\java\HelloNpp.java
:: %2. CURRENT_DIRECTORY:  ��ʾ��ǰ�ļ�����Ŀ¼����ʱ�������ļ�����  ����E:\java
:: %3. FILE_NAME:          ��ʾ��ǰ�ļ����ļ�ȫ����������Ŀ¼  ����HelloNpp.java
:: %4. NAME_PART:          ��ʾ��ǰ�ļ����ļ����ƣ���������׺������չ���� ,����HelloNpp
:: %5. EXT_PART:           ��ʾ��ǰ�ļ��ĺ�׺������չ��,���� .java
::
::
::�����⴮������    autorun.bat $(FULL_CURRENT_PATH) $(CURRENT_DIRECTORY) $(FILE_NAME) $(NAME_PART) $(EXT_PART)

:: 2�����ڿո�Ŀ¼���пո�������������Ҫ��˫���š�����
::�������������ļ��������ʱ�����������⣬����%~1��ʽȥ������
:: %1���Ǳ�ʾ������ĵ�һ��������
:: %~1��ʾɾ���������������
:: �����и��������ļ� test.bat
:: ��cmd��������� test.bat  "test"
:: %1��ʾ���ǡ�test���� 
:: %~1��ʾ����test��û����˫����
::  
:: �����ļ�����Ϊ��TEST.BAT������notepad++�İ�װ·����
:: ���룺"TEST.BAT" "$(FULL_CURRENT_PATH)" "$(CURRENT_DIRECTORY)" "$(FILE_NAME)" "$(NAME_PART)" "$(EXT_PART)" compile
:: ���У�"TEST.BAT" "$(FULL_CURRENT_PATH)" "$(CURRENT_DIRECTORY)" "$(FILE_NAME)" "$(NAME_PART)" "$(EXT_PART)" run
:: 

@echo off
if {%~5}=={.c} 		goto c
if {%~5}=={.cpp} 	goto cpp
if {%~5}=={.C} 		goto c
if {%~5}=={.CPP}	goto cpp
if {%~5}=={.java} 	goto java
if {%~5}=={.py} 	goto python
if {%~5}=={.PY} 	goto python

::*************����*****************

::-------------------------------C����------------------
:c
if exist "%~2\%~4.exe" del "%~2\%~4.exe"
gcc -std=c99 -Wall "%~1" -o  "%~2\%~4"
echo ########�����������ʼִ��##########
if errorlevel 1 goto warn
goto exe  

::-------------------------------C++ ------------------
:cpp
if exist "%~2\%~4.exe" del "%~2\%~4.exe"
g++ -Wall "%~1" -o  "%~2\%~4"
echo ########�����������ʼִ��##########
if errorlevel 1 goto warn
goto exe  

::-------------------------------Java-------------------
:java

if exist "%~2\%~4.class" del "%~2\%~4.class"
javac "%~1"
if errorlevel 1 goto warn
echo ########�����������ʼִ��##########
goto class

::------------------------------python------------------
:python
echo ########python��ʼִ��##########
chdir /d "%~2"
python %3
goto end

::*************����*****************

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
echo �������
goto end
:end
pause
