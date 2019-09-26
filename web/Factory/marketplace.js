class FactMarketPlace extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new mpMarketplaceSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactMarketPlaceRun = new FactMarketPlace();