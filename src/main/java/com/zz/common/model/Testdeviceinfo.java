package com.zz.common.model;

public class Testdeviceinfo extends TestdeviceinfoKey {
    private String cEehexid;

    private String cEename;

    private String cEemeterbcdid;

    private String cDesp;

    public String getcEehexid() {
        return cEehexid;
    }

    public void setcEehexid(String cEehexid) {
        this.cEehexid = cEehexid == null ? null : cEehexid.trim();
    }

    public String getcEename() {
        return cEename;
    }

    public void setcEename(String cEename) {
        this.cEename = cEename == null ? null : cEename.trim();
    }

    public String getcEemeterbcdid() {
        return cEemeterbcdid;
    }

    public void setcEemeterbcdid(String cEemeterbcdid) {
        this.cEemeterbcdid = cEemeterbcdid == null ? null : cEemeterbcdid.trim();
    }

    public String getcDesp() {
        return cDesp;
    }

    public void setcDesp(String cDesp) {
        this.cDesp = cDesp == null ? null : cDesp.trim();
    }
}