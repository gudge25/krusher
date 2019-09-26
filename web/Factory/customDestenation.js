class FactCustomDestenation extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astCustomDestinationSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactCustomDestenationRun = new FactCustomDestenation();