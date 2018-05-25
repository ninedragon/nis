package com.zz.common.model;

public class Eeclassificationgrp {
    private Integer cEegrpid;

    private String cEegrpname;

    public Integer getcEegrpid() {
        return cEegrpid;
    }

    public void setcEegrpid(Integer cEegrpid) {
        this.cEegrpid = cEegrpid;
    }

    public String getcEegrpname() {
        return cEegrpname;
    }

    public void setcEegrpname(String cEegrpname) {
        this.cEegrpname = cEegrpname == null ? null : cEegrpname.trim();
    }
}