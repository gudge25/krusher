class FactRegions extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
    	let model = a ? { cID : a , limit : 1000, sorting: `ASC` } : {};
        new regRegionSrv().getFind(model,x => { this.result.data = x; /*if(this.result.data.length > 0) this.result.data.unshift( {rgID: null, rgName: "- Регионы -"});*/ });
    }
}
const FactRegionsRun = new FactRegions();