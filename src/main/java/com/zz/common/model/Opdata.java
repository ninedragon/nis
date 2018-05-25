package com.zz.common.model;

public class Opdata extends OpdataKey {
    private Double cTkwh;
    //用于数据显示start
    private Double tbianshi;
	private Integer cTsegmentid;
	private String cTsegmentname;
	//用于总的数据显示end
    private Integer cFaultid;

    public Double getTbianshi() {
		return tbianshi;
	}

	public void setTbianshi(Double tbianshi) {
		this.tbianshi = tbianshi;
	}

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
		this.cTsegmentname = cTsegmentname;
	}

	private String cFramecmdid;

    private Double cEekwh;

    private Integer cEeopenminute;

    private Integer cEecloseminute;

    private Integer cEeopenclosetimes;

    private Double cEepeakw;

    private String cRecordinserttime;

    private Boolean cIsvalidrecord;

    public Double getcTkwh() {
        return cTkwh;
    }

    public void setcTkwh(Double cTkwh) {
        this.cTkwh = cTkwh;
    }

    public Integer getcFaultid() {
        return cFaultid;
    }

    public void setcFaultid(Integer cFaultid) {
        this.cFaultid = cFaultid;
    }

    public String getcFramecmdid() {
        return cFramecmdid;
    }

    public void setcFramecmdid(String cFramecmdid) {
        this.cFramecmdid = cFramecmdid == null ? null : cFramecmdid.trim();
    }

    public Double getcEekwh() {
        return cEekwh;
    }

    public void setcEekwh(Double cEekwh) {
        this.cEekwh = cEekwh;
    }

    public Integer getcEeopenminute() {
        return cEeopenminute;
    }

    public void setcEeopenminute(Integer cEeopenminute) {
        this.cEeopenminute = cEeopenminute;
    }

    public Integer getcEecloseminute() {
        return cEecloseminute;
    }

    public void setcEecloseminute(Integer cEecloseminute) {
        this.cEecloseminute = cEecloseminute;
    }

    public Integer getcEeopenclosetimes() {
        return cEeopenclosetimes;
    }

    public void setcEeopenclosetimes(Integer cEeopenclosetimes) {
        this.cEeopenclosetimes = cEeopenclosetimes;
    }

    public Double getcEepeakw() {
        return cEepeakw;
    }

    public void setcEepeakw(Double cEepeakw) {
        this.cEepeakw = cEepeakw;
    }

    public String getcRecordinserttime() {
        return cRecordinserttime;
    }

    public void setcRecordinserttime(String cRecordinserttime) {
        this.cRecordinserttime = cRecordinserttime == null ? null : cRecordinserttime.trim();
    }

    public Boolean getcIsvalidrecord() {
        return cIsvalidrecord;
    }

    public void setcIsvalidrecord(Boolean cIsvalidrecord) {
        this.cIsvalidrecord = cIsvalidrecord;
    }
}