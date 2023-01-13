package CSC301;

public class Division{
    
    public static void main(String[] args) {
        System.out.println("Hello world");
        int[] test = new int[2];
        test = divide(0b1010, 0b10);
        System.out.println("the quotient will be: " + test[0]);
        System.out.println("the remainder will be: " + test[1]);


        
    }
    static int[] divide(int x, int y){
        int[] ans = new int[2];
        if(x == 0)
            return ans;
        ans = divide(x / 2, y);
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