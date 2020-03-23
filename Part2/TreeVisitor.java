// The classes are basically the same as the BinaryTree 
// file except the visitor classes and the accept method
// in the Tree class

class TreeVisitor{
    public static void main(String[] a){
	System.out.println(1);
    }
}



class Tree{
    Tree left ;
    Tree right;

    public boolean Init(int v_key){
	int key;
	key = v_key ;
	// has_left = false ;
	// has_right = false ;
	return true ;
    }

    public int accept(Visitor v){
	int nti ;

	System.out.println(333);
	nti = v.visit(this) ;
	return 0 ;
    }

}

  

class Visitor {
    Tree l ;
    Tree r ;

    public int visit(Tree n){
	int nti ;

	if (n.GetHas_Right()){
	    r = n.GetRight() ;
	    nti = r.accept(this) ; }
	else nti = 0 ;

	if (n.GetHas_Left()) {
	    l = n.GetLeft(); 
	    nti = l.accept(this) ; }
	else nti = 0 ;

	return 0;
    }

}


class MyVisitor extends Visitor {

    public int visita(Tree n){
	int nti ;

	if (n.GetHas_Right()){
	    r = n.GetRight() ;
	    nti = r.accept(this) ; }
	else nti = 0 ;

	System.out.println(n.GetKey());

	if (n.GetHas_Left()) {
	    l = n.GetLeft(); 
	    nti =l.accept(this) ; }
	else nti = 0 ;

	return 0;
    }

}
