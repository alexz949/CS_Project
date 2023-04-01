#include <iostream>
#include <vector>
#include <algorithm>
#include <math.h>
#include <string>
#include <fstream>
#include <sstream>


using namespace std;
vector<int> vect;

int knapsack_mem(int W, vector<int> w, vector<int> val, int n){
        
        //2-D array version 
        int** bag = new int*[n+1];
        for(int i = 0; i < n+1; i++){
            bag[i] = new int[W+1];
        }
        
        for(int i = 0; i < n+1; i++){
            for(int j = 0; j < W+1; j++){
                bag[i][j] = 0;
            }
        }    
        for(int i = 1; i <= n; i++){
            for(int j = 1; j <= W; j++){
                if(w[i-1] <= j){
                    bag[i][j] = max(bag[i-1][j], bag[i-1][j-w[i-1]] + val[i-1]); //whether add or not
                }
                else{
                    bag[i][j] = bag[i-1][j];
                }
            }
        }

        int ret = bag[n][W];
        int ans = bag[n][W];
        for (int i = n; i > 0 && ans > 0 ; i--) {

            if(ans != bag[i-1][W]){
                vect.push_back(i);
                ans -= val[i-1];
                W -= w[i-1];  
            }
        }
        return ret;
        
}
int main(){
    //small file
    ifstream small("small.txt");
    string line;
    getline(small,line);
    cout << line.substr(2,line.size()) << endl;
    
    int SW = stoi(line.substr(2,line.size()), NULL, 10);
    getline(small, line);
    cout << line.substr(2,line.size()) << endl;
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
    
    int test2 = knapsack_mem(SW, smallW, smallV, Sn);
    
   
    
    cout << "how " << test2 << endl;
    


    FILE * smallOut;
    smallOut = fopen("smallout.txt", "w+");
    fprintf(smallOut, "V %d\n", test2);
    fprintf(smallOut, "i %d\n", vect.size());
    for(int i = vect.size()-1; i >= 0; i--){
        fprintf(smallOut, "%d\n", vect[i]);

    }

    fclose(smallOut);
    vect.clear();


    //small file
    ifstream medium("medium.txt");
    string line2;
    getline(medium,line2);
    cout << line2.substr(2,line2.size()) << endl;
    
    int MW = stoi(line2.substr(2,line2.size()), NULL, 10);
    getline(medium, line2);
    cout << line2.substr(2,line2.size()) << endl;
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

    int test3 = knapsack_mem(MW, mediumW, mediumV, Mn);
    FILE * mediumOut;
    mediumOut = fopen("mediumout.txt", "w+");
    fprintf(mediumOut, "V %d\n", test3);
    fprintf(mediumOut, "i %d\n", vect.size());
    for(int i = vect.size()-1; i >= 0; i--){
        fprintf(mediumOut, "%d\n", vect[i]);

    }

    fclose(mediumOut);
    vect.clear();
   
    
    cout << "how " << test3 << endl;

    //large file
    ifstream large("large.txt");
    string line3;
    getline(large,line3);
    cout << line3.substr(2,line3.size()) << endl;
    
    int LW = stoi(line3.substr(2,line3.size()), NULL, 10);
    getline(large, line3);
    cout << line3.substr(2,line3.size()) << endl;
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
    int test4 = knapsack_mem(LW, largeW, largeV, Ln);
    for(int i = 0; i < largeW.size(); i++){
        cout << largeW[i] << endl;
    }

    FILE * largeOut;
    largeOut = fopen("largeout.txt", "w+");
    fprintf(largeOut, "V %d\n", test4);
    fprintf(largeOut, "i %d\n", vect.size());
    for(int i = vect.size()-1; i >= 0; i--){
        fprintf(largeOut, "%d\n", vect[i]);

    }

    fclose(largeOut);

    vect.clear();
    
    cout << "how " << test4 << endl;
}