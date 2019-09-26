class FactTrunkPool extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astTrunkPoolSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactTrunkPoolRun = new FactTrunkPool();