class FactIVR extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astIVRConfigSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactIVRRun = new FactIVR();