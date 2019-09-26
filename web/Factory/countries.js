class FactCountries extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        let model = a ? { langID : a , limit : 1000, sorting: `ASC` , isActive : true} : {};
        new regCountrySrv().getFind(model,x => { this.result.data = x; /*if(this.result.data.length > 0) this.result.data.unshift( {cID: null, cName: "- Страны -"});*/  });
    }
}
const FactCountriesRun = new FactCountries();