#include <iostream>
#include <string>
using namespace std;
string s;
long anphabet[100]={0}; //index ascii anphabet A to Z is 65 to 90
char x[10];
int len=0; // length(s)
void Enter()
{
	// doc du lieu
	cin>>s;
	len=s.length();
}
long Factorial[10]={1,1,2,6,24,120,720,5040,40320,362880};
long CountPermutation()
{
	// dem so hoan vi - CT hoan vi lap
	// Khoi tao so luong chu cai la 0 tu A den Z
//	for(int i=65;i<=90;i++)
//		anphabet[i]=0;
	// kiem tra so luong cac chu cai
	for(int i=0;i<len;i++)
		anphabet[s[i]]++;
	// Dem so cau hinh su dung CT hoan vi lap
	long result=Factorial[len]; // mau so
	for(int i=65;i<=90;i++)
		if(anphabet[i])
			result/=Factorial[anphabet[i]];
	return result;
}
void Try(int i)
{
	for(int j=65;j<=90;j++)
	{
		if(anphabet[j]>0)
		{
			x[i]=j;
			if(i==len)
			{
				// print 
				for(int t=1;t<=len;t++)
					cout<<x[t];
				cout<<"\n";
			}
			else
			{
				anphabet[j]--;
				Try(i+1);
				anphabet[j]++;
			}
		}
	}
		
}
int main()
{
	//freopen("in.txt","r",stdin);
	//freopen("out.txt","w",stdout);
	Enter();
	cout<<CountPermutation()<<endl;
	Try(1);
}
