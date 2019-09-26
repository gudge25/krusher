class FactTTS extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
		let model = { limit : 1000, sorting: `ASC`,isActive : true };
        new astTTSSrv().getFind(model,x => { this.result.data = x; });  //,cb => { this.data.data = cb;}
    }
}
const FactTTSRun = new FactTTS();