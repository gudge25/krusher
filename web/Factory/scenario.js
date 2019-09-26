class FactScenario extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astScenarioSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactScenarioRun = new FactScenario();