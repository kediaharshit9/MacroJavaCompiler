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

public class P5 {
   public static void main(String [] args) {
      try {
         
       Node root = new microIRParser(System.in).Goal();
//       System.out.println("Program parsed successfully");
       
	       get_params p = new get_params();
	       root.accept(p, "");
        	
//	       System.out.println(p.uses);
//	       System.out.println(p.defs);
//	       System.out.println(p.succs);
//	       System.out.println(p.lblpos);

//	       System.out.println("\n\n");
//         System.out.println("TEMPS " + p.temps + "\n");
	       
	       //find the in and out for each node in each function
	       
	       Iterator u = p.uses.entrySet().iterator();
	       Iterator d = p.defs.entrySet().iterator();
	       Iterator s = p.succs.entrySet().iterator();
	       Iterator l = p.lblpos.entrySet().iterator();
	  
	       Hashtable <String, ArrayList <Set<String>>> func_ins = new Hashtable < String, ArrayList <Set<String>>> ();
	       Hashtable <String, ArrayList <Set<String>>> func_outs =new Hashtable < String, ArrayList <Set<String>>> (); 
	       while (u.hasNext())
	       {
	    	   Map.Entry map1 = (Map.Entry) u.next();
	    	   Map.Entry map2= (Map.Entry) d.next();
	    	   Map.Entry map3 = (Map.Entry) s.next();
	    	   Map.Entry map4 = (Map.Entry) l.next();
	    	   
	    	   String fn = (String) map1.getKey();
	    	   Vector <Set<String>> use = (Vector<Set<String>>) map1.getValue(); 
	    	   Vector <Set<String>> def = (Vector<Set<String>>) map2.getValue();
	    	   Hashtable <Integer, Vector <String>> su = (Hashtable<Integer, Vector<String>>) map3.getValue();
	    	   Hashtable <String, Integer> lbls = (Hashtable<String, Integer>) map4.getValue();
	    	   
	    	   int lno = use.size();
//	    	   System.out.println(lno);
	    	   
	    	   ArrayList <Set <String>> in1  = new ArrayList <Set <String>> (lno);
	    	   ArrayList <Set <String>> out1 = new ArrayList <Set <String>> (lno);
	    	   
	    	   ArrayList <Set <String>> in2  = new ArrayList <Set <String>> (lno);
	    	   ArrayList <Set <String>> out2 = new ArrayList <Set <String>> (lno);
	    	   
	    	   int  i;
	    	   for(i=0; i<lno; i++)
	    	   {
	    		   in1.add(i, new HashSet <String>());
	    		   out1.add(i, new HashSet<String>());
	    	   }
	    	   	    	   
	    	   int flag = 1;
	    	   do 
	    	   {
	    		   in2 = (ArrayList<Set<String>>) in1.clone();
		    	   out2 = (ArrayList<Set<String>>) out1.clone();
		    	   for(i=lno-1; i>=0; i--)
		    	   {
		    		   Set <String> ins = new HashSet<String> ();
		    		   Set <String> outs = new HashSet<String>();
		    		   
		    		   Set <String> usei = use.elementAt(i);
		    		   Set <String> defi = def.elementAt(i);
		    		   Vector <String> scc = su.get(i);
		    		   
		    		   
		    		   //add all successor "ins"
		    		   outs.addAll(defi);  // experimental
		    		   for(int j=0; j<scc.size(); j++)
		    		   {
		    			   String t1 = scc.elementAt(j);
		    			   if((t1.charAt(0) >= 'A' && t1.charAt(0) <= 'Z') || (t1.charAt(0) >= 'a' && t1.charAt(0) <= 'z'))
		    			   {
		    				   int nxt = lbls.get(t1);
		    				   outs.addAll(in1.get(nxt));
		    			   }
		    			   else
		    			   {
		    				   int nxt = Integer.parseInt(t1);
		    				   outs.addAll(in1.get(nxt));
		    			   }
		    		   }
//		    		   System.out.println(lno); 
		    		   ins.addAll(outs);
		    		   ins.removeAll(defi);
		    		   ins.addAll(usei);
		    		   
		    		   in1.remove(i);
		    		   in1.add(i, ins);
		    		   out1.remove(i);
		    		   out1.add(i, outs);  
		    	   }
		    	   
		    	   if(in1.equals(in2) && out1.equals(out2))
		    	   {
//		    		   System.out.println(lno); 
		    		   flag=0;
		    	   }
	    	   }while(flag>0);
	    	   
	    	   func_ins.put(fn, in1);
	    	   func_outs.put(fn, out1);
	       }
//	       System.out.println(func_ins);
//	       System.out.println(func_outs);
//	       System.out.println("end of func inouts\n");
	       
//	       generate intervals for each temp in "temps"
	       
	       Hashtable <String, Hashtable <String, Integer>> leftend = new Hashtable <String, Hashtable <String, Integer>>();
	       Hashtable <String, Hashtable <String, Integer>> rightend= new Hashtable <String, Hashtable <String, Integer>>();
	       
	       Iterator t1 = func_ins.entrySet().iterator();
	       Iterator t2 = func_outs.entrySet().iterator();
	       while (t1.hasNext()) //iteratate over all functions
	       {
	    	   Map.Entry map1 = (Map.Entry) t1.next();
	    	   Map.Entry map2 = (Map.Entry) t2.next();
	    	   
	    	   String fn = (String) map1.getKey();
	    	   ArrayList <Set <String>> in1  = (ArrayList<Set<String>>) map1.getValue();
	    	   ArrayList <Set <String>> out1 = (ArrayList<Set<String>>) map2.getValue();
	    	   
	    	   Hashtable <String, Integer> left = new Hashtable <String, Integer>();
	    	   Hashtable <String, Integer> right= new Hashtable <String, Integer>();
	    	   
	    	   int i, sz =  in1.size();
	    	   
	    	   for(i=0; i<sz; i++)
	    	   {
	    		   Set<String> ins = in1.get(i);
	    		   Set<String> outs= out1.get(i);
	    		   
	    		   Iterator it1 = ins.iterator();
	    		   Iterator it2 =outs.iterator();
	    		   
	    		   while(it2.hasNext())
	    		   {
	    			   String tmp2 = (String) it2.next();
	    			   left.putIfAbsent(tmp2, i);
	    			   
	    			   if(right.containsKey(tmp2))
	    				   right.remove(tmp2);
	    			   right.put(tmp2, i);
	    		   }
	    		   while(it1.hasNext())
	    		   {
	    			   String tmp1 = (String) it1.next();
	    			   if(right.containsKey(tmp1))
	    			   {	
	    				   right.remove(tmp1);
	    			   }
	    			   right.put(tmp1, i);
	    		   }
	    		   
	    	   }
	    	   leftend.put(fn, left);
	    	   rightend.put(fn, right);
	    	      
	       }
	       
//	       System.out.println(leftend  + "\n");
//	       System.out.println(rightend + "\n\n");
	       
//	       got the interval for each temp for each function
//	       now do register allocation for each function
//	       
//	       int nreg = 18; //s0-s7, t0-t9
	       
	       	       
	       Iterator it1 = leftend.entrySet().iterator();
	       Iterator it2 = rightend.entrySet().iterator();
	       
	       Queue <String> regs;
	       int spill;
	       Hashtable <String, Hashtable <String, String>> reg_map = new Hashtable <String, Hashtable <String, String>>();
	       Hashtable <String, Integer> spillmax = new  Hashtable <String, Integer> ();
	       while  (it1.hasNext())
	       {
	    	   
	    	   regs = new LinkedList<>();
	    	   for(int i=0; i<8; i++)
	    	   {
	    		   regs.add("s"+Integer.toString(i));
	    	   }
	    	   for(int i=0; i<10; i++)
	    	   {
	    		   regs.add("t"+Integer.toString(i));
	    	   }
	    	   
	    	   Map.Entry map1 = (Map.Entry) it1.next();
	    	   Map.Entry map2 = (Map.Entry) it2.next();
	    	   
	    	   String fn = (String) map1.getKey();
	    	   Hashtable <String, Integer> l_end = (Hashtable<String, Integer>) map1.getValue();
	    	   Hashtable <String, Integer> r_end = (Hashtable<String, Integer>) map2.getValue();
//		       System.out.println(l_end );
//		       System.out.println(r_end);
	    	   int argno = (int) p.fnargs.get(fn);
	    	   if(argno>4)
	    		   argno = argno-4;
	    	   else
	    		   argno = 0;
	    	   
	    	   spill = 18 + argno;
	    	   int i, n_ints = l_end.size();
	    	   Set <String> active = new HashSet<String> ();
	    	   Hashtable <String, String> r_map =  new Hashtable <String, String>();
	    	   
	    	   for(i=0; i<n_ints; i++)
	    	   {
		    	   // find minimum in left and remove that temp, a llocate reg also
		    	   Iterator itr1 = l_end.entrySet().iterator();
		    	   int min = 999999999;
		    	   String minkey = "";
		    	   
		    	   while(itr1.hasNext())
		    	   {
			    	   Map.Entry hashes = (Map.Entry) itr1.next();
			    	   
			    	   String tmp = (String) hashes.getKey();
			    	   int st = (int) hashes.getValue();
			    	   
			    	   if(st<min)
			    	   {
			    		   min = st;
			    		   minkey = tmp;
			    	   }    	   
		    	   }
		    	   //get min temp at minkey
		    	   int start = min;
		    	   int end = r_end.get(minkey);
		    	   
		    	   //expire old intervals
		    	   Iterator itr2 = active.iterator();
		    	   Vector <String> toremove =  new Vector<String>();
		    	   while(itr2.hasNext())
		    	   {
		    		   String tmp = (String) itr2.next();
		    		   if(r_end.get(tmp) <= start)
		    		   {
//		    			   System.out.println("replacing "+ tmp + " " + r_end.get(tmp) + " " + end);
//		    			   active.remove(tmp);
		    			   toremove.add(tmp);
		    			   String ret_reg = r_map.get(tmp);
		    			   regs.add(ret_reg);
		    		   }
		    	   }
		    	   for(int j=0; j<toremove.size(); j++)
		    	   {
		    		   active.remove(toremove.elementAt(j));
//		    		   System.out.println("\n");
		    	   }
		    	   
		    	   //allocate register
		    	   
		    	   if(active.size()<18)
		    	   {
		    		   String newreg = regs.poll(); 
		    		   r_map.put(minkey, newreg);
		    		   active.add(minkey);
		    	   }
		    	   else
		    	   {
		    		   String newreg = Integer.toString(spill);
		    		   spill++;
		    		   r_map.put(minkey, newreg);
		    	   }
		    	   		    	   
		    	   l_end.remove(minkey);
		    	   
	    	   }
	    	   spillmax.put(fn, spill);
	    	   reg_map.put(fn, r_map);
	       }
//	       System.out.println(reg_map + "\n");
//	       System.out.println(spillmax + "\n");
	       //now that we have the reg_mapping, we parse to the code again to generate miniRA form
	       second par = new second();
	       par.fnargs = p.fnargs;
	       par.slots = spillmax;
	       par.reg_alc = reg_map;
	       root.accept(par, "");
	       
	       
	       convert_RA go = new convert_RA();
	       go.reg_map = par.reg_alc;
	       go.slots = par.slots;
	       go.fnargs = par.fnargs;
	       go.maxcall = par.maxcall;
	       go.relabel = p.relabel;
	       root.accept(go, "");
	       System.out.println(go.RA);
	       
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 

