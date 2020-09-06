#include <iostream>
#include <fstream>
using namespace std;

int main()
{
    fstream f("./file/ARRAY.INP", ios::in);
    int n;
    int temp;
    f >> n;
    int sum=0;
    for (int i = 0; i < n; i++){
        f >> temp;
        sum += temp;
    }
    fstream out("./file/ARRAY.OUT", ios::out);
    out << sum;
    f.close();
    out.close();

}