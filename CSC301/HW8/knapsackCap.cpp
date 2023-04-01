#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <fstream>
#include <sstream>
using namespace std;

int knapsackCap(int W, vector<int> w, vector<int> val, int n){
    //initialization 
    int read = 0;
    int write = 1;
    int tmp;
    int readM = 0;
    int writeM = 1;
    int temp;
    int m[2][W+1];
    for (int i = 0; i < W + 1; i++) {
            m[0][i] = i;
    }
    
    int bag[2][W+1];
    for (int i = 0; i < W + 1; i++) {
            bag[0][i] = 0;
            bag[1][i] = 0;

    }
    //iterating just like matrix 
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= W; j++) {
            if (w[i - 1] <= j) {

                bag[write][j] = max(bag[read][j], (val[i - 1] + bag[read][j - (w[i - 1])]));
                if (i > (n + 1) / 2) {
                    if (bag[write][j] == bag[read][j]) {//updating m
                         m[writeM][j] = m[readM][j];

                    } else {
                        m[writeM][j] = m[readM][j - w[i - 1]];
                    }

                }

            } else {
                bag[write][j] = bag[read][j];
                if (i > (n + 1) / 2)
                m[writeM][j] = m[readM][j];

            }

        }

        //switching prev and curr
        if (i > (n + 1) / 2) {
            temp = readM;
            readM = writeM;
            writeM = temp;
        }
        tmp = read;
        read = write;
        write = tmp;
    }

    return m[read][W];

}
int main(){
    //small
    vector<int> vect;
    ifstream small("small.txt");
    string line;
    getline(small,line);
   
    
    int SW = stoi(line.substr(2,line.size()), NULL, 10);
    getline(small, line);
    
    int Sn = stoi(line.substr(2,line.size()), NULL, 10);
    vector<int> smallW;
    vector<int> smallV;

    while(small.good()){
        int count = 0;
        stringstream ss;
        string temp;
        getline(small, line);
        ss << line;
        int num;
        while(!ss.eof()){
            ss >> temp;
            if(stringstream(temp) >> num){
                if(count == 0){
                    smallW.push_back(num);
                    

                }
                else{
                    smallV.push_back(num);

                }
                count++;
            }
        }
    }
    
    int test2 = knapsackCap(SW, smallW, smallV, Sn);



    //medium
    ifstream medium("medium.txt");
    string line2;
    getline(medium,line2);
    
    
    int MW = stoi(line2.substr(2,line2.size()), NULL, 10);
    getline(medium, line2);
    
    int Mn = stoi(line2.substr(2,line2.size()), NULL, 10);
    vector<int> mediumW;
    vector<int> mediumV;

    while(medium.good()){
        int count = 0;
        stringstream ss;
        string temp;
        getline(medium, line2);
        ss << line2;
        int num;
        while(!ss.eof()){
            ss >> temp;
            if(stringstream(temp) >> num){
                if(count == 0){
                    mediumW.push_back(num);
                    
                }
                else{
                    mediumV.push_back(num);

                }
                count++;
            }
        }
    }

    int test3 = knapsackCap(MW, mediumW, mediumV, Mn);

    //laerge
    ifstream large("large.txt");
    string line3;
    getline(large,line3);
    
    
    int LW = stoi(line3.substr(2,line3.size()), NULL, 10);
    getline(large, line3);
    
    int Ln = stoi(line3.substr(2,line3.size()), NULL, 10);
    vector<int> largeW;
    vector<int> largeV;

    while(large.good()){
        int count = 0;
        stringstream ss;
        string temp;
        getline(large, line3);
        ss << line3;
        int num;
        while(!ss.eof()){
            ss >> temp;
            if(stringstream(temp) >> num){
                if(count == 0){
                    largeW.push_back(num);
                    

                }
                else{
                    largeV.push_back(num);

                }
                count++;
            }
        }
    }
    int test4 = knapsackCap(LW, largeW, largeV, Ln);


    cout << "mid capacity small: " << test2 << endl;
    cout << "mid capacity medium: " << test3 << endl;
    cout << "mid capacity large: " << test4 << endl;

}