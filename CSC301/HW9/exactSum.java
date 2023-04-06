// A Dynamic Programming solution for subset
// sum problem
import java.io.*;
class exactSum {

	// Returns true if there is a subset of
	// set[] with sum equal to given sum
	static boolean isSubsetSum(int set[], int n, int sum)
	{
		// The value of subset[i][j] will be
		// true if there is a subset of
		// set[0..j-1] with sum equal to i
		boolean subset[][] = new boolean[n+1][sum+1];

		// If sum is 0, then answer is true
		for (int i = 0; i <= n; i++)
			subset[i][0] = true;

		// If sum is not 0 and set is empty,
		// then answer is false
		for (int i = 1; i <= sum; i++)
			subset[0][i] = false;
        

		// Fill the subset table in bottom
		// up manner
		for (int i = 1; i <= n; i++) {
			for (int j = 1; j <= sum; j++) {
                if(subset[i-1][j]){
				    subset[i][j] = subset[i-1][j];
                    continue;
                }
                if(j >= set[i-1])
                    if(subset[i-1][j-set[i-1]])
                        subset[i][j] = subset[i-1][j - set[i-1]];
			}
		}

		 // uncomment this code to print table
		for (int i = 0; i <= sum; i++)
		{
		for (int j = 0; j <= n; j++)
			System.out.print(" " + subset[j][i]);
            System.out.println();
		} 

		return subset[n][sum];
	}

	/* Driver code*/
	public static void main(String args[])
	{
		int set[] = {2,3};
		int sum = 5;
		int n = set.length;
		if (isSubsetSum(set, n, sum) == true)
			System.out.println("Found a subset"
							+ " with given sum");
		else
			System.out.println("No subset with"
							+ " given sum");
	}
}

/* This code is contributed by Rajat Mishra */
