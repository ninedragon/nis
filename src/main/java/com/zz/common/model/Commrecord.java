package com.zz.common.model;

public class Commrecord {
    private String cDistrictbcdid;

    private Integer cAddressid;

    private Integer cChannelid;

    private Integer cRecorddatebcd;

    private Integer cRecordhour;

    private String cRecordtime;

    private String cFramecmdid;

    private String cCommdesp;

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

    public Integer getcChannelid() {
        return cChannelid;
    }

    public void setcChannelid(Integer cChannelid) {
        this.cChannelid = cChannelid;
    }

    public Integer getcRecorddatebcd() {
        return cRecorddatebcd;
    }

    public void setcRecorddatebcd(Integer cRecorddatebcd) {
        this.cRecorddatebcd = cRecorddatebcd;
    }

    public Integer getcRecordhour() {
        return cRecordhour;
    }

    public void setcRecordhour(Integer cRecordhour) {
        this.cRecordhour = cRecordhour;
    }

    public String getcRecordtime() {
        return cRecordtime;
    }

    public void setcRecordtime(String cRecordtime) {
        this.cRecordtime = cRecordtime == null ? null : cRecordtime.trim();
    }

    public String getcFramecmdid() {
        return cFramecmdid;
    }

    public void setcFramecmdid(String cFramecmdid) {
        this.cFramecmdid = cFramecmdid == null ? null : cFramecmdid.trim();
    }

    public String getcCommdesp() {
        return cCommdesp;
    }

    public void setcCommdesp(String cCommdesp) {
        this.cCommdesp = cCommdesp == null ? null : cCommdesp.trim();
    }
}