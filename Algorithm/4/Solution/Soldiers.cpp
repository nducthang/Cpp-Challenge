#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <string>
using namespace std;
int n, m, k;
string s;
int newPerson = 0, oldPerson = 0;
int c = 0;
int main()
{
	freopen("input.txt", "r", stdin);
	cin >> n >> m >> k >> s;
	for (int i = 0; i < k; i++)
	{
		if (s[i] == 'L')
		{
			if (oldPerson < 270) oldPerson += 90;
			else oldPerson = 0;
			if (newPerson >= 90) newPerson -= 90;
			else newPerson = 270;
		}
		else if (s[i] == 'R')
		{
			if (oldPerson >= 90) oldPerson -= 90;
			else oldPerson = 270;
			if (newPerson < 270) newPerson += 90;
			else newPerson = 0;
		}
		else
		{
			if (oldPerson > 180) oldPerson = 90;
			else oldPerson += 180;
			if (newPerson > 180) newPerson = 90;
			else newPerson += 180;
		}
		if (oldPerson != newPerson) c++;
	}
	cout << c << endl;
}
