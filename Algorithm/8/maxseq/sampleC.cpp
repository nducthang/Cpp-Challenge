/*************************************************************************
Program      :   DAY CON DAI NHAT (Bai 1 - Thi HSG Quoc gia 2007
Date         :   14-3-2007
Group        :   Qui hoach dong
Langues      :   Dev C++
*************************************************************************/

#include <fstream.h>
#include <math.h>

#define tfi "MAXSEQ.INP"
#define tfo "MAXSEQ.OUT"

// Khai bao luong input, output
ifstream inp;
ofstream out;

// Khai bao hang so
const int MAXN = 100002;

// Khai bao bien
int n, d[MAXN];
long a[MAXN];

// Ham doc du lieu
int doc()
{
    int i;
    inp.open(tfi);
    inp >> n;
    for (i=1; i<=n; i++) inp >> a[i];
    inp.close();
}    

// Ham kiem tra mot so co thuoc u[k]
int Thuoc(long c)
{
    double delta;
    long candelta;
    delta=1+8*c;
    candelta=(long)sqrt(delta);
    if ((delta==candelta*candelta) && (candelta %2==1)) return 1; else return 0;
}

// Ham tinh
int solve()
{
    int max, i;
    d[0]=0; a[0]=-1;
    for (i=1; i<=n; i++)
       if (!Thuoc(a[i])) d[i]=0; else
       {
           if (a[i]>=a[i-1]) d[i]=d[i-1]+1; else d[i]=1;
       }
    max=0;
    for (i=1; i<=n; i++)
        if (max<d[i]) max=d[i];
    return max;

}

// Ham in ket qua
int viet()
{
    out.open(tfo);
    out << solve() << '\n';
    out.close();
}

// CHUONG TRINh CHINH
int main()
{
    doc();
    viet();
}    
