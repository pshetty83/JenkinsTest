public with sharing class IoT_MotorTest {

	//Constructor
	public IoT_MotorTest() {

	}

	public void stop(){
		this.insertMessage('no');
		system.debug('this is to test the CI');
	}

	public void start(){
		this.insertMessage('yes');
	}	

    public void insertMessage(String run) {
        Motor__c m = new Motor__c();
        m.Run__c = run;
        insert m;
    }

}