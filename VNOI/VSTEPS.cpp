// code by gibhub @nducthang
#include <iostream>
using namespace std;
#define MAX 100010
#define MOD 14062008
long long n,k;
bool Free[MAX]; //Free[i]=true neu i hong
unsigned long long F[MAX]; //F[i] la so cach leo tu bac 1 den i
void Enter()
{
	cin>>n>>k;
	long long num;
	for(long long i=1;i<=k;i++)
	{
		cin>>num;
		Free[num]=true;
	}
	
}
void Cal()
{
	F[1]=1;
	if(Free[2]) F[2]=0;
	else F[2]=1;
	for(long long i=2;i<=n;i++)
	{
		if(Free[i]) F[i]=0;
		else F[i]=(F[i-1]+F[i-2])%MOD;
	}
}
int main()
{
	Enter();
	Cal();
	cout<< F[n] <<endl;
}
