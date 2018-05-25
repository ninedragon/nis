package com.zz.common.model;

public class Deviceinfo extends DeviceinfoKey {
    private Integer cChannelnum;

    private String cHardwarever;

    private String cSoftwarever;

    private String cFixip;

    private String cLastcomtime;

    private String cSoftupdatedate;

    private String cInstalldate;

    private String cDesp;
    
    private String recorddateRange;

    public String getRecorddateRange() {
		return recorddateRange;
	}

	public void setRecorddateRange(String recorddateRange) {
		this.recorddateRange = recorddateRange;
	}

	public Integer getcChannelnum() {
        return cChannelnum;
    }

    public void setcChannelnum(Integer cChannelnum) {
        this.cChannelnum = cChannelnum;
    }

    public String getcHardwarever() {
        return cHardwarever;
    }

    public void setcHardwarever(String cHardwarever) {
        this.cHardwarever = cHardwarever == null ? null : cHardwarever.trim();
    }

    public String getcSoftwarever() {
        return cSoftwarever;
    }

    public void setcSoftwarever(String cSoftwarever) {
        this.cSoftwarever = cSoftwarever == null ? null : cSoftwarever.trim();
    }

    public String getcFixip() {
        return cFixip;
    }

    public void setcFixip(String cFixip) {
        this.cFixip = cFixip == null ? null : cFixip.trim();
    }

    public String getcLastcomtime() {
        return cLastcomtime;
    }

    public void setcLastcomtime(String cLastcomtime) {
        this.cLastcomtime = cLastcomtime == null ? null : cLastcomtime.trim();
    }

    public String getcSoftupdatedate() {
        return cSoftupdatedate;
    }

    public void setcSoftupdatedate(String cSoftupdatedate) {
        this.cSoftupdatedate = cSoftupdatedate == null ? null : cSoftupdatedate.trim();
    }

    public String getcInstalldate() {
        return cInstalldate;
    }

    public void setcInstalldate(String cInstalldate) {
        this.cInstalldate = cInstalldate == null ? null : cInstalldate.trim();
    }

    public String getcDesp() {
        return cDesp;
    }

    public void setcDesp(String cDesp) {
        this.cDesp = cDesp == null ? null : cDesp.trim();
    }
}