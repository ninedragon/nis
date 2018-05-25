package com.zz.common.model;

public class Opalarmdata {
    private String cDistrictbcdid;

    private Integer cAddressid;

    private Integer cRecorddatebcd;

    private Integer cRtcerrtimes;

    private Integer cNorflasherrtimes;

    private Integer cSensorvarerrbits;

    private Integer cRestarttimes;

    private Integer cTotalauthtimes;

    private String cRecordinserttime;

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

    public Integer getcRtcerrtimes() {
        return cRtcerrtimes;
    }

    public void setcRtcerrtimes(Integer cRtcerrtimes) {
        this.cRtcerrtimes = cRtcerrtimes;
    }

    public Integer getcNorflasherrtimes() {
        return cNorflasherrtimes;
    }

    public void setcNorflasherrtimes(Integer cNorflasherrtimes) {
        this.cNorflasherrtimes = cNorflasherrtimes;
    }

    public Integer getcSensorvarerrbits() {
        return cSensorvarerrbits;
    }

    public void setcSensorvarerrbits(Integer cSensorvarerrbits) {
        this.cSensorvarerrbits = cSensorvarerrbits;
    }

    public Integer getcRestarttimes() {
        return cRestarttimes;
    }

    public void setcRestarttimes(Integer cRestarttimes) {
        this.cRestarttimes = cRestarttimes;
    }

    public Integer getcTotalauthtimes() {
        return cTotalauthtimes;
    }

    public void setcTotalauthtimes(Integer cTotalauthtimes) {
        this.cTotalauthtimes = cTotalauthtimes;
    }

    public String getcRecordinserttime() {
        return cRecordinserttime;
    }

    public void setcRecordinserttime(String cRecordinserttime) {
        this.cRecordinserttime = cRecordinserttime == null ? null : cRecordinserttime.trim();
    }
}