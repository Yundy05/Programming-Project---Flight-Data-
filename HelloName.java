import java.util.Scanner;

public class HelloName {

	public static void main(String[] args) {
		System.out.print("What is your name? Again? Test Test Anothertest");
		Scanner input = new Scanner( System.in );
		String name = input.next();
		for(int i =0; i<=999999999; i++)
		{
			String pattern = " ";
			for(int j = 0 ; j<i%10;j++)
			pattern += " ";
			System.out.println("Hello" +pattern+ name);
		}
	}

}
