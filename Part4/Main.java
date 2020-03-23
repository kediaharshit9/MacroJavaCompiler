import syntaxtree.*;
import visitor.*;

public class Main {
   public static void main(String [] args) {
      try {
         
       Node root = new MiniIRParser(System.in).Goal();
//       System.out.println("Program parsed successfully");
       
	       myDFS p = new myDFS();
	       root.accept(p, "");
        	
         System.out.println(p.IR);
       
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 

