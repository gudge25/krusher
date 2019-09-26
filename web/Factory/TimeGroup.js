class FactTimeGroup extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astTimeGroupSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactTimeGroupRun = new FactTimeGroup();