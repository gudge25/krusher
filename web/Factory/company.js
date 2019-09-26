class FactCompany extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new crmCompanySrv().getFind(this.model,x => {
        	this.result.data = x; /* if(this.result.data.length > 0) this.result.data.unshift( {coID: null, coName: "- Компании -"}); */
        	//IF ROUTE exist
        	this.result.data2 = [];
        	    new astRouteOutSrv().getFind(this.model, cb => {
        	    	if(cb.length > 0){
        	    		this.result.data.forEach( e => {
                           	cb.forEach( e2 => {
                           		if(e2.coID && e.coID)
	                            	if(e.coID == e2.coID) this.result.data2.push(e);
	                        });
                        });
        	    	}
        		});
        });
    }
}
const FactCompanyRun = new FactCompany();