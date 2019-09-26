class emEmployeeRoleSrv extends BaseSrv {
    constructor()
    {
        super(API.em.Employee.Role, emEmployeeRoleModel, 'roleID');
    }
}