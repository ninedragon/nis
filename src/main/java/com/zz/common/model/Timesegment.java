package com.zz.common.model;

public class Timesegment {
    private Integer cTsegmentid;

    private String cTsegmentname;

    public Integer getcTsegmentid() {
        return cTsegmentid;
    }

    public void setcTsegmentid(Integer cTsegmentid) {
        this.cTsegmentid = cTsegmentid;
    }

    public String getcTsegmentname() {
        return cTsegmentname;
    }

    public void setcTsegmentname(String cTsegmentname) {
        this.cTsegmentname = cTsegmentname == null ? null : cTsegmentname.trim();
    }
}