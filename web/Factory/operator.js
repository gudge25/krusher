class FactOperator extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new regOperatorSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactOperatorRun = new FactOperator();