class emEmployeeRoleModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.roleID     = p.roleID;
        this.roleName   = p.roleName                ? p.roleName            : null;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)   : null;
        this.Permission = p.Permission              ? p.Permission          : null;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.roleID     = p.roleID      ? p.roleID      : lookUp(API.us.Sequence, 'roleID').seqValue;
        this.isActive   = isBoolean(p.isActive)     ? Boolean(p.isActive)   : true;
        return this;
    }
}