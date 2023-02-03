package CSC301;

public class Division{
    
    public static void main(String[] args) {
        int[] test = new int[2];
        test = divide(11, 2);
        System.out.println("the quotient will be: " + test[0]);
        System.out.println("the remainder will be: " + test[1]);


        
    }
    static int[] divide(int x, int y){
        int[] ans = new int[2];
        if(x == 0)
            return ans;
        ans = divide((int)Math.floor(x / 2), y);
        ans[0] *= 2;
        ans[1] *= 2;

        if(x % 2 == 1)
            ans[1] += 1;
        if(ans[1] > y || ans[1] == y){
            ans[1] -= y;
            ans[0] += 1;
        }
        return ans;
    }
}