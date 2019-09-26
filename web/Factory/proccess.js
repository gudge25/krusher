class FactProccess extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
    	this.model.isActive = null;
        new astAutoProcessSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactProccessRun = new FactProccess();