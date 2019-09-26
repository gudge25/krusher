class FactBases extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new fsBasesSrv().getFind(this.model,x => { this.result.data = x; /*if(this.result.data.length > 0) this.result.data.unshift( {dbID: null, dbName: "- Категории -"});*/ });
    }
}
const FactBasesRun = new FactBases();