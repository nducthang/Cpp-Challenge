#include <iostream>
#include <string>
#include <algorithm>
using namespace std;

int main()
{
	string A,B;
	cin>>A>>B;
	int F[A.length()+1][B.length()+1];
	
	for(int i=0;i<=A.length();++i)
	{
		for(int j=0;j<=B.length();++j)
		{
			if(i==0||j==0)F[i][j]=0;
			else
			{
				F[i][j]=(A[i-1]==B[j-1])?(F[i-1][j-1]+1):max(max(F[i][j-1],F[i-1][j]),F[i-1][j-1]);
			}
		}
	}
	cout<<F[A.length()][B.length()]<<endl;
}
