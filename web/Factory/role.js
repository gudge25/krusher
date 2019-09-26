class FactRole extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new emEmployeeRoleSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactRoleRun = new FactRole();