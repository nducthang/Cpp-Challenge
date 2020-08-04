#include <iostream>
using namespace std;

int main()
{
    for(int traudung=0;traudung<=100;traudung++)
    {
        for(int traunam=0;traunam<=100-traudung;traunam++)
        {
            for(int traugia=0;traugia<=100-traudung-traunam;traugia++)
            {
                if(traudung*15+traunam*9+traugia==300 && traudung+traunam+traugia==100)
                {
                    cout<<"Trau dung: "<<traudung<<", trau nam: "<< traunam<<", trau gia: "<<traugia<<endl;
                }
            }
        }
    }
}