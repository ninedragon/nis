package com.zz.common.model;

public class OpdataKey {
    private String cDistrictbcdid;

    private Integer cAddressid;

    private Integer cRecorddatebcd;

    private Integer cTsegmentid;

    private Integer cChannelid;

    private String cEehexid;

    private Integer cEesequenceid;

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

    public Integer getcTsegmentid() {
        return cTsegmentid;
    }

    public void setcTsegmentid(Integer cTsegmentid) {
        this.cTsegmentid = cTsegmentid;
    }

    public Integer getcChannelid() {
        return cChannelid;
    }

    public void setcChannelid(Integer cChannelid) {
        this.cChannelid = cChannelid;
    }

    public String getcEehexid() {
        return cEehexid;
    }

    public void setcEehexid(String cEehexid) {
        this.cEehexid = cEehexid == null ? null : cEehexid.trim();
    }

    public Integer getcEesequenceid() {
        return cEesequenceid;
    }

    public void setcEesequenceid(Integer cEesequenceid) {
        this.cEesequenceid = cEesequenceid;
    }
}