public class ExceptionClass {
public static Boolean isbolval {get;set;}
public static void FirstMethod(List<case> lst){
 try{
 isbolval = true;
 updatecase(lst);
 }
 catch(exception ex){
  system.debug('dadasd111'+ex);
  }
}

public static void updatecase (List<case> lst) {
try{ 
    list<case> lst1 =[select id from case where id In :lst];
    system.debug('lst1>>>'+lst1 );
   //lst1;
  }
  
  catch(exception ex){
  system.debug('dadasd'+ex);
  throw ex;
  }
}

}