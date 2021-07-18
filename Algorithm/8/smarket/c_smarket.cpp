/******************************************************************************
Program :  CHUONG TRINH CHAM BAI HOC SINH - Version 1.0 (Ban C++)
Date    :  06-03-2007
******************************************************************************/


#define _WIN32_WINNT 0x0500

#include<iostream>
#include<sstream>
#include<windows.h>
#include<ctime>

#include <iostream.h>
#include <fstream.h>
#include <stdio.h>
#include <iomanip.h>
#include <conio.h>
#include <string.h>
#include <math.h>

// Dinh ngia cac luong
ifstream inp;
ifstream out;
ifstream ans;

// khai bao phan dau cac file
char nfi[]                   =           "SMARKET.INP";
char nfo[]                   =           "SMARKET.OUT";

char fi[]                    =           "INP.00";
char fo[]                    =           "OUT.00";
char fm[]                    =           "ANS.00";
int Pmin                     =           1;
int Pmax                     =           10;

char cp[3]                   =           "00";

using namespace std;

// Cac bien tham so chuong trinh
char progName[100];
char parameters[10000];
int runTime;

// Khai bao bien
int loi[100], diem[100], tong=0;
long kqm, kqo;
int p;


// Cac bien
int s, n, c[502], m[502];


// Ham Doc du lieu (neu co)
int doc()
{
    inp >> s >> n;
    for (int i=1; i<=n; i++) inp >> c[i] >> m[i];
    return 0;
}   

// Ham cham diem 
int cham() 
{
    int i;
    long u;
    out >> kqo;
    ans >> kqm;
    if (kqm!=kqo) return 10; // wrong answer
    int sum=0;
    for (i=1; i<=n; i++)
    {
        out >> u;
        sum+=u*c[i];
    }
    if (sum!=s) return 11;
    return 0;
}    

// Ham in ket qua
int viet()
{
    int i;
    cout << '\n';
    cout << "KET QUA CHAM BAI" << '\n';
    cout << '\n';
    cout << '\n';
    for (i=Pmin; i<=Pmax; i++)
    {
        cout << "Test " << setw(2) << i << "  :  "  << diem[i] << " --- ";
        switch (loi[i])
        {
            case 0 : cout << "Accept" ; break;
            case 1 : cout << "Missing Output File"; break; 
            case 2 : cout << "Time limit execeed"; break; 
            case 10: cout << "Wrong answer"; break;
            case 11: cout << "Phuong an sai"; break;
        }
        cout << '\n';
    }
    cout << "--------------------------" << '\n';
    cout << "Tong     =" << setw(3) << tong << '\n';
    cout << '\n';
    cout << '\n';
    cout << "Press any key to continue..." << '\n';
    getch();
    return 0;
}    

// Xoa tat ca cac file output
int XoaFile()
{
    int i;
    FILE *f;
    for (i=Pmin; i<=Pmax; i++)
    {
        fo[4]=i/10+48; fo[5]=i%10+48;
        f=fopen(fo,"r");
        if (f!=NULL) {fclose(f); remove(fo);}
    }
    f=fopen(nfi,"r"); if (f!=NULL) {fclose(f); remove(nfi);}
    f=fopen(nfo,"r"); if (f!=NULL) {fclose(f); remove(nfo);}
}    

// Ham cham diem
int check()
{
    char u,v;
    for (p=Pmin; p<=Pmax; p++)
    if (loi[p]==0)
    {
        u=p/10+48;
        v=p%10+48;
        fi[4]=u; fi[5]=v;
        fo[4]=u; fo[5]=v;
        fm[4]=u; fm[5]=v;
        
        // Khai bao luong
        inp.open(fi);
        out.open(fo);
        if (!out.good()) {loi[p]=1; diem[p]=0;} else
        {
            ans.open(fm);
                
            // Cham diem
            doc();
            loi[p]=cham();
            if (loi[p]==0) diem[p]=10; else diem[p]=0;
            tong+=diem[p];
        
            // Dong luong
            out.clear();
            inp.clear();
            ans.clear();
            inp.close();
            out.close();
            ans.close();
        }
    }
    viet();
    XoaFile();
    return 0;
}     

//-----------------------------------------------------
// PHAN CHUONG TRINH RUN
int execCmd() {
	char* my_appName=progName;
	char* my_lpCmd=parameters;
	LPSECURITY_ATTRIBUTES my_lpProcessAttributes=NULL;
	LPSECURITY_ATTRIBUTES my_lpThreadAttributes=NULL;
	bool my_inheritHandles=true;
	DWORD my_creationFlag=NORMAL_PRIORITY_CLASS;
	LPVOID my_lpEnvironment=NULL;
	char* my_directory=NULL;
	STARTUPINFOA my_startupInfo;
	ZeroMemory(&my_startupInfo, sizeof(STARTUPINFOA));
	my_startupInfo.cb=sizeof(STARTUPINFOA);
	
	PROCESS_INFORMATION my_processInfo;

	//Ref = http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dllproc/base/createprocess.asp
	bool ok=CreateProcess(my_appName, my_lpCmd, my_lpProcessAttributes, my_lpThreadAttributes, my_inheritHandles,
							my_creationFlag, my_lpEnvironment, my_directory, &my_startupInfo, &my_processInfo);
	int beginTime=clock();
	int endTime=beginTime+runTime;
	DWORD exitCode;
	while (clock()<endTime) {
		GetExitCodeProcess(my_processInfo.hProcess, &exitCode);
		if (exitCode<256) return 0;
		Sleep(10);
	}
	bool terminate=TerminateProcess(my_processInfo.hProcess, 0);
	return 2; //Time limit exceed!
}

// Ham nhap ten chuong trinh va thoi gian chay
int NhapTT()
{
    printf("Ten FILE chuong trinh:");
    gets(progName);
    printf("Thoi gian (ms)       :");
    scanf("%d",&runTime); 
}


// Ham chay cac test
int chay()
{
    for (p=Pmin; p<=Pmax; p++)
    {
        FILE *f1, *f2;
        char c;
        fi[4]=p/10+48; fi[5]=p%10+48;
        fo[4]=p/10+48; fo[5]=p%10+48;
        //copyfile(fi,input);
        f1=fopen(fi,"rb"); 
        f2=fopen(nfi,"wb");
        if (f1!=NULL)
           while ((c=getc(f1))!=EOF) putc(c,f2);
        fclose(f1); fclose(f2);
        cout << "Running test " << p << '\n';
        loi[p]=execCmd();
        if (loi[p]==0) 
        {
            //copyfile(output,fo);
            f1=fopen(nfo,"rb"); 
            f2=fopen(fo,"wb");
            if (f1!=NULL)
               while ((c=getc(f1))!=EOF) putc(c,f2);
            if (f1!=NULL) fclose(f1); 
            if (f2!=NULL) fclose(f2);
        }
    }
}    

//-----------------------------------------------------

// CHUONG TRINH CHINH
int main()
{
    NhapTT();
    chay();
    cout << "Checking! Wait please...." << '\n';
    check();
}    
