# coding=utf-8
import sys
import os
import re

'''
适用于Notepad++ with python 2.7

python auto.py $(FULL_CURRENT_PATH) $(CURRENT_DIRECTORY) $(FILE_NAME) $(NAME_PART) $(EXT_PART)

C/CPP文件只能包含一层文件，被包含文件不能包含自己写的文件(不能包含""的文件 可以包含<>的文件)
'''

class File_Engine(object):
    
    def __init__(self,path,name,ftype):
        self.path = path
        self.name = name
        self.ftype = ftype
        self.full_path = path+"\\"+name+ftype
        self.regex = r"\s*#include\s+\"(.*?)\""
        self.pattern = re.compile(self.regex)
        self.Type_fun = Type_fun
        
    def Run(self):
        f_type = self.ftype.split(".")[1].upper()
        fun = self.Type_fun[f_type]
       
        fun(self)

        
    def RunWithC(self):
        self.RunWithCorCPP(False)
        
    def RunWithCpp(self):
        self.RunWithCorCPP(True)
        
    def RunWithCorCPP(self, isCpp = False):
        depend_file = self.getInclude()
        
        gol = self.full_path.replace(self.ftype,".exe")
        
        file_str = " ".join(depend_file)
        
        arg = " -Wall " + file_str + " -o " + gol

        if(isCpp):
            cmd = "g++" + arg
        else:
            cmd = "gcc -std=c99" + arg
        
        os.system("del "+ gol)
        
        print "#####  "+self.full_path + u"  开始编译######"    
        error = os.system(cmd)
        if error == 1:
            print u"#####  编译错误,退出  #####"
            os.system("pause")
            return 
        
        print u"#####  编译成功,开始执行:"+gol+"  #####"
        os.system(gol)
        
        os.system("pause")
        os.system("del "+ gol)
        
    def RunWithPy(self):
        print u"#####  "+ self.full_path + u"  开始执行######"
        os.system("python "+ self.full_path)
        os.system("pause")
        
    def RunWithJava(self):
        gol = self.full_path.replace(self.ftype,".class")

        print u"#####  开始编译  " + self.full_path+"  #####"
        error = os.system("javac "+self.full_path)
        if error == 1 :
            print u"#####  编译错误  #####"
            os.system("pause")
            return 
        
        print u"#####  编译成功,开始执行: "+gol+"  #####"
        os.system("java -cp "+ self.path +" " +self.name)
        os.system("pause")
        os.system("del "+ gol)
        
        
    def getInclude(self):
        file_list = [self.full_path]
        for i in file_list:
            with open(i,"r") as fp:
                tmp = fp.read()
                fp.close()
            file_tmp = re.findall(self.pattern,tmp)
            for j in file_tmp:
                path = self.path + "\\"+j.replace(".h",self.ftype)
                if file_list.count(path) == 0:
                    file_list.append(path)
        return file_list
            
        
          
Type_fun = {
            "C"     :File_Engine.RunWithC, 
            "CPP"   :File_Engine.RunWithCpp,
            "PY"    :File_Engine.RunWithPy,
            "JAVA"  :File_Engine.RunWithJava
           }
    
   
        
if __name__ == '__main__':
    path = sys.argv[2]
    name = sys.argv[4]
    file_type = sys.argv[5]
        
    tmp = File_Engine(path, name, file_type)
    tmp.Run()

    


    
