class FactFile extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new fsFileSrv().getFind(this.model,x => { this.result.data = x; /*if(this.result.data.length > 0) this.result.data.unshift( {ffID: null, ffName: "- Файлы -", isActive: true});*/ });
    }
}
const FactFileRun = new FactFile();