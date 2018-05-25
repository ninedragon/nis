package com.zz.common.model;

public class Deviceauthinfo {
    private String cDistrictbcdid;

    private Integer cAddressid;

    private String cAuthtime;

    private String cDeviceip;

    private Integer cDeviceport;

    private Integer cPoweronflag;

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

    public String getcAuthtime() {
        return cAuthtime;
    }

    public void setcAuthtime(String cAuthtime) {
        this.cAuthtime = cAuthtime == null ? null : cAuthtime.trim();
    }

    public String getcDeviceip() {
        return cDeviceip;
    }

    public void setcDeviceip(String cDeviceip) {
        this.cDeviceip = cDeviceip == null ? null : cDeviceip.trim();
    }

    public Integer getcDeviceport() {
        return cDeviceport;
    }

    public void setcDeviceport(Integer cDeviceport) {
        this.cDeviceport = cDeviceport;
    }

    public Integer getcPoweronflag() {
        return cPoweronflag;
    }

    public void setcPoweronflag(Integer cPoweronflag) {
        this.cPoweronflag = cPoweronflag;
    }
}