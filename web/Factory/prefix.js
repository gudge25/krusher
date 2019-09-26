class FactPrefix extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        //new regValidationSrv().getFind({},x => { this.result.data = x; });
    }
}
const FactPrefixRun = new FactPrefix();