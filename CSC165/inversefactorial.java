import java.util.Scanner;
import java.math.BigInteger;

import static java.lang.Math.floor;
import static java.lang.Math.log10;

public class inversefactorial {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        String str = scan.nextLine();
        BigInteger num = new BigInteger(str);
        int ans = 0;
        if(str.length() <= 7){
            int cool = Integer.parseInt(str);
            int test = 1;
            for (int i = 1; i < 10; i++) {
                test = test * i;
                if(cool == test){
                    ans = i;
                    break;
                }
            }
        }
        else{
            int n = 1;
            double digits = 0.0;
            while(true){
                digits += log10(n);
                if(floor(digits) + 1 == str.length()){
                    ans = n;
                    break;
                }
                n++;
            }

        }
        System.out.print(ans);
    }
}

