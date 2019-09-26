class FactRecord extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astRecordSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactRecordRun = new FactRecord();