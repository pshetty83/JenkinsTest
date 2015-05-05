/*Author: Yael Perez
* Description: This class acts as the controller for the MyDeals and My Quotes screens.
*
*   ------------------------------------------------------------------------------
*   Date            Modified By             Description
*   ------------------------------------------------------------------------------
*   05/17/2014      Yael Perez              Created new class
*	06/11/2014		Pradeep Shetty			Updated query
*/

public with sharing class i8_OpportunityListController {
	//Current Deals Search Term variable
		public String currentDealsSearchTerm {get; set;}

	//Won Deals Search Term variable
		public String wonDealsSearchTerm {get; set;}

	//Quotes Search Term variable
		public String quotesSearchTerm {get; set;}

	//Search String Variable
	private String searchString {get; set;}

	//Variable to bind with Current Deals table on the screen
    public list<Opportunity> currentDeals {

		/*Getter Method: Gets the list of all Opportunities in 'Negotiation/Review' stage. 
						 This populates the 'Current Deals' table. If a search term is provided the query filters the list accordingly.
						 If an error occurs in fetching the list an exception is thrown*/
        get {
            try {
            	//No search term provided
                if (currentDealsSearchTerm == null || currentDealsSearchTerm.equalsIgnoreCase('')) {
                	//Query the list of opportunities
                    this.currentDeals = [Select id, 
                    							CloseDate, 
                    							Amount, 
                    							StageName, 
                    							Contact_First_Name__c, 
                    							Contact_Last_Name__c, 
                    							Premium__c 
            							 from Opportunity 
            							 where StageName =: 'Negotiation/Review'
            							 limit 5];
                } 

                //Search term provided
                else {

                	//Set the generic search term
                	this.searchString = '%' + currentDealsSearchTerm +'%';

                	//DEBUG Statement
                	system.debug('*****Search String: ' + searchString);

                	//Query the list of opportunities
                    this.currentDeals = [Select id, 
                    							CloseDate, 
                    							Amount, 
                    							StageName, 
                    							Contact_First_Name__c, 
                    							Contact_Last_Name__c, 
                    							Premium__c 
            							 from Opportunity 
            							 where StageName =: 'Negotiation/Review' 
            							 AND (Contact_First_Name__c LIKE :searchString 
            							 	  OR Contact_Last_Name__c LIKE :searchString)
										 limit 5];
					                	//DEBUG Statement

                	system.debug('*****currentDeals: ' + currentDeals);										 
                }

            } catch (Exception e) {
                throw new QueryException('Unable to retrieve deals');
            }

            //Return the result
            return this.currentDeals;

        }

        /*Setter Method*/
        private set;
    }

	//Variable to bind with Won Deals table on the screen    
    public list<Opportunity> closedWonDeals {
		/*Getter Method: Gets the list of all Opportunities in 'Closed/Won' stage. 
				 		 This populates the 'Won Deals' table. If a search term is provided the query filters the list accordingly.
				 		 If an error occurs in fetching the list an exception is thrown*/
        get {
            try {
            	//Search term not provided
                if (wonDealsSearchTerm == null || wonDealsSearchTerm.equalsIgnoreCase('')) {
                	//Query the list of opportunities
                    this.closedWonDeals = [Select id, 
                    							  CloseDate, 
                    							  Amount, 
                    							  StageName, 
                    							  Contact_First_Name__c, 
                    							  Contact_Last_Name__c, 
                    							  Premium__c 
            							     from Opportunity 
            							     where StageName =: 'Closed Won'
            							     limit 5];
                } 
                //Search term provided
                else {

                	//Set the generic search term
                	this.searchString = '%' + wonDealsSearchTerm + '%';

            		//Query the list of opportunities
                    this.closedWonDeals = [Select id, 
                    							  CloseDate, 
                    							  Amount, 
                    							  StageName, 
                    							  Contact_First_Name__c, 
                    							  Contact_Last_Name__c, 
                    							  Premium__c 
                						   from Opportunity 
                						   where StageName =: 'Closed Won' 
                						   AND (Contact_First_Name__c LIKE :searchString 
                						   	    OR Contact_Last_Name__c LIKE :searchString)
										   limit 5];
                }

            } catch (Exception e) {
                throw new QueryException('Unable to retrieve deals');
            }

            //Return the result
            return this.closedWonDeals;

        }

        /*Setter Method*/
        private set;
    }

	//Variable to bind with Won Deals table on the screen 
    public list<Quote> pipeline {
		/*Getter Method: Gets the list of all Quotes in 'Qualification' stage. 
		 				 This populates the 'Won Deals' table. If a search term is provided the query filters the list accordingly.
		 				 If an error occurs in fetching the list an exception is thrown*/
        get {
            try {
            	//Search term provided
                if (quotesSearchTerm == null || quotesSearchTerm.equalsIgnoreCase('')) {
                   //Query the list of Quotes
                   this.pipeline = [Select id, 
                   					       Opportunity.CloseDate, 
                   					       TotalPrice, 
                   					       Opportunity.Contact_First_Name__c, 
                   					       Opportunity.Premium__c, 
                   					       Opportunity.Contact_Last_Name__c,
                   					       Opportunity.StageName,
                   					       Opportunity.id,
                   					       Coverage_Amount__c 
           					         from Quote where Opportunity.StageName =: 'Qualification'
                                     order by createddate desc
           					         limit 20];
                } else {

                	//Set the generic search term
                	this.searchString= '%' + quotesSearchTerm + '%';

                	//Query the list of Quotes
                    this.pipeline = [Select id, 
                    						Opportunity.CloseDate, 
                    						TotalPrice, 
                    						Opportunity.Contact_First_Name__c, 
                    						Opportunity.Premium__c, 
                    						Opportunity.Contact_Last_Name__c, 
                    						Opportunity.StageName,
                    						Opportunity.id,
                    						Coverage_Amount__c  
            						 from Quote 
            						 where Opportunity.StageName =: 'Qualification' 
            						 AND (Opportunity.Contact_First_Name__c LIKE :searchString 
            						 	  OR Opportunity.Contact_Last_Name__c LIKE :searchString)
                                     order by createddate desc
									 limit 20];
                }

            } catch (Exception e) {
                throw new QueryException('Unable to retrieve Pipeline quotes');
            }

            //Return the result
            return this.pipeline;
        }

        /*Setter Method*/
        private set;
    }

	/*This is an empty method which reloads the class varaibles, thereby refreshing required variables*/
	public void refresh() {}

	class QueryException extends Exception {}		
}