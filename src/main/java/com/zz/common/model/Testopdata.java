package com.zz.common.model;

public class Testopdata extends TestopdataKey {
    private Integer cTsegmentid;

    private Double cIblastmtkwh;

    private Double cIbcurrmtkwh;

    private Double cIbkwh;

    private Double cIblastmtkvarh;

    private Double cIbcurrmtkvarh;

    private Double cIbkvarh;

    private String cRecordinserttime;

    public Integer getcTsegmentid() {
        return cTsegmentid;
    }

    public void setcTsegmentid(Integer cTsegmentid) {
        this.cTsegmentid = cTsegmentid;
    }

    public Double getcIblastmtkwh() {
        return cIblastmtkwh;
    }

    public void setcIblastmtkwh(Double cIblastmtkwh) {
        this.cIblastmtkwh = cIblastmtkwh;
    }

    public Double getcIbcurrmtkwh() {
        return cIbcurrmtkwh;
    }

    public void setcIbcurrmtkwh(Double cIbcurrmtkwh) {
        this.cIbcurrmtkwh = cIbcurrmtkwh;
    }

    public Double getcIbkwh() {
        return cIbkwh;
    }

    public void setcIbkwh(Double cIbkwh) {
        this.cIbkwh = cIbkwh;
    }

    public Double getcIblastmtkvarh() {
        return cIblastmtkvarh;
    }

    public void setcIblastmtkvarh(Double cIblastmtkvarh) {
        this.cIblastmtkvarh = cIblastmtkvarh;
    }

    public Double getcIbcurrmtkvarh() {
        return cIbcurrmtkvarh;
    }

    public void setcIbcurrmtkvarh(Double cIbcurrmtkvarh) {
        this.cIbcurrmtkvarh = cIbcurrmtkvarh;
    }

    public Double getcIbkvarh() {
        return cIbkvarh;
    }

    public void setcIbkvarh(Double cIbkvarh) {
        this.cIbkvarh = cIbkvarh;
    }

    public String getcRecordinserttime() {
        return cRecordinserttime;
    }

    public void setcRecordinserttime(String cRecordinserttime) {
        this.cRecordinserttime = cRecordinserttime == null ? null : cRecordinserttime.trim();
    }
}