package com.zz.common.model;

public class TestdeviceinfoKey {
    private String cDistrictbcdid;

    private Integer cAddressid;

    private Integer cIntrusiveboxid;

    public String getcDistrictbcdid() {
        return cDistrictbcdid;
    }

    public void setcDistrictbcdid(String cDistrictbcdid) {
        this.cDistrictbcdid = cDistrictbcdid == null ? null : cDistrictbcdid.trim();
    }

    public Integer getcAddressid() {
        return cAddressid;
    }

    public void setcAddressid(Integer cAddressid) {
        this.cAddressid = cAddressid;
    }

    public Integer getcIntrusiveboxid() {
        return cIntrusiveboxid;
    }

    public void setcIntrusiveboxid(Integer cIntrusiveboxid) {
        this.cIntrusiveboxid = cIntrusiveboxid;
    }
}