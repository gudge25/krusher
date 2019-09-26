class FactDocsTypes extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new dcDocsTypesSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactDocsTypesRun = new FactDocsTypes();