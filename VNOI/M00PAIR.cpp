#include<iostream>
#include<string>
#include<stack>

typedef long long int LLD;
typedef unsigned long long int LLU;

using namespace std;

string add(string a, string b){
    //  return a + b
    stack<int> st;
    string res = "";
    int i = a.length() - 1, j = b.length() - 1, carry = 0, sum;
    while(i >= 0 && j >= 0){
        sum = (a[i] - 48) + (b[j] - 48) + carry;
        st.push(sum % 10);
        carry = sum / 10;
        i--;j--;
    }
    while(i >= 0){
        sum = (a[i] - 48) + carry;
        st.push(sum % 10);
        carry = sum / 10;
        i--;
    }
    while(j >= 0){
        sum = (b[j] - 48) + carry;
        st.push(sum % 10);
        carry = sum / 10;
        j--;
    }
    while(carry){
        st.push(carry % 10);
        carry /= 10;
    }
    while(!st.empty()){
        res.append(1, st.top() + 48);
        st.pop();
    }
    return res;
}

int main(){

    string res[1000], total[1000];
    int n;
    /*  res[n] will store the result for nth step.
        total[n] will store the sum of res[0], res[1], ..., res[n-1], res[n] */
    res[0] = res[1] = total[0] = total[1] = "0";
    for(int i=2;i<1000;i++){
        res[i] = total[i-1];
        if(i % 2 == 0)
            res[i] = add(res[i], "1");
        total[i] = add(total[i-1], res[i]);
    }
    while(scanf("%d", &n) != EOF)
        cout << res[n] << endl;
    return 0;
}