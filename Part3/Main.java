import syntaxtree.*;
import visitor.*;

public class Main {
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
//         System.out.println("Program parsed successfully");
         
         build_table prs = new build_table();
         root.accept(prs, "");
         
//         System.out.println(prs.myclasses);
//         System.out.println(prs.classfuncs);
//         System.out.println(prs.famtree);
//         System.out.println(prs.fnargs);
//         System.out.println(prs.ready);
         //System.out.println("Program type checked successfully");
         
         miniIR ir = new miniIR();         
         root.accept(ir, prs);
         System.out.println(ir.IR);
         
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 

