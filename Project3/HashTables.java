import java.util.HashSet;

public class HashTables{

    // Problem 4.
    public static void findSumPair(int target, int[] array){
        //TODO.
        int num1 = 0;
        int num2 = 0;
        int res = 0;
        HashSet<Integer> set = new HashSet<>();

        //make a map record the value.
        for (int i = 0; i < array.length; i++) {
            res = target - array[i];
            if(!set.contains(res)){
                set.add(res);
            }

        }

        for(int a : set){
            System.out.println(a);
        }
        for (int i = 0; i < array.length; i++) {
            res = target - array[i];
            if (set.contains(res)) {
                num1 = array[i];
                num2 = res;
                System.out.println("Pair Found: " + num1 + ", " + num2);
                return;
            }
        }

        System.out.println("Pair Not Found");
    }

    // Problem 5.
    public static int DistinctValues(int[] array){
        // TODO.

        //create a set to record the distinct value
        HashSet<Integer> set = new HashSet<>();

        //looping through the array and check the cond
        for (int i = 0; i < array.length; i++) {
            if(!set.contains(Math.abs(array[i]))){
                set.add(Math.abs(array[i]));

            }

        }


        return set.size();
    }

    public static void main(String[] args){
        // For your tests.
        HashTables table = new HashTables();
        int target = 6;
        int[] array = {5,2,3,4,1};
        table.findSumPair(target, array);
        int ans = table.DistinctValues(array);
        System.out.println(ans);

    }
}