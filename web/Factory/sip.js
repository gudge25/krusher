class FactSIP extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
		let model = { limit : 1000, sorting: `ASC`,isActive : null };
        new astSippeersSrv().getFind(model,x => { 
            this.result.data = x.filter( x => x.isActive);
            this.result.dataAll = x;
            //For pick sip from em
	        if(x) {
                this.result.data2 = this.result.data.filter( x => x.emID === null);
            }
        
        });
    }
}
const FactSIPRun = new FactSIP();