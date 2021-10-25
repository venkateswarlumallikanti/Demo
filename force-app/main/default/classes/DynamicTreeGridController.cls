 
public with sharing class DynamicTreeGridController {
    @AuraEnabled(cacheable=true)
    public static List<ContactWrapper> getTreeData(String accId){
        System.debug('accId');
       List<Contact> cont = [Select Id , Name,(Select Subject, WhoId from Tasks) from Contact where AccountId = :accId]; 
       
        List<ContactWrapper> aooo = new List<ContactWrapper>();
        for(Contact a : cont){
            ContactWrapper aWraper = new ContactWrapper() ; 
            aWraper.name =a.Name ;
            aWraper.label =a.Name ;
            aWraper.expanded =true ;
            List<Items> con1 = new List<Items>();
            for(Task c : a.Tasks){
               Items conWrapp = new Items();
                conWrapp.name = c.WhoId ;
                conWrapp.label = c.Subject ;
                conWrapp.expanded = true ;
                con1.add(conWrapp);
            }
            aWraper.items = con1;
            aooo.add(aWraper);
        }
       return aooo;
    }
    public Class ContactWrapper{
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public String label{get;set;}
        @AuraEnabled
        public Boolean expanded{get;set;}
        @AuraEnabled
        public List<Items> items{get;set;}
    }
    public Class Items{
       @AuraEnabled
       public String name{get;set;}
       @AuraEnabled
       public String label{get;set;}
       @AuraEnabled
       public Boolean expanded{get;set;}
   }
}