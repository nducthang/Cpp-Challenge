#include <iostream>
using namespace std;
int T; //so bo test
long long xu[35];
long long X;
//long long F[]
void Init()
{
	xu[1]=2;
	xu[2]=3;
	xu[3]=5;
	for(int i=4;i<=34;i++)
		xu[i]=xu[i-1]+xu[i-2]+xu[i-3];
}
void Enter()
{
	// doc du lieu
	cin>>T;
	for(int i=1;i<=T;i++)
	{
		cin>>X;
		// Process
	}
}
int main()
{
	Init();
	Enter();
	long long sum=0;
	for(int i=1;i<=34;i++)
		sum+=xu[i];
	cout<<sum;
	
}
