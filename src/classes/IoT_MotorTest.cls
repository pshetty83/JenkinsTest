public with sharing class IoT_MotorTest {

	//Constructor
	public IoT_MotorTest() {

	}

	public void stop(){
		this.insertMessage('no');
		system.debug('Hope this works');
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