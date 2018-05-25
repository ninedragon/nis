package com.zz.common.model;

public class TestopdataKey {
    private String cDistrictbcdid;

    private Integer cAddressid;

    private Integer cRecorddatebcd;

    private Integer cMinute;

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

    public Integer getcRecorddatebcd() {
        return cRecorddatebcd;
    }

    public void setcRecorddatebcd(Integer cRecorddatebcd) {
        this.cRecorddatebcd = cRecorddatebcd;
    }

    public Integer getcMinute() {
        return cMinute;
    }

    public void setcMinute(Integer cMinute) {
        this.cMinute = cMinute;
    }

    public Integer getcIntrusiveboxid() {
        return cIntrusiveboxid;
    }

    public void setcIntrusiveboxid(Integer cIntrusiveboxid) {
        this.cIntrusiveboxid = cIntrusiveboxid;
    }
}