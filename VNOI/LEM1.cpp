#include <stdio.h>
#include <cmath>
using namespace std;
#define MAX 10001
#define EPS 0.000000009
#define pi 3.1415926535
int n;
double r[MAX];

double Sol(double R)
{
	double VT=0;
	for(int i=1;i<=n-1;i++)
	{
		VT+=acos(((R+r[i])*(R+r[i])+(R+r[i+1])*(R+r[i+1])-(r[i]+r[i+1])*(r[i]+r[i+1]))/(2*(R+r[i])*(R+r[i+1])));
	}
	VT+=acos(((R+r[n])*(R+r[n])+(R+r[1])*(R+r[1])-(r[n]+r[1])*(r[n]+r[1]))/(2*(R+r[1])*(R+r[n])));
	return VT;
}

int main()
{
	// Read input data
	double R_min=0,R_max=0;
	scanf("%d", &n);
	for(int i=1;i<=n;i++)
	{
		scanf("%lf",&r[i]);
		R_max+=r[i];
	}
	double R = (R_min+R_max)/2;
	while(fabs(R_max-R_min)>EPS)
	{
		double R = (R_min+R_max)/2;
		if(Sol(R)<2*pi)
			R_max=R;
		else
			R_min=R;
	}
	printf("%.3lf",(R_max+R_min)/2);
}
