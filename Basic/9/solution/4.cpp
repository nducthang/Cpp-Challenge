#include <iostream>

using namespace std;
struct PHANSO
{
    int tu, mau;
};
PHANSO Hong(PHANSO a, PHANSO b)
{
    PHANSO tong;
    tong.tu = a.tu * b.mau + b.tu * a.mau;
    tong.mau = a.mau * b.mau;
    return tong;
}
PHANSO Hieu(PHANSO a, PHANSO b)
{
    PHANSO hieu;
    hieu.tu = a.tu * b.mau - b.tu * a.mau;
    hieu.mau = a.mau * b.mau;
    return hieu
}
PHANSO Tich(PHANSO a, PHANSO b)
{
    PHANSO tich;
    tich.tu = a.tu * b.tu;
    tich.mau = a.mau * b.mau;
    return tich;
}
PHANSO Thuong(PHANSO a, PHANSO b)
{
    PHANSO thuong;
    thuong.tu = a.tu * b.mau;
    thuong.mau = a.mau * b.tu;
}
int UCLN(int a, int b)
{
    int r;
    while (b != 0)
    {
        r = a % b;
        a = b;
        b = r;
    }
    return a;
}
PHANSO RutGon(PHANSO a)
{
    int ucln = UCLN(a.tu, a.mau);
    a.tu /= ucln;
    a.mau /= ucln;
    return a;
}
void QuyDong(PHANSO &a, PHANSO &b)
{
    if (a.mau != b.mau)
    {
        a.tu *= b.mau;
        a.mau *= b.mau;
        b.tu *= a.mau;
        b.mau *= a.mau;
    }
}
int SoSanh(PHANSO a, PHANSO b)
{
    QuyDong(a, b);
    if (a.tu < b.tu)
        return -1;
    if (a.tu > b.tu)
        return 1;
    return 0;
}
void HienThiPhanSo(PHANSO a)
{
    cout << a.tu << "/" << a.mau;
}
int main()
{
}