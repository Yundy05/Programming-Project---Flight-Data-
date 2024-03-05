import java.util.Scanner;

public class HelloName {

	public static void main(String[] args) {
		System.out.print("What is your name? Again? Test Test Anothertest");
		Scanner input = new Scanner( System.in );
		String name = input.next();
		System.out.println("Hello " + name);
	}

}
