class FactCallBack extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astCallBackSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactCallBackRun = new FactCallBack();