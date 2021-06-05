#include <iostream>
using namespace std;
#define MAX 17
#define MAXC 85020
int C,N;
long long w[MAX];
bool F[MAXC]; // F[i] = true tuc la ton tai cach chon con bo de co khoi luong i

void Enter()
{
	cin>>C>>N;
	for(int i=1;i<=N;i++)
		cin>>w[i];
}
void Cal()
{
	F[0]=true;
	for(int i=1;i<=N;i++)
	{
		for(int j=C;j>=w[i];j--)
		{
			F[j]=(F[j]||F[j-w[i]]);
		}
	}
}
void Result()
{
	for(int i=C;i>=0;i--)
	{
		if(F[i])
		{
			cout<<i<<endl;
			break;
		}
	}
}
int main()
{
	Enter();
	Cal();
	Result();
}
