class astConferenceSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.Conference, astConferenceModel, 'cfID');
    }
}