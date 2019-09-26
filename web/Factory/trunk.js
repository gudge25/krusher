class FactTrunk extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astTrunkSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactTrunkRun = new FactTrunk();