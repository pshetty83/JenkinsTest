/*Author: Pradeep Shetty
* Description: This class acts as the controller for the Payment Calculator screen.
*
*   ------------------------------------------------------------------------------
*   Date            Modified By             Description
*   ------------------------------------------------------------------------------
*   05/28/2014      Yael       				Created new class
*								
*/

public with sharing class I8_PremiumCalculatorController {

	//New Opportunity to be created
    public Opportunity newOppty { get; set; }

    //New Quote to be added to the opportunity
    public Quote newQuote {get; private set;}

    //Variable for Opportunity
    public String OpportunityId {get; set;}

    //List holding all states
    List<StateValue> states = this.getStates();

    //String variable for FirstName
	public String firstName {get;set;}

	//String variable for LastName
	public String lastName {get;set;}	

	//String variable for Address
	public String address {get;set;}

	//String variable for City
	public String city {get;set;}

	//String variable for State
	public String state {get;set;}	

	//String variable for zipcode
	public String zipcode {get;set;}

    //String variable for email
    public String buyerEmail {get;set;}    

	//String variable for Coverage Amount
	public Decimal coverageAmt {get;set;}				

	//String variable for Doctor Visits
	public Decimal docVisits {get;set;}

	//String variable for Weight
	public Decimal weight {get;set;}

	//String variable for Smoking
	public Decimal smoking {get;set;}		

	//String variable for premium
	public Decimal premium {get;set;}

    //Boolean variable for Confirmation Pop Up
    public Boolean displayPopUp {get;set;}

    //Boolean variable for Application Pop Up
    public Boolean displayApplication {get;set;}

    /**
     * Constructor
     */
    public I8_PremiumCalculatorController() 
    { 
        //Set the display pop up to false
        this.displayPopUp = false; 
        this.displayApplication = false;

        if(isNullStr(ApexPages.currentPage().getParameters().get('Id'))) {
          
          //Create a new opportunity
          newOppty = new Opportunity();
          
          //Initialize parameters
          this.coverageAmt = 0;
          this.docVisits = 1;
          this.weight = 0;
          this.smoking = 1;
          this.premium = 0;



        } else {
            this.OpportunityId = ApexPages.currentPage().getParameters().get('Id');
            try {
                this.newOppty = [Select id, 
                					    CloseDate, 
                					    Amount, 
                					    StageName, 
                					    Contact_First_Name__c, 
                					    Contact_Last_Name__c, 
                					    Gender__c, 
                					    Premium__c, 
                					    Payment_Frequency__c, 
                					    Coverage_Amount__c, 
                					    Contact_Address__c, 
                					    Contact_City__c,
                						Contact_Country__c, 
                						Contact_Postal_Code__c, 
                						Contact_State_Province__c, 
                						Contact_Email__c, 
                						Weight__c, 
                						Smoking__c,
                						Doctor_Visits__c, 
                						Credit_Check_Results__c
                FROM Opportunity WHERE Id =: this.OpportunityId];

                this.firstName = newOppty.Contact_First_Name__c;
                this.lastName = newOppty.Contact_Last_Name__c;
                this.address = newOppty.Contact_Address__c;
                this.city = newOppty.Contact_City__c;
                this.state = newOppty.Contact_State_Province__c;
                this.zipcode = newOppty.Contact_Postal_Code__c;
                this.buyerEmail = newOppty.Contact_Email__c;
                this.coverageAmt = newOppty.Coverage_Amount__c;
                this.docVisits = newOppty.Doctor_Visits__c;
                this.weight = newOppty.Weight__c;
                this.smoking = newOppty.Smoking__c;
                this.premium = newOppty.Premium__c;
            } catch (Exception ex) {
                throw new QueryException('Unable to fetch this opportunity');
            }
        }

    }

    /**
     * Saving the opportunity.
     * If the opportunity doesn't exist - a new one is created. otherwise - the existing opportunity is updated.
     */
    public void createOpportunity() {
    	system.debug('*****premium' + this.premium);
            RecordType rt;
            Account placeholderAccount;
        try {
            rt = [select Id from RecordType where DeveloperName = 'Simple'];
            placeholderAccount = [Select Id, Quotes_Placeholder__c from Account where Quotes_Placeholder__c =:true LIMIT 1];
        } catch (Exception ex) {
            throw new QueryException('Unable to fetch Opportunity record type or placeholder account record');
        }
        
        newOppty.RecordTypeId = rt.Id;
        newOppty.CloseDate = Date.today() + 90;
        newOppty.AccountId = placeholderAccount.Id;
        newOppty.ForecastCategoryName = 'Pipeline';
        newOppty.StageName = 'Qualification';
    	newOppty.Contact_First_Name__c=this.firstName; 
    	newOppty.Contact_Last_Name__c=this.lastName; 
    	newOppty.Contact_Address__c=this.address; 
    	newOppty.Contact_City__c=this.city; 
    	newOppty.Contact_State_Province__c=this.state; 
    	newOppty.Contact_Postal_Code__c=this.zipcode; 
        newOppty.Contact_Email__c = this.buyerEmail;
    	newOppty.Coverage_Amount__c=this.coverageAmt; 
    	newOppty.Doctor_Visits__c=this.docVisits; 
    	newOppty.Weight__c=this.weight; 
    	newOppty.Smoking__c=this.smoking; 
    	newOppty.Premium__c=this.premium; 
        newOppty.Name = newOppty.Contact_First_Name__c + ' ' + newOppty.Contact_Last_Name__c + ' ' + Date.today();

        upsert newOppty;
        this.createQuote();


    }

    /**
     * Create a quote record for the opportunity.
     * Note that a new quote is created ever time the "generate" or "save" button is clicked.
     */
    public Quote createQuote() {
    	system.debug('quote called');
        Pricebook2 pb;
        try {
            pb=[select Id from Pricebook2 where IsStandard =:true AND IsActive=:true Limit 1];
        } catch(Exception ex) {
            throw new QueryException('Unable to fetch PriceBook');
        }
        newQuote = new Quote();
        newQuote.OpportunityId = this.newOppty.Id;
        newQuote.Coverage_Amount__c = this.newOppty.Coverage_Amount__c;
        newQuote.Name = this.newOppty.Name;
        newQuote.Pricebook2Id=pb.Id;
        newQuote.ExpirationDate = newOppty.CloseDate;
        insert newQuote;
        this.displayPopUp = true;
        return newQuote;
    }

    public void emailQuote() {
        
    }

    /**
     * Helper
     */
    private static boolean isNullStr(String str)
    {
        if(str==null||str.trim().length() == 0 )
            return true;
        return false;   
    }

    /**
    * Method to close pop up
    */
    public void closePopup() {
        this.displayPopup = false;
        this.displayApplication = false;
    }

    /** 
    * Method to Open Application pop up
    */
    public void createApplication() {
        this.displayApplication = true;
    }

    /**
    * Method to populate States picklist
    */
    public List<StateValue> getStates() {
        List<StateValue> options = new List<StateValue>();
		options.add(new StateValue('','Select'));
		options.add(new StateValue('AL','Alabama'));
		options.add(new StateValue('AK','Alaska'));
		options.add(new StateValue('AZ','Arizona'));
		options.add(new StateValue('AR','Arkansas'));
		options.add(new StateValue('CA','California'));
		options.add(new StateValue('CO','Colorado'));
		options.add(new StateValue('CT','Connecticut'));
		options.add(new StateValue('DE','Delaware'));
		options.add(new StateValue('DC','District Of Columbia'));
		options.add(new StateValue('FL','Florida'));
		options.add(new StateValue('GA','Georgia'));
		options.add(new StateValue('HI','Hawaii'));
		options.add(new StateValue('ID','Idaho'));
		options.add(new StateValue('IL','Illinois'));
		options.add(new StateValue('IN','Indiana'));
		options.add(new StateValue('IA','Iowa'));
		options.add(new StateValue('KS','Kansas'));
		options.add(new StateValue('KY','Kentucky'));
		options.add(new StateValue('LA','Louisiana'));
		options.add(new StateValue('ME','Maine'));
		options.add(new StateValue('MD','Maryland'));
		options.add(new StateValue('MA','Massachusetts'));
		options.add(new StateValue('MI','Michigan'));
		options.add(new StateValue('MN','Minnesota'));
		options.add(new StateValue('MS','Mississippi'));
		options.add(new StateValue('MO','Missouri'));
		options.add(new StateValue('MT','Montana'));
		options.add(new StateValue('NE','Nebraska'));
		options.add(new StateValue('NV','Nevada'));
		options.add(new StateValue('NH','New Hampshire'));
		options.add(new StateValue('NJ','New Jersey'));
		options.add(new StateValue('NM','New Mexico'));
		options.add(new StateValue('NY','New York'));
		options.add(new StateValue('NC','North Carolina'));
		options.add(new StateValue('ND','North Dakota'));
		options.add(new StateValue('OH','Ohio'));
		options.add(new StateValue('OK','Oklahoma'));
		options.add(new StateValue('OR','Oregon'));
		options.add(new StateValue('PA','Pennsylvania'));
		options.add(new StateValue('RI','Rhode Island'));
		options.add(new StateValue('SC','South Carolina'));
		options.add(new StateValue('SD','South Dakota'));
		options.add(new StateValue('TN','Tennessee'));
		options.add(new StateValue('TX','Texas'));
		options.add(new StateValue('UT','Utah'));
		options.add(new StateValue('VT','Vermont'));
		options.add(new StateValue('VA','Virginia'));
		options.add(new StateValue('WA','Washington'));
		options.add(new StateValue('WV','West Virginia'));
		options.add(new StateValue('WI','Wisconsin'));
		options.add(new StateValue('WY','Wyoming'));

        return options;
    }

    public void refresh(){

    }

    class StateValue {
    	public String id {get;set;}
    	public String description {get;set;}

    	public StateValue(String id, String description){
    		this.id = id;
    		this.description = description;
    	}
    }

    class QueryException extends Exception {}
}