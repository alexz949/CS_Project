#include <iostream>
#include <vector>
#include <algorithm>
#include <math.h>
#include <string>
#include <fstream>
#include <sstream>

using namespace std;
int knapsack_opt(int W, vector<int> w, vector<int> val, int n){
    /*this method is essentially the same as knapasck_cap but
    with different returning value so I just copy it.
    */
    int read = 0;
    int write = 1;
    int tmp;
    int readM = 0;
    int writeM = 1;
    int temp;
    int m[2][W+1];

    //intialization
    for (int i = 0; i < W + 1; i++) {
            m[0][i] = i;
    }
    
    int bag[2][W+1];
    for (int i = 0; i < W + 1; i++) {
            bag[0][i] = 0;
            bag[1][i] = 0;
    }
    
    //tracing with two arrays
    for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= W; j++) {
                if (w[i - 1] <= j) {
                    bag[write][j] = max(bag[read][j], (val[i - 1] + bag[read][j - (w[i - 1])]));
                    if (i > (n + 1) / 2) {//start updating m
                        if (bag[write][j] == bag[read][j]) {
                            m[writeM][j] = m[readM][j];
                        } else 
                            m[writeM][j] = m[readM][j - w[i - 1]];
                        
                    }

                } else {
                    bag[write][j] = bag[read][j];
                    if (i > (n + 1) / 2)
                        m[writeM][j] = m[readM][j];

                }

            }
            //updating prev and curr pointer
            if (i > (n + 1) / 2) {
                temp = readM;
                readM = writeM;
                writeM = temp;
            }

            tmp = read;
            read = write;
            write = tmp;
        }

        return bag[read][W];

}
int knapsack_cap(int W, vector<int> w, vector<int> val, int n){
    int read = 0;
    int write = 1;
    int tmp;
    int readM = 0;
    int writeM = 1;
    int temp;
    int m[2][W+1];

    //intialization
    for (int i = 0; i < W + 1; i++) {
            m[0][i] = i;
    }
    
    int bag[2][W+1];
    for (int i = 0; i < W + 1; i++) {
            bag[0][i] = 0;
            bag[1][i] = 0;
    }
    
    //tracing with two arrays
    for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= W; j++) {
                if (w[i - 1] <= j) {
                    //normal updating with bag
                    bag[write][j] = max(bag[read][j], (val[i - 1] + bag[read][j - (w[i - 1])]));
                    if (i > (n + 1) / 2) {//start updating m
                        if (bag[write][j] == bag[read][j]) {
                            m[writeM][j] = m[readM][j];

                        } else 
                            m[writeM][j] = m[readM][j - w[i - 1]];
                    }

                } else {
                    bag[write][j] = bag[read][j];
                    if (i > (n + 1) / 2)
                        m[writeM][j] = m[readM][j];
                }
            }
            //updating prev and curr pointer
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

vector<pair<int, int>> last(vector<int> val, vector<int> w, int W) {
    //creating one-to-one correspondence of current val and elements.
    vector<pair<int, int>> K(W+1, {0,-1});
    
    for (int i = 0; i < val.size(); ++i) {
        for (int j = W; j >= 0; --j) {
            if (w[i] <= j){
                if(K[j].first < K[j - w[i]].first + val[i]) 
                    K[j] = { K[j - w[i]].first + val[i], i };
            }
        }
    }
    return K;
}

vector<int> knapsack_dc(vector<int>  v, vector<int>  w, int W, int offset = 0) {
    //base case
    if (v.empty()) {
        return {};
    }
    //middle capacity
    int k = knapsack_cap(W, w, v, w.size());
    
    //partitioning 
    int mid = v.size() / 2;
    
    vector<pair<int, int>> subSol1 = last(vector<int>(begin(v), begin(v) + mid), vector<int>(begin(w), begin(w) + mid), W);
    vector<pair<int, int>> subSol2 = last(vector<int>(begin(v) + mid, end(v)), vector<int>(begin(w) + mid, end(w)), W);
    

    pair<int, int> best = { -1, -1 };
    for (int i = 0; i <= W; ++i) {
        //maximum the value and the capacity
        best = max(best, { subSol1[i].first + subSol2[W - i].first, i });
    }
    if(k != best.second)
        k = best.second;
    cout << best.first << " " << best.second << endl;

    vector<int> solution;   
    if (subSol1[k].second != -1) {
        
        //get the chosen item
        int iChosen = subSol1[best.second].second;

        //continue recursion after delete capacity after choosing 
        solution = knapsack_dc(vector<int>(begin(v), begin(v) + iChosen), vector<int>(begin(w), begin(w) + iChosen), k - w[iChosen], offset);
        solution.push_back(subSol1[best.second].second + offset+1);
    }
    if (subSol2[W - k].second != -1) {
        
        //get the chosen item
        int iChosen = mid + subSol2[W - best.second].second;
        //continue recursion after delete capacity after choosing 
        auto subSolution = knapsack_dc(vector<int>(begin(v) + mid, begin(v) + iChosen), vector<int>(begin(w) + mid, begin(w) + iChosen), W - k - w[iChosen], offset + mid);
        //merge two arrays
        copy(begin(subSolution), end(subSolution), back_inserter(solution));
        //pushing index into sol
        solution.push_back(iChosen + offset+1);
    }

    return solution;
}

int main(){
    //small test
    vector<int> vect;
    
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
    
    int test2 = knapsack_opt(SW, smallW, smallV, Sn);
    vect = knapsack_dc(smallV,smallW, SW, 0);
    
   
    cout << "how " << test2 << endl;

    FILE * smallOut;
    smallOut = fopen("smallDCout.txt", "w+");
    fprintf(smallOut, "V %d\n", test2);
    fprintf(smallOut, "i %d\n", vect.size());
    for(int i = 0; i < vect.size(); i++){
        fprintf(smallOut, "%d\n", vect[i]);

    }

    fclose(smallOut);
    vect.clear();


    //medium test
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

    int test3 = knapsack_opt(MW, mediumW, mediumV, Mn);

    vect = knapsack_dc(mediumV, mediumW, MW, 0);


    FILE * mediumOut;
    mediumOut = fopen("mediumDCout.txt", "w+");
    fprintf(mediumOut, "V %d\n", test3);
    fprintf(mediumOut, "i %d\n", vect.size());
    for(int i = 0; i < vect.size(); i++){
        fprintf(mediumOut, "%d\n", vect[i]);

    }

    fclose(mediumOut);
    vect.clear();
   
    
    cout << "how " << test3 << endl;

    //large test
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
    int test4 = knapsack_opt(LW, largeW, largeV, Ln);
    vect = knapsack_dc(largeV, largeW, LW, 0);



    FILE * largeOut;
    largeOut = fopen("largeDCout.txt", "w+");
    fprintf(largeOut, "V %d\n", test4);
    fprintf(largeOut, "i %d\n", vect.size());
    for(int i = 0; i < vect.size(); i++){
        fprintf(largeOut, "%d\n", vect[i]);

    }

    fclose(largeOut);


    vect.clear();
   
    
    cout << "how " << test4 << endl;
    
}