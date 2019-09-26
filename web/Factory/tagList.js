class FactTag extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new crmTagSrv().getFind(this.model,x => { this.result.data = x;  });
    }
}
const FactTagRun = new FactTag();