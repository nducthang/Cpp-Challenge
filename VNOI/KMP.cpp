#include <iostream>
#include <cstring>
using namespace std;
// KMP algorithm
#define MAX 1000000
int F[MAX]; // prefix function
char T[]="0nguyenducthangdeptraithangdep";
char P[]="0thangdep";
int n,m; // n is length of T, m is length of P
void Prefix()
{
	// find prefix function
	F[1]=0;
	for(int q=2;q<=m;q++) // scan P[2..m] from left to right
	{
		int k=F[q-1];
		while(k>0 && P[k+1]!=P[q])
			k=F[k]; // The prefix P_k isn't suffix P_q
		if(P[k+1]==P[q])
			k=k+1; // The longest prefix P_k is also the proper suffix of P_q
		F[q]=k;
	}
}
void KMP()
{
	// KMP algorithm
	int q=0; //number of characters matched
	for(int i=1;i<=n;i++) // Scan T from left to right
	{
		while(q>0 && P[q+1]!=T[i])
			q=F[q];
		if(P[q+1]==T[i])
			q=q+1;
		if(q==m) // is all of P[1..m] matched?
		{
			cout<<"Vi tri chuoi con tu vi tri: "<<i-m+1<<endl;
			q=F[q]; // look for the next match
		}
	}
}
int main()
{
	//cout<<"Input T: "; gets(T);
	//cout<<"Input P: "; gets(P);
	n=strlen(T)-1;
	cout<<n<<endl;
	m=strlen(P)-1;
	cout<<m<<endl;
	Prefix();
	KMP();
}
