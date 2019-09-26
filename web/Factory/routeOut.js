class FactRouteOut extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astRouteOutSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactRouteOutRun = new FactRouteOut();