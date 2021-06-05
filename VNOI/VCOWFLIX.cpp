#include <iostream>
using namespace std;
#define MAX 17
int C,N;
long long w[MAX];


bool Free[MAX];
int x[MAX];
long long T[MAX];
long long maxhientai=-1;
void Enter()
{
	cin>>C>>N;
	for(int i=1;i<=N;i++)
		cin>>w[i];
	T[0]=0;
}
void Process_Result(int i)
{
	int sum=0;
	for(int j=1;j<i;j++)
		sum+=w[x[j]];
	if(sum > maxhientai)
		maxhientai=sum;
}

void Try(int i)
{
	bool flag=true;
	for(int j=1;j<=N;j++)
	{
		if(!Free[j] && T[i-1]+w[j]<=C)
		{
			x[i]=j;
			T[i]=T[i-1]+w[j];
			flag=false;
			Free[j]=true;
			Try(i+1);
			Free[j]=false;
		}
		if(flag)
			Process_Result(i);
	}
}
int main()
{
	Enter();
	Try(1);
	cout<<maxhientai<<endl;
}
