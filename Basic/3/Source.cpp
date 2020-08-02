#include <iostream>
#include <ctime>
#include <Windows.h>
using namespace std;

int XucXac()
{
	srand(time(NULL));
	Sleep(rand()%(4000 - 1000 + 1) + 1000);
	int number1 = rand() % 6 + 1;
	int number2 = rand() % 6 + 1;
	cout << "Tong la: " << number1 << " + " << number2 << " = " << number1 + number2 << endl;
	return number1 + number2;
}

int main()
{
	int myPoint;
	int Sum = XucXac();
	int flag;
	switch (Sum)
	{
	case 7:case 11:
		flag = 1;
		break;
	case 2: case 3: case 12:
		flag = 0;
		break;
	default:
		myPoint = Sum;
		flag = -1;
		break;
	}
	while (flag == -1)
	{
		Sum = XucXac();
		if (Sum == myPoint)
			flag = 1;
		if (Sum == 7)
			flag = 0;
	}
	if (flag == 1)
		cout << "Ban thang!\n";
	if (flag == 0)
		cout << "Ban thua!\n";
	system("pause");
	return 0;
}
