package com.zz.common.model;

import java.io.Serializable;
import java.util.Date;

import net.sf.json.JSONObject;

public class UUser implements Serializable{
	private static final long serialVersionUID = 1L;
	//0:禁止登录
	public static final Long _0 = new Long(0);
	//1:有效
	public static final Long _1 = new Long(1);
	private Long id;
	/**昵称*/
    private String nickname;
    /**邮箱 | 登录帐号*/
    private String email;
    /**密码*/
    private transient String pswd;
    /**创建时间*/
    private Date createTime;
    /**最后登录时间*/
    private Date lastLoginTime;
    /**1:有效，0:禁止登录*/
    private Long status;
    private Long district;
    private Long address;
	private Long channel;
    private Long meter;
    private Long supply;
    private String location;
    private Long housenum;
    private Long sim;
    private String problem ;
    private String solution;
    private Date repairtime;
    private Long absid;
    private String version;
    //分页，为了bootstrap的page和limit
    private Integer limit;
    private Integer offset;

    public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	public Integer getOffset() {
		return offset;
	}
	public void setOffset(Integer offset) {
		this.offset = offset;
	}
	public Long getAbsid() {
		return absid;
	}
	public void setAbsid(Long absid) {
		this.absid = absid;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public Long getDistrict() {
		return district;
	}
	public void setDistrict(Long district) {
		this.district = district;
	}
	public Long getAddress() {
		return address;
	}
	public void setAddress(Long address) {
		this.address = address;
	}
	public Long getChannel() {
		return channel;
	}
	public void setChannel(Long channel) {
		this.channel = channel;
	}
	public Long getMeter() {
		return meter;
	}
	public void setMeter(Long meter) {
		this.meter = meter;
	}
	public Long getSupply() {
		return supply;
	}
	public void setSupply(Long supply) {
		this.supply = supply;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public Long getHousenum() {
		return housenum;
	}
	public void setHousenum(Long housenum) {
		this.housenum = housenum;
	}
	public Long getSim() {
		return sim;
	}
	public void setSim(Long sim) {
		this.sim = sim;
	}
	public String getProblem() {
		return problem;
	}
	public void setProblem(String problem) {
		this.problem = problem;
	}
	public String getSolution() {
		return solution;
	}
	public void setSolution(String solution) {
		this.solution = solution;
	}
	public Date getRepairtime() {
		return repairtime;
	}
	public void setRepairtime(Date repairtime) {
		this.repairtime = repairtime;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public static Long get0() {
		return _0;
	}
	public static Long get1() {
		return _1;
	}
   
    
	public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getEmail() {
        return email;
    }

    public Long getStatus() {
		return status;
	}
	public void setStatus(Long status) {
		this.status = status;
	}
	public void setEmail(String email) {
        this.email = email;
    }

    public String getPswd() {
        return pswd;
    }

    public void setPswd(String pswd) {
        this.pswd = pswd;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }
    
    public UUser() {}
    


//	public UUser(Long id, String nickname, String email, String pswd,
//			Date createTime, Date lastLoginTime, Long status, Long district,
//			Long address, Long channel, Long meter, Long supply,
//			String location, Long housenum, Long sim, String problem,
//			String solution, Date repairtime, Long absid, String version) {
//		super();
//		this.id = id;
//		this.nickname = nickname;
//		this.email = email;
//		this.pswd = pswd;
//		this.createTime = createTime;
//		this.lastLoginTime = lastLoginTime;
//		this.status = status;
//		this.district = district;
//		this.address = address;
//		this.channel = channel;
//		this.meter = meter;
//		this.supply = supply;
//		this.location = location;
//		this.housenum = housenum;
//		this.sim = sim;
//		this.problem = problem;
//		this.solution = solution;
//		this.repairtime = repairtime;
//		this.absid = absid;
//		this.version = version;
//	}
	public UUser(UUser user) {
		super();
		this.id = user.getId();
		this.nickname = user.getNickname();
		this.email = user.getEmail();
		this.pswd = user.getPswd();
		this.createTime = user.getCreateTime();
		this.lastLoginTime = user.getLastLoginTime();
		this.status = user.getStatus();
		this.district = user.getDistrict();
		this.address = user.getAddress();
		this.channel = user.getChannel();
		this.meter = user.getMeter();
		this.supply = user.getSupply();
		this.location = user.getLocation();
		this.housenum = user.getHousenum();
		this.sim = user.getSim();
		this.problem = user.getProblem();
		this.solution = user.getSolution();
		this.repairtime = user.getRepairtime();
		this.absid = user.getAbsid();
		this.version = user.getVersion();
		this.limit = user.getLimit();
		this.offset = user.getOffset();
	}
    public String toString(){
    	return JSONObject.fromObject(this).toString();
    }
}