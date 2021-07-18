/*************************************************************************
Program    :    Thue giay (SHOES)
Date	   :	30-3-2007
Group	   : 	Qui hoach dong
Langues	   :	Dev C++
*************************************************************************/

#include <fstream.h>
#include <math.h>

#define tfi "SHOES.INP"
#define tfo "SHOES.OUT"

// Khai bao luong input, output
ifstream inp;
ofstream out;

// Khai bao hang so
const int MAXN=1002;

// Khai bao cac bien chinh
int n, m, s[MAXN], h[MAXN];
long f[MAXN], min[MAXN];

// Ham doc
int doc()
{
   int i;
   inp.open(tfi);
   inp >> m >> n;
   for (i=1; i<=m; i++) inp >> s[i];
   for (i=1; i<=n; i++) inp >> h[i];
   inp.close();
   return 0;
}

int qsorts(int k, int l)
{
   int r=s[(k+l)/2];
   int i=k;
   int j=l;
   while (i<=j)
   {
      while (s[i]<r) i++;
      while (s[j]>r) j--;
      if (i<=j)
      {
	 int t=s[i];
	 s[i]=s[j];
	 s[j]=t;
	 i++;
	 j--;
      }
   }
   if (k<j) qsorts(k,j);
   if (i<l) qsorts(i,l);
   return 0;
}

int qsorth(int k, int l)
{
   int r=h[(k+l)/2];
   int i=k;
   int j=l;
   while (i<=j)
   {
      while (h[i]<r) i++;
      while (h[j]>r) j--;
      if (i<=j)
      {
	 int t=h[i];
	 h[i]=h[j];
	 h[j]=t;
	 i++;
	 j--;
      }
   }
   if (k<j) qsorth(k,j);
   if (i<l) qsorth(i,l);
   return 0;
}

// Ham tinh do lech
int tinh()
{
   int i, j;
   qsorts(1,m);
   qsorth(1,n);
   f[1]=abs(h[1]-s[1]);
   min[1]=f[1];
   for (j=2; j<=m; j++)
   {
      f[j]=abs(h[1]-s[j]);
      min[j]=min[j-1];
      if (min[j]>f[j]) min[j]=f[j];
   }
   for (i=2; i<=n; i++)
   {
       for (j=m; j>=i; j--)
	   f[j]=abs(h[i]-s[j])+min[j-1];
       // Tinh lai mang min
       min[i]=f[i];
       for (j=i+1; j<=m; j++)
       {
	  min[j]=min[j-1];
	  if (f[j]<min[j]) min[j]=f[j];
       }
   }
   long ds=f[n];
   for (j=n+1; j<=m; j++)
      if (ds>f[j]) ds=f[j];
   return ds;
}

// Ham in ket qua
int viet()
{
   out.open(tfo);
   out << tinh() << '\n';
   out.close();
   return 0;
}

// CHUONG TRINH CHINH
int main()
{
   doc();
   viet();
   return 0;
}
