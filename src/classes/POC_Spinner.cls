public with sharing class POC_Spinner
{
    public ApexPages.StandardController ctr;
    public Motor__c mot;
    public POC_Spinner(ApexPages.StandardController std)
    {
        this.ctr = std;
        mot = (Motor__c)ctr.getRecord();        
    }
    
    public PageReference autorun()
    {
        mot.addError('Error Added via visualforce');
        return ctr.view().setRedirect(true);
        
    }
    
}