package com.zz.common.model;

public class Eeclassification {
    private String cEehexid;

    private String cEeclassificationname;

    private Integer cEegrpid;

    private String cDesp;

    public String getcEehexid() {
        return cEehexid;
    }

    public void setcEehexid(String cEehexid) {
        this.cEehexid = cEehexid == null ? null : cEehexid.trim();
    }

    public String getcEeclassificationname() {
        return cEeclassificationname;
    }

    public void setcEeclassificationname(String cEeclassificationname) {
        this.cEeclassificationname = cEeclassificationname == null ? null : cEeclassificationname.trim();
    }

    public Integer getcEegrpid() {
        return cEegrpid;
    }

    public void setcEegrpid(Integer cEegrpid) {
        this.cEegrpid = cEegrpid;
    }

    public String getcDesp() {
        return cDesp;
    }

    public void setcDesp(String cDesp) {
        this.cDesp = cDesp == null ? null : cDesp.trim();
    }
}