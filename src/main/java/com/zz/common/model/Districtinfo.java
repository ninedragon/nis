package com.zz.common.model;

public class Districtinfo {
    private String cDistrictbcdid;

    private String cDistrictname;

    private String cDesp;

    public String getcDistrictbcdid() {
        return cDistrictbcdid;
    }

    public void setcDistrictbcdid(String cDistrictbcdid) {
        this.cDistrictbcdid = cDistrictbcdid == null ? null : cDistrictbcdid.trim();
    }

    public String getcDistrictname() {
        return cDistrictname;
    }

    public void setcDistrictname(String cDistrictname) {
        this.cDistrictname = cDistrictname == null ? null : cDistrictname.trim();
    }

    public String getcDesp() {
        return cDesp;
    }

    public void setcDesp(String cDesp) {
        this.cDesp = cDesp == null ? null : cDesp.trim();
    }
}