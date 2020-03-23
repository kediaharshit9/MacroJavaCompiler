import syntaxtree.*;
import visitor.*;

public class P2 {
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
//         System.out.println("Program parsed successfully");
         
         DFS_table_RA p = new DFS_table_RA();
         root.accept(p, "");
         
         TYPE_check_RA t = new TYPE_check_RA();
         root.accept(t, p);
         
         System.out.println("Program type checked successfully");
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 

