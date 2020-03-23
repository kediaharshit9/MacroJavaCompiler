import java.util.ArrayList;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;
import java.util.Set;
import java.util.Vector;

import syntaxtree.*;
import visitor.*;

public class P6 {
   public static void main(String [] args) {
      try {
         
       Node root = new MiniRAParser(System.in).Goal();
//       System.out.println("Program parsed successfully");
       
       mips p = new mips();
       root.accept(p,"");
       
       System.out.println(p.code);
        	

	       
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 

